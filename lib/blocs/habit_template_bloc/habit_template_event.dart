part of 'habit_template_bloc.dart';

abstract class HabitTemplateEvent extends Equatable {
  const HabitTemplateEvent();

  @override
  List<Object> get props => [];
}

class HabitTemplateAdded extends HabitTemplateEvent {
  final HabitTemplate habitTemplate;

  HabitTemplateAdded(this.habitTemplate);

  @override
  List<Object> get props => [habitTemplate];
}

class HabitTemplateDeleted extends HabitTemplateEvent {
  final HabitTemplate habitTemplate;

  HabitTemplateDeleted(this.habitTemplate);

  @override
  List<Object> get props => [habitTemplate];
}

class HabitTemplateChanged extends HabitTemplateEvent {
  final HabitTemplate habitTemplate;

  HabitTemplateChanged(this.habitTemplate);

  @override
  List<Object> get props => [habitTemplate];
}

class HabitTemplateLoading extends HabitTemplateEvent {}

class HabitTemplateLoaded extends HabitTemplateEvent {
  final List<HabitTemplate> habitTemplates;

  HabitTemplateLoaded(this.habitTemplates);

  @override
  List<Object> get props => [habitTemplates];
}
