import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habit_tracker/blocs/loading_status.dart';
import 'package:habit_tracker/helper/date_time_provider.dart';
import 'package:habit_tracker/helper/hash_map_helper.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/models/id.dart';
import 'package:habit_tracker/repositories/habit_repository.dart';
import 'package:meta/meta.dart';
part 'habit_event.dart';
part 'habit_state.dart';

// TODO this class contains code that is similar to code in HabitTemplateBloc
// is it possible to refactor this into one base class?
class HabitBloc extends Bloc<HabitEvent, HabitState> {
  HabitRepository repository;
  DateTimeProvider dateTimeProvider;

  HabitBloc({
    @required this.repository,
    HabitState state,
    DateTimeProvider dateTimeProvider,
  })  : this.dateTimeProvider = dateTimeProvider ?? DateTimeProvider(),
        super(state ?? HabitState.uninitialized());

  @override
  Stream<HabitState> mapEventToState(
    HabitEvent event,
  ) async* {
    if (event is HabitsLoading) {
      yield* _mapHabitTemplateLoadingToState();
    }
    if (event is HabitsLoaded) {
      yield* _mapHabitTemplateLoadedToState(event);
    }
    if (event is HabitCompletionToggled) {
      yield* _mapHabitCompletionToggledToState(event);
    }
  }

  Stream<HabitState> _mapHabitTemplateLoadingToState() async* {
    repository.getStreamOfItems().forEach(
          (List<Habit> habitTemplates) => add(
            HabitsLoaded(habitTemplates),
          ),
        );

    yield HabitState.loading();
  }

  Habit createDefaultHabit() {
    return Habit(
      id: Id.fromDate(
        date: dateTimeProvider.getCurrentTime(),
      ),
    );
  }

  Stream<HabitState> _mapHabitTemplateLoadedToState(HabitsLoaded event) async* {
    if (event.habits.isEmpty) {
      Habit habit = createDefaultHabit();
      await repository.addItem(habit);
    }

    yield HabitState.loaded(
      HashMapHelper.createMapFromItems(
        event.habits,
      ),
    );
  }

  Habit toggleHabitCompletion(Habit habit) {
    if (habit.isCompleted) {
      habit = habit.copyWith(
        completionTime: null,
      );
    } else {
      habit = habit.copyWith(
        completionTime: dateTimeProvider.getCurrentTime(),
      );
    }

    return habit;
  }

  Stream<HabitState> _mapHabitCompletionToggledToState(
      HabitCompletionToggled event) async* {
    Habit habit = toggleHabitCompletion(event.habit);
    await repository.updateItem(habit);
  }
}
