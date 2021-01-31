import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habit_tracker/blocs/loading_status.dart';
import 'package:habit_tracker/helper/date_time_helper.dart';
import 'package:habit_tracker/helper/date_time_provider.dart';
import 'package:habit_tracker/helper/hash_map_helper.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/models/id.dart';
import 'package:habit_tracker/repositories/habit_repository.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:meta/meta.dart';
part 'habit_event.dart';
part 'habit_state.dart';

// TODO this class contains code that is similar to code in HabitTemplateBloc
// is it possible to refactor this into one base class?
class HabitBloc extends Bloc<HabitEvent, HabitState> {
  HabitRepository repository;
  DateTimeProvider dateTimeProvider;
  DateTimeHelper dateTimeHelper;
  HabitBloc({
    @required this.repository,
    HabitState state,
    DateTimeProvider dateTimeProvider,
  })  : this.dateTimeProvider = dateTimeProvider ?? DateTimeProvider(),
        this.dateTimeHelper = DateTimeHelper(
            dateTimeProvider: dateTimeProvider ?? DateTimeProvider()),
        super(state ?? HabitState.uninitialized());

  @override
  Stream<HabitState> mapEventToState(
    HabitEvent event,
  ) async* {
    if (event is HabitAdded) {
      yield* _mapHabitAddedToState(event);
    }
    if (event is HabitChanged) {
      yield* _mapHabitChangedToState(event);
    }
    if (event is HabitDeleted) {
      yield* _mapHabitDeletedToState(event);
    }
    if (event is HabitsLoading) {
      yield* _mapHabitLoadingToState();
    }
    if (event is HabitsLoaded) {
      yield* _mapHabitLoadedToState(event);
    }
    if (event is HabitCompletionToggled) {
      yield* _mapHabitCompletionToggledToState(event);
    }
  }

  Stream<HabitState> _mapHabitAddedToState(HabitAdded event) async* {
    await repository.addItem(event.habit);
  }

  Stream<HabitState> _mapHabitChangedToState(HabitChanged event) async* {
    await repository.updateItem(event.habit);
  }

  Stream<HabitState> _mapHabitDeletedToState(HabitDeleted event) async* {
    await repository.deleteItem(event.habit);
  }

  Stream<HabitState> _mapHabitLoadingToState() async* {
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
        date: dateTimeProvider.getCurrentDay(),
      ),
    );
  }

  Stream<HabitState> _mapHabitLoadedToState(HabitsLoaded event) async* {
    yield HabitState.loaded(
      HashMapHelper.createMapFromItems(
        event.habits,
      ),
    );
  }

  // TODO make a global function from this
  Habit toggleHabitCompletion(
    Habit habit,
    DateTime date,
  ) {
    List<DateTime> completionTimes = List<DateTime>.from(habit.completionTimes);
    date = dateTimeProvider.getDayWithoutTime(date);
    if (dateTimeHelper.isCompletedToday(habit)) {
      completionTimes.remove(date);
    } else {
      completionTimes.add(date);
    }
    Habit updatedHabit = habit.copyWith(completionTimes: completionTimes);
    return updatedHabit;
  }

  Stream<HabitState> _mapHabitCompletionToggledToState(
      HabitCompletionToggled event) async* {
    Habit habit = toggleHabitCompletion(
      event.habit,
      event.date,
    );
    await repository.updateItem(habit);
  }
}
