import 'package:bloc_test/bloc_test.dart';
import 'package:formz/formz.dart';
import 'package:habit_tracker/cubits/login_cubit/login_cubit.dart';
import 'package:habit_tracker/forms/inputs/email.dart';
import 'package:habit_tracker/forms/inputs/password.dart';
import 'package:habit_tracker/repositories/authentication_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

Email defaultEmail = Email.dirty('a@test.com');
Password defaultPassword = Password.dirty('password');

main() {
  var authRepo = MockAuthenticationRepository();
  group('LoginCubit', () {
    testEmpty(authRepo);
    testEmailChanged(authRepo);
    testPasswordChanged(authRepo);
    testLogInWithCredentialsWhenFormIsNotValid();
    testLogInWithCredentialsWhenFormIsValid();
    testLogInWithCredentialsWhenRepositoryThrowsException();
  });
}

void testEmpty(MockAuthenticationRepository authRepo) {
  blocTest(
    'emits [] when created',
    build: () => LoginCubit(authRepo),
    expect: [],
  );
}

void testEmailChanged(MockAuthenticationRepository authRepo) {
  blocTest(
      'emits [LoginState(email: ${defaultEmail.value}, status: invalid) when emailChanged is called',
      build: () => LoginCubit(authRepo),
      act: (LoginCubit cubit) => cubit.emailChanged(defaultEmail.value),
      expect: [
        LoginState(
          email: defaultEmail,
          status: FormzStatus.invalid,
        )
      ]);
}

void testPasswordChanged(MockAuthenticationRepository authRepo) {
  blocTest(
      'emits [LoginState(password: ${defaultPassword.value}, status: invalid) when passwordChanged is called',
      build: () => LoginCubit(authRepo),
      act: (LoginCubit cubit) => cubit.passwordChanged(defaultPassword.value),
      expect: [
        LoginState(
          password: defaultPassword,
          status: FormzStatus.invalid,
        )
      ]);
}

void testLogInWithCredentialsWhenFormIsNotValid() {
  var authRepo = MockAuthenticationRepository();
  blocTest(
    'emits [] and does not call any repository function when logInWithCredentials is called with invalid form',
    build: () => LoginCubit(authRepo),
    act: (LoginCubit cubit) => cubit.logInWithCredentials(),
    expect: [],
    verify: (cubit) {
      verifyZeroInteractions(authRepo);
    },
  );
}

void testLogInWithCredentialsWhenFormIsValid() {
  var authRepo = MockAuthenticationRepository();

  var startLoginState = LoginState(
    email: defaultEmail,
    password: defaultPassword,
    status: FormzStatus.valid,
  );
  blocTest(
    """emits 
      [LoginState, LoginState] and 
      calls logInWithEmailAndPassword.""",
    build: () => LoginCubit(
      authRepo,
      state: startLoginState,
    ),
    act: (LoginCubit cubit) => cubit.logInWithCredentials(),
    expect: [
      startLoginState.copyWith(status: FormzStatus.submissionInProgress),
      startLoginState.copyWith(status: FormzStatus.submissionSuccess),
    ],
    verify: (cubit) {
      verify(
        authRepo.logInWithEmailAndPassword(
          email: defaultEmail.value,
          password: defaultPassword.value,
        ),
      );
    },
  );
}

void testLogInWithCredentialsWhenRepositoryThrowsException() {
  MockAuthenticationRepository authRepo = MockAuthenticationRepository();
  when(authRepo.logInWithEmailAndPassword(
    email: defaultEmail.value,
    password: defaultPassword.value,
  )).thenThrow(Exception());

  var startLoginState = LoginState(
    email: defaultEmail,
    password: defaultPassword,
    status: FormzStatus.valid,
  );
  blocTest(
    """emits [
      LoginState(status: FormzStatus.submissionInProgress), 
      LoginState(status: FormzStatus.submissionFailure)] and 
      calls logInWithEmailAndPassword""",
    build: () => LoginCubit(
      authRepo,
      state: startLoginState,
    ),
    act: (LoginCubit cubit) => cubit.logInWithCredentials(),
    expect: [
      startLoginState.copyWith(status: FormzStatus.submissionInProgress),
      startLoginState.copyWith(status: FormzStatus.submissionFailure),
    ],
    verify: (cubit) {
      verify(
        authRepo.logInWithEmailAndPassword(
          email: defaultEmail.value,
          password: defaultPassword.value,
        ),
      );
    },
  );
}

// TODO implement test for logInWithGoogle
