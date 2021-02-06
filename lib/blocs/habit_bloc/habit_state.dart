part of 'habit_bloc.dart';

class HabitState extends Equatable {
  final LoadingStatus status;
  final HashMap<String, Habit> habits;
  final int totalHabits;
  final int unfinishedHabits;

  HabitState._({
    this.status = LoadingStatus.uninitialized,
    HashMap<String, Habit> habits,
    this.totalHabits = 0,
    this.unfinishedHabits = 0,
  }) : this.habits = habits ?? HashMap<String, Habit>();

  HabitState.loaded(
      HashMap<String, Habit> habits, int totalHabits, int unfinishedHabits)
      : this._(
          status: LoadingStatus.loaded,
          habits: habits,
          totalHabits: totalHabits,
          unfinishedHabits: unfinishedHabits,
        );

  HabitState.loading()
      : this._(
          status: LoadingStatus.loading,
        );

  HabitState.uninitialized()
      : this._(
          status: LoadingStatus.uninitialized,
        );

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status, habits.values];
}
