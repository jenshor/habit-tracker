import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:habit_tracker/forms/inputs/non_empty_text.dart';
import 'package:habit_tracker/models/habit.dart';

part 'modify_habit_state.dart';

class ModifyHabitCubit extends Cubit<ModifyHabitState> {
  ModifyHabitCubit({Habit habit})
      : super(habit != null
            ? ModifyHabitState.fromHabit(habit)
            : ModifyHabitState());

  void nameChanged(String value) {
    final name = NonEmptyText.dirty(value);
    emit(
      state.copyWith(
        name: name,
        status: Formz.validate([name]),
      ),
    );
  }
}
