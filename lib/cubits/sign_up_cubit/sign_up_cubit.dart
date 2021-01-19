import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';
import 'package:habit_tracker/forms/inputs/confirmed_password.dart';
import 'package:habit_tracker/forms/inputs/email.dart';
import 'package:habit_tracker/forms/inputs/password.dart';
import 'package:habit_tracker/repositories/authentication_repository.dart';
import 'package:habit_tracker/repositories/user_repository.dart';
import 'package:habit_tracker/extensions/firebase_user.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(
    this._userRepository,
    this._authenticationRepository,
  )   : assert(_authenticationRepository != null),
        assert(_userRepository != null),
        super(const SignUpState());

  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.password,
        state.confirmedPassword,
      ]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(state.copyWith(
      password: password,
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.email,
        password,
        state.confirmedPassword,
      ]),
    ));
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(state.copyWith(
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.email,
        state.password,
        confirmedPassword,
      ]),
    ));
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await signUp();
      signIn();

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future createUserAfterSignUpAndSignIn() async {
    UserCredential userCred = await signUpAndSignInWithEmailAndPassword();
    User user = userCred.user;
    this._userRepository.addItem(user.toUserModel());
  }

  Future<UserCredential> signUpAndSignInWithEmailAndPassword() async {
    await signUp();
    return signIn();
  }

  Future<UserCredential> signIn() async {
    return _authenticationRepository.signInWithEmailAndPassword(
      state.email.value,
      state.password.value,
    );
  }

  Future signUp() async {
    await _authenticationRepository.signUp(
      email: state.email.value,
      password: state.password.value,
    );
  }
}
