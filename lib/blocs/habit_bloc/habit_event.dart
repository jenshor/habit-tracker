part of 'habit_bloc.dart';

abstract class HabitEvent extends Equatable {
  const HabitEvent();

  @override
  List<Object> get props => [];
}

class HabitCompletionToggled extends HabitEvent {
  final Habit habit;
  HabitCompletionToggled({
    this.habit,
  });

  @override
  List<Object> get props => [habit];
}

class HabitsLoading extends HabitEvent {}

class HabitsLoaded extends HabitEvent {
  final List<Habit> habits;

  HabitsLoaded(this.habits);

  @override
  List<Object> get props => [habits];
}
