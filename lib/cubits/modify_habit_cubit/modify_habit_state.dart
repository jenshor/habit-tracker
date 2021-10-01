part of 'modify_habit_cubit.dart';

class ModifyHabitState extends Equatable {
  final NonEmptyText name;
  final FormzStatus status;
  ModifyHabitState({
    this.name = const NonEmptyText.pure(),
    this.status = FormzStatus.pure,
  });

  ModifyHabitState.fromHabit(Habit habit)
      : this.name = NonEmptyText.dirty(habit.name),
        this.status = FormzStatus.valid;

  @override
  List<Object> get props => [this.name];

  @override
  bool get stringify => true;

  ModifyHabitState copyWith({NonEmptyText name, FormzStatus status}) {
    return ModifyHabitState(
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }
}
