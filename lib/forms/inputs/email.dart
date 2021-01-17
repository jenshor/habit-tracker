import 'package:formz/formz.dart';

enum NameInputError { empty }

class Email extends FormzInput<String, NameInputError> {
  const Email.dirty(String email) : super.dirty(email);
  const Email.pure() : super.pure('');

  @override
  NameInputError validator(String value) {
    // TODO: implement validator
    throw UnimplementedError();
  }
}
