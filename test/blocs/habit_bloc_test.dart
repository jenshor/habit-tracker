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

final Id defaultId = Id('1');
final String defaultName = 'Test Habit';

main() {
  group('HabitBloc', () {
    testHabitLoaded();
    testHabitAdded();
    testHabitDeleted();
    testHabitChanged();
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
        1,
        1,
      ),
    ],
  );
}

void testHabitAdded() {
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
  mockHelper.setupAddItem(habit);
  mockHelper.setupGetStreamOfItems();

  blocTest(
    'emits [Habit] when HabitAdded is called.',
    build: () => HabitBloc(
      repository: mockHelper.repository,
      dateTimeProvider: dateTimeProvider,
      state: HabitState.loaded(
        HashMapHelper.createMapFromItem(habit),
        1,
        1,
      ),
    ),
    act: (HabitBloc bloc) => bloc
      ..add(HabitsLoading())
      ..add(
        HabitAdded(habit),
      ),
    expect: [
      HabitState.loading(),
      HabitState.loaded(
        HashMapHelper.createMapFromItem(habit),
        1,
        1,
      ),
    ],
  );
}

void testHabitDeleted() {
  DateTime date = DateTime.now();
  Habit habit = Habit(
    id: defaultId,
  );

  DateTimeProvider dateTimeProvider = DateTimeProviderMock();
  when(dateTimeProvider.getCurrentTime()).thenReturn(date);
  RepositoryMockHelper<Habit> mockHelper = RepositoryMockHelper<Habit>(
    repository: MockHabitRepository(),
  );
  mockHelper.setupDeleteItem(
    habit,
    itemsReturnedByStream: [],
  );
  mockHelper.setupGetStreamOfItems();

  blocTest(
    'emits [] when HabitDeleted is called.',
    build: () => HabitBloc(
      repository: mockHelper.repository,
      dateTimeProvider: dateTimeProvider,
      state: HabitState.loaded(
        HashMapHelper.createMapFromItem(habit),
        1,
        1,
      ),
    ),
    act: (HabitBloc bloc) => bloc
      ..add(HabitsLoading())
      ..add(
        HabitDeleted(habit),
      ),
    expect: [
      HabitState.loading(),
      HabitState.loaded(
        HashMapHelper.createMapFromItems([]),
        0,
        0,
      ),
    ],
  );
}

void testHabitChanged() {
  DateTime date = DateTime.now();
  Habit habit = Habit(id: defaultId, name: defaultName);
  Habit changedHabit = habit.copyWith(name: '$defaultName new');

  DateTimeProvider dateTimeProvider = DateTimeProviderMock();
  when(dateTimeProvider.getCurrentTime()).thenReturn(date);
  RepositoryMockHelper<Habit> mockHelper = RepositoryMockHelper<Habit>(
    repository: MockHabitRepository(),
  );
  mockHelper.setupDeleteItem(
    habit,
    itemsReturnedByStream: [],
  );
  mockHelper.setupGetStreamOfItems();
  mockHelper.setupUpdateItem(
    changedHabit,
  );

  blocTest(
    'emits [] when HabitChanged is called.',
    build: () => HabitBloc(
      repository: mockHelper.repository,
      dateTimeProvider: dateTimeProvider,
      state: HabitState.loaded(
        HashMapHelper.createMapFromItem(habit),
        1,
        1,
      ),
    ),
    act: (HabitBloc bloc) => bloc
      ..add(HabitsLoading())
      ..add(
        HabitChanged(changedHabit),
      ),
    expect: [
      HabitState.loading(),
      HabitState.loaded(
        HashMapHelper.createMapFromItem(changedHabit),
        1,
        1,
      ),
    ],
  );
}

void testCompletionToggled() {
  DateTime changedDate = DateTime.now();
  Habit habit = Habit(name: defaultName, id: defaultId);
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
        1,
        1,
      ),
    ),
    act: (HabitBloc bloc) => bloc
      ..add(HabitsLoading())
      ..add(
        HabitCompletionToggled(
          habit: habit,
        ),
      ),
    expect: [
      HabitState.loading(),
      HabitState.loaded(
        HashMapHelper.createMapFromItem(expectedHabit),
        1,
        1,
      ),
    ],
  );
}
