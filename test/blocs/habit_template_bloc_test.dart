import 'dart:collection';

import 'package:bloc_test/bloc_test.dart';
import 'package:habit_tracker/blocs/habit_template_bloc/habit_template_bloc.dart';
import 'package:habit_tracker/models/habit_template.dart';
import 'package:habit_tracker/models/id.dart';
import 'package:test/test.dart';

import '../mocks/repository_mock.dart';
import '../mocks/repository_mock_helper.dart';

Id defaultId = Id('1');
String defaultTemplateName = 'Test Habit';
main() {
  group('HabitTemplateBloc', () {
    testAddTemplate();
    testDeleteTemplate();
    testChangeTemplate();
  });
}

void testAddTemplate() {
  HabitTemplate template =
      HabitTemplate(name: defaultTemplateName, id: defaultId);
  RepositoryMockHelper<HabitTemplate> mockHelper =
      RepositoryMockHelper<HabitTemplate>(
    repository: MockHabitTemplateRepository(),
  );
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
        HabitTemplateState.loaded(createMapFromSingleTemplate(
          template.copyWith(
            id: defaultId,
          ),
        ))
      ],
      wait: Duration(seconds: 2));
}

void testDeleteTemplate() {
  HabitTemplate template =
      HabitTemplate(name: defaultTemplateName, id: defaultId);
  RepositoryMockHelper<HabitTemplate> mockHelper =
      RepositoryMockHelper<HabitTemplate>(
    repository: MockHabitTemplateRepository(),
  );
  mockHelper.setupDeleteItem(template);
  mockHelper.setupGetStreamOfItems();
  blocTest(
    'emits [] when HabitTemplateDeleted is called.',
    build: () => HabitTemplateBloc(
      repository: mockHelper.repository,
      state: HabitTemplateState.loaded(
        createMapFromSingleTemplate(template),
      ),
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

void testChangeTemplate() {
  HabitTemplate template =
      HabitTemplate(name: defaultTemplateName, id: defaultId);
  HabitTemplate updatedTemplate =
      template.copyWith(name: '$defaultTemplateName 2');
  RepositoryMockHelper<HabitTemplate> mockHelper =
      RepositoryMockHelper<HabitTemplate>(
    repository: MockHabitTemplateRepository(),
  );
  mockHelper.setupUpdateItem(
    updatedTemplate,
    itemsReturnedByStream: [updatedTemplate],
  );
  mockHelper.setupGetStreamOfItems();

  blocTest(
    'emits [HabitTemplate(name: $defaultTemplateName 2)] when HabitTemplateChanged is called.',
    build: () => HabitTemplateBloc(
      repository: mockHelper.repository,
      state: HabitTemplateState.loaded(
        createMapFromSingleTemplate(template),
      ),
    ),
    act: (HabitTemplateBloc bloc) => bloc
      ..add(HabitTemplateLoading())
      ..add(
        HabitTemplateChanged(updatedTemplate),
      ),
    expect: [
      HabitTemplateState.loaded(createMapFromSingleTemplate(updatedTemplate)),
    ],
  );
}

HashMap<String, HabitTemplate> createMapFromSingleTemplate(
    HabitTemplate template) {
  return HashMap<String, HabitTemplate>.from({template.id.value: template});
}
