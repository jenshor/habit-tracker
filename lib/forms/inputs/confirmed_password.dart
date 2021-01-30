import 'package:formz/formz.dart';

enum ConfirmedPasswordValidationError { invalid }

class ConfirmedPassword
    extends FormzInput<String, ConfirmedPasswordValidationError> {
  final String password;
  const ConfirmedPassword.pure()
      : this.password = '',
        super.pure('');
  const ConfirmedPassword.dirty({String value = '', String password = ''})
      : this.password = password,
        super.dirty(value);

  @override
  ConfirmedPasswordValidationError validator(String value) {
    return this.password == this.value
        ? null
        : ConfirmedPasswordValidationError.invalid;
  }
}
