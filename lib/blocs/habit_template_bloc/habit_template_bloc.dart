import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habit_tracker/models/habit_template.dart';
import 'package:habit_tracker/models/id.dart';
import 'package:habit_tracker/repositories/habit_template_repository.dart';
import 'package:meta/meta.dart';
part 'habit_template_event.dart';
part 'habit_template_state.dart';

class HabitTemplateBloc extends Bloc<HabitTemplateEvent, HabitTemplateState> {
  HabitTemplateRepository repository;

  HabitTemplateBloc({
    @required this.repository,
  }) : super(
          HabitTemplateState.uninitialized(),
        );

  @override
  Stream<HabitTemplateState> mapEventToState(
    HabitTemplateEvent event,
  ) async* {
    if (event is HabitTemplateAdded) {
      yield* _mapHabitTemplateAddedToState(event);
    }
    if (event is HabitTemplateDeleted) {}
  }

  Stream<HabitTemplateState> _mapHabitTemplateAddedToState(
      HabitTemplateAdded event) async* {
    HabitTemplate newHabitTemplate = event.habitTemplate;
    String itemId = await repository.addItem(newHabitTemplate);
    HabitTemplate firestoreHabitTemplate =
        newHabitTemplate.copyWith(id: Id(itemId));

    HashMap<String, HabitTemplate> templates = state.habitTemplates;
    templates.putIfAbsent(itemId, () => firestoreHabitTemplate);
    yield HabitTemplateState.loaded(templates);
  }
}
