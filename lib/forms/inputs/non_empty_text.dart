import 'package:formz/formz.dart';

enum TextValidationError { invalid }

class NonEmptyText extends FormzInput<String, TextValidationError> {
  const NonEmptyText.pure() : super.pure('');
  const NonEmptyText.dirty([String value = '']) : super.dirty(value);

  @override
  TextValidationError validator(String value) {
    return value.isNotEmpty ? null : TextValidationError.invalid;
  }
}
