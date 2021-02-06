part of 'sign_up_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class SignUpState extends Equatable {
  const SignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.name = const NonEmptyText.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
  });

  final Email email;
  final Password password;
  final NonEmptyText name;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;

  @override
  List<Object> get props => [
        email,
        password,
        confirmedPassword,
        name,
        status,
      ];

  SignUpState copyWith({
    Email email,
    Password password,
    ConfirmedPassword confirmedPassword,
    NonEmptyText firstName,
    NonEmptyText lastName,
    FormzStatus status,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      name: firstName ?? this.name,
      status: status ?? this.status,
    );
  }
}
