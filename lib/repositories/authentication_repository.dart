import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:habit_tracker/exceptions/exceptions.dart';
import 'package:meta/meta.dart';
import 'package:habit_tracker/models/user.dart' as model;

class AuthenticationRepository {
  AuthenticationRepository({
    FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  Stream<model.User> getUsers() {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser != null ? firebaseUser.toUser : null;
    });
  }

  Future<void> signUp({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    try {
      await createUserWithEmailAndPassword(email, password);
    } on Exception {
      throw SignUpFailure();
    }
  }

  Future<UserCredential> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
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
}

extension on User {
  model.User get toUser {
    return model.User(
      id: uid,
      email: email,
      name: displayName,
      // TODO think about implementing this later
      // photo: photoURL,
    );
  }
}
