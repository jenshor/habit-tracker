import 'package:formz/formz.dart';

enum NameInputError { empty }

class Email extends FormzInput<String, NameInputError> {
  Email.dirty(String email) : super.dirty(email);
  Email.pure(String email) : super.pure(email);

  @override
  NameInputError validator(String value) {
    // TODO: implement validator
    throw UnimplementedError();
  }
}
