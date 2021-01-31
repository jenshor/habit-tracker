import 'package:bloc_test/bloc_test.dart';
import 'package:habit_tracker/blocs/habit_bloc/habit_bloc.dart';
import 'package:habit_tracker/helper/date_time_provider.dart';
import 'package:habit_tracker/helper/hash_map_helper.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/models/id.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mocks/date_time_provider_mock.dart';
import '../mocks/repository_mock_helper.dart';
import '../mocks/repository_mocks.dart';

// TODO this code is copied from HabitTemplateBlocTest
final Id defaultId = Id('1');
final String defaultTemplateName = 'Test Habit';

main() {
  group('HabitBloc', () {
    testHabitLoaded();
    testCompletionToggled();
  });
}

void testHabitLoaded() {
  DateTime date = DateTime.now();
  Habit habit = Habit(
    id: Id.fromDate(
      date: date,
    ),
  );

  DateTimeProvider dateTimeProvider = DateTimeProviderMock();
  when(dateTimeProvider.getCurrentTime()).thenReturn(date);
  RepositoryMockHelper<Habit> mockHelper = RepositoryMockHelper<Habit>(
    repository: MockHabitRepository(),
  );
  mockHelper.setupGetStreamOfItems();
  mockHelper.addItemToStream(habit);

  blocTest(
    'emits [Habit] when HabitsLoading is called.',
    build: () => HabitBloc(
      repository: mockHelper.repository,
      dateTimeProvider: dateTimeProvider,
    ),
    act: (HabitBloc bloc) => bloc.add(HabitsLoading()),
    expect: [
      HabitState.loading(),
      HabitState.loaded(
        HashMapHelper.createMapFromItem(habit),
      ),
    ],
  );
}

void testCompletionToggled() {
  DateTime changedDate = DateTime.now();
  Habit habit = Habit(name: defaultTemplateName, id: defaultId);
  Habit expectedHabit = habit.copyWith(completionTimes: [changedDate]);

  DateTimeProvider dateTimeProvider = DateTimeProviderMock();
  when(dateTimeProvider.getCurrentDay()).thenReturn(changedDate);
  RepositoryMockHelper<Habit> mockHelper = RepositoryMockHelper<Habit>(
    repository: MockHabitRepository(),
  );
  mockHelper.setupUpdateItem(
    expectedHabit,
    itemsReturnedByStream: [expectedHabit],
  );
  mockHelper.setupGetStreamOfItems();

  blocTest(
    'emits [Habit] when HabitCompletionToggled is called.',
    build: () => HabitBloc(
      repository: mockHelper.repository,
      dateTimeProvider: dateTimeProvider,
      state: HabitState.loaded(
        HashMapHelper.createMapFromItem(habit),
      ),
    ),
    act: (HabitBloc bloc) => bloc
      ..add(HabitsLoading())
      ..add(
        HabitCompletionToggled(habit: habit),
      ),
    expect: [
      HabitState.loading(),
      HabitState.loaded(
        HashMapHelper.createMapFromItem(expectedHabit),
      ),
    ],
  );
}
