import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:habit_tracker/cubits/login_cubit/login_cubit.dart';
import 'package:habit_tracker/forms/inputs/email.dart';
import 'package:habit_tracker/forms/inputs/password.dart';
import 'package:habit_tracker/repositories/authentication_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

main() {
  var authRepo = MockAuthenticationRepository();
  group('LoginCubit', () {
    blocTest(
      'emits [] when created',
      build: () => LoginCubit(authRepo),
      expect: [],
    );

    testEmailChanged(authRepo);
    testPasswordChanged(authRepo);
  });
}

void testEmailChanged(MockAuthenticationRepository authRepo) {
  String email = 'a@test.com';
  blocTest(
      'emits [LoginState(email: $email, status: invalid) when emailChanged is called',
      build: () => LoginCubit(authRepo),
      act: (LoginCubit cubit) => cubit.emailChanged(email),
      expect: [
        LoginState(
          email: Email.dirty(email),
          status: FormzStatus.invalid,
        )
      ]);
}

void testPasswordChanged(MockAuthenticationRepository authRepo) {
  String password = 'password';
  blocTest(
      'emits [LoginState(password: $password, status: invalid) when passwordChanged is called',
      build: () => LoginCubit(authRepo),
      act: (LoginCubit cubit) => cubit.passwordChanged(password),
      expect: [
        LoginState(
          password: Password.dirty(password),
          status: FormzStatus.invalid,
        )
      ]);
}
