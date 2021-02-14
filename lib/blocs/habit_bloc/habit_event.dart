part of 'habit_bloc.dart';

abstract class HabitEvent extends Equatable {
  const HabitEvent();

  @override
  List<Object> get props => [];
}

class HabitAdded extends HabitEvent {
  final Habit habit;

  HabitAdded(this.habit);

  @override
  List<Object> get props => [habit];
}

class HabitDeleted extends HabitEvent {
  final Habit habit;

  HabitDeleted(this.habit);

  @override
  List<Object> get props => [habit];
}

class HabitChanged extends HabitEvent {
  final Habit habit;

  HabitChanged(this.habit);

  @override
  List<Object> get props => [habit];
}

class HabitCompletionToggled extends HabitEvent {
  final Habit habit;
  final DateTime date;

  HabitCompletionToggled({
    @required this.habit,
    this.date,
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
