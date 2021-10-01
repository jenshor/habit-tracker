import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:habit_tracker/forms/inputs/non_empty_text.dart';
import 'package:habit_tracker/repositories/authentication_repository.dart';

part 'edit_user_state.dart';

class EditUserCubit extends Cubit<EditUserState> {
  final AuthenticationRepository authenticationRepository;

  EditUserCubit(
    this.authenticationRepository,
  ) : super(EditUserInitial());

  void nameChanged(String value) {
    final name = NonEmptyText.dirty(value);
    emit(EditUserState(
      name: name,
      status: Formz.validate([name]),
    ));
  }

  void editFormSubmitted() async {
    await authenticationRepository.updateName(state.name.value);
  }
}
