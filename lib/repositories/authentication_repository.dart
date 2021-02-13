import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:habit_tracker/exceptions/exceptions.dart';
import 'package:habit_tracker/repositories/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:habit_tracker/models/user.dart' as model;
import 'package:habit_tracker/extensions/firebase_user.dart';

class AuthenticationRepository {
  AuthenticationRepository({
    @required UserRepository userRepository,
    FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignIn,
  })  : assert(userRepository != null),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  Stream<model.User> getUserStream() {
    return _firebaseAuth.userChanges().asyncMap((firebaseUser) async {
      if (firebaseUser != null) {
        model.User user = firebaseUser.toUserModel();
        return user;
      } else {
        return null;
      }
    });
  }

  Future<UserCredential> signUp({
    @required String email,
    @required String password,
    @required String name,
  }) async {
    assert(email != null && password != null);
    try {
      return await createUserWithEmailAndPassword(email, password, name);
    } on Exception {
      throw SignUpFailure();
    }
  }

  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    UserCredential credential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await credential.user.updateProfile(displayName: name);
    return credential;
  }

  Future<void> logInWithGoogle() async {
    try {
      await signInWithCredential();
    } on Exception {
      throw LogInWithGoogleFailure();
    }
  }

  Future<UserCredential> signInWithCredential() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await _firebaseAuth.signInWithCredential(credential);
  }

  Future<void> logInWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    try {
      await signInWithEmailAndPassword(email, password);
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logOut() async {
    try {
      await signOut();
    } on Exception {
      throw LogOutFailure();
    }
  }

  Future signOut() async {
    await Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<void> updateName(String name) async {
    await _firebaseAuth.currentUser.updateProfile(displayName: name);
  }
}
