part of 'habit_bloc.dart';

class HabitState extends Equatable {
  final LoadingStatus status;
  final HashMap<String, Habit> habits;

  HabitState._({
    this.status = LoadingStatus.uninitialized,
    HashMap<String, Habit> habits,
  }) : this.habits = habits ?? HashMap<String, Habit>();

  HabitState.loaded(
    HashMap<String, Habit> habits,
  ) : this._(
          status: LoadingStatus.loaded,
          habits: habits,
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
  List<Object> get props => [];
}
