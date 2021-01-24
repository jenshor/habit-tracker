import 'dart:async';
import 'dart:collection';

import 'package:bloc_test/bloc_test.dart';
import 'package:habit_tracker/blocs/habit_template_bloc/habit_template_bloc.dart';
import 'package:habit_tracker/models/habit_template.dart';
import 'package:habit_tracker/models/id.dart';
import 'package:habit_tracker/repositories/habit_template_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mocks/repository_mock.dart';
import '../mocks/repository_mock_helper.dart';

Id defaultId = Id('1');

main() {
  group('HabitTemplateBloc', () {
    testAddTemplate();
    testDeleteTemplate();
  });
}

void testAddTemplate() {
  HabitTemplate template = HabitTemplate(name: 'Test Habit', id: defaultId);
  RepositoryMockHelper mockHelper = RepositoryMockHelper();
  mockHelper.setupAddItem(template);
  mockHelper.setupGetStreamOfItems();

  blocTest('emits [HabitTemplate] when HabitTemplateAdded is called.',
      build: () => HabitTemplateBloc(repository: mockHelper.repository),
      act: (HabitTemplateBloc bloc) => bloc
        ..add(HabitTemplateLoading())
        ..add(
          HabitTemplateAdded(template),
        ),
      expect: [
        HabitTemplateState.loaded(habitTemplateToMap(
          template.copyWith(
            id: defaultId,
          ),
        ))
      ],
      wait: Duration(seconds: 2));
}

void testDeleteTemplate() {
  HabitTemplate template = HabitTemplate(name: 'Test Habit', id: defaultId);
  RepositoryMockHelper mockHelper = RepositoryMockHelper();
  mockHelper.setupDeleteItem(template);
  mockHelper.setupGetStreamOfItems();
  blocTest(
    'emits [] when HabitTemplateDeleted is called.',
    build: () => HabitTemplateBloc(
      repository: mockHelper.repository,
      state: HabitTemplateState.loaded(habitTemplateToMap(template)),
    ),
    act: (HabitTemplateBloc bloc) => bloc
      ..add(HabitTemplateLoading())
      ..add(
        HabitTemplateDeleted(template),
      ),
    expect: [
      HabitTemplateState.loaded(HashMap<String, HabitTemplate>()),
    ],
  );
}

HashMap<String, HabitTemplate> habitTemplateToMap(HabitTemplate template) {
  return HashMap<String, HabitTemplate>.from({template.id.value: template});
}
