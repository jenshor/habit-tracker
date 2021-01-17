import 'package:formz/formz.dart';

enum PasswordError { empty }

class Password extends FormzInput<String, PasswordError> {
  const Password.dirty(String password) : super.dirty(password);
  const Password.pure() : super.pure('');

  @override
  PasswordError validator(String password) {
    // TODO: implement validator
    throw UnimplementedError();
  }
}
