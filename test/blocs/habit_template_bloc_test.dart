import 'dart:collection';

import 'package:bloc_test/bloc_test.dart';
import 'package:habit_tracker/blocs/habit_template_bloc/habit_template_bloc.dart';
import 'package:habit_tracker/helper/hash_map_helper.dart';
import 'package:habit_tracker/models/habit_template.dart';
import 'package:habit_tracker/models/id.dart';
import 'package:test/test.dart';

import '../mocks/repository_mocks.dart';
import '../mocks/repository_mock_helper.dart';

final Id defaultId = Id('1');
final String defaultTemplateName = 'Test Habit';

main() {
  group('HabitTemplateBloc', () {
    testTemplatesLoaded();
    testAddTemplate();
    testDeleteTemplate();
    testChangeTemplate();
  });
}

List<HabitTemplate> generateItemsForTemplatesLoadedTest() {
  return List<HabitTemplate>.generate(
    3,
    (index) => HabitTemplate(
      name: '$defaultTemplateName $index',
      id: Id('$index'),
    ),
  );
}

void testTemplatesLoaded() {
  List<HabitTemplate> templates = generateItemsForTemplatesLoadedTest();

  RepositoryMockHelper<HabitTemplate> mockHelper =
      RepositoryMockHelper<HabitTemplate>(
    repository: MockHabitTemplateRepository(),
  );
  mockHelper.setupGetStreamOfItems();
  mockHelper.addItemsToStream(templates);

  blocTest(
    'emits List of 3 HabitTemplates when HabitTemplateLoading is called.',
    build: () => HabitTemplateBloc(repository: mockHelper.repository),
    act: (HabitTemplateBloc bloc) => bloc.add(
      HabitTemplateLoading(),
    ),
    expect: [
      HabitTemplateState.loaded(
        HashMapHelper.createMapFromItems(templates),
      ),
    ],
  );
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

  blocTest(
    'emits [HabitTemplate] when HabitTemplateAdded is called.',
    build: () => HabitTemplateBloc(repository: mockHelper.repository),
    act: (HabitTemplateBloc bloc) => bloc
      ..add(HabitTemplateLoading())
      ..add(
        HabitTemplateAdded(template),
      ),
    expect: [
      HabitTemplateState.loaded(HashMapHelper.createMapFromItem(
        template.copyWith(
          id: defaultId,
        ),
      ))
    ],
  );
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
        HashMapHelper.createMapFromItem(template),
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
        HashMapHelper.createMapFromItem(template),
      ),
    ),
    act: (HabitTemplateBloc bloc) => bloc
      ..add(HabitTemplateLoading())
      ..add(
        HabitTemplateChanged(updatedTemplate),
      ),
    expect: [
      HabitTemplateState.loaded(
        HashMapHelper.createMapFromItem(updatedTemplate),
      ),
    ],
  );
}
