import 'package:formz/formz.dart';

enum PasswordError { empty }

class Password extends FormzInput<String, PasswordError> {
  Password.dirty(String password) : super.dirty(password);
  Password.pure(String password) : super.pure(password);

  @override
  PasswordError validator(String password) {
    // TODO: implement validator
    throw UnimplementedError();
  }
}
