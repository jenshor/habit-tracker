part of 'habit_template_bloc.dart';

class HabitTemplateState extends Equatable {
  final LoadingStatus status;
  final HashMap<String, HabitTemplate> habitTemplates;

  HabitTemplateState._({
    this.status = LoadingStatus.uninitialized,
    HashMap<String, HabitTemplate> habitTemplates,
  }) : this.habitTemplates = habitTemplates ?? HashMap<String, HabitTemplate>();

  HabitTemplateState.loaded(
    HashMap<String, HabitTemplate> habitTemplates,
  ) : this._(
          status: LoadingStatus.loaded,
          habitTemplates: habitTemplates,
        );

  HabitTemplateState.loading()
      : this._(
          status: LoadingStatus.loading,
        );

  HabitTemplateState.uninitialized()
      : this._(
          status: LoadingStatus.uninitialized,
        );

  @override
  List<Object> get props => [status, habitTemplates];

  @override
  bool get stringify => true;
}
