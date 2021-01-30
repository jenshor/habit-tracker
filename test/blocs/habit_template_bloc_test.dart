import 'dart:collection';

import 'package:bloc_test/bloc_test.dart';
import 'package:habit_tracker/blocs/habit_template_bloc/habit_template_bloc.dart';
import 'package:habit_tracker/models/habit_template.dart';
import 'package:habit_tracker/models/id.dart';
import 'package:habit_tracker/repositories/habit_template_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockHabitTemplateRepository extends Mock
    implements HabitTemplateRepository {}

main() {
  group('HabitTemplateBloc', () {
    testAddTemplate();
  });
}

void testAddTemplate() {
  String returnedIdFromMockedRepo = '1';
  HabitTemplate template = HabitTemplate(name: 'Test Habit');
  HabitTemplateRepository repository = MockHabitTemplateRepository();
  when(
    repository.addItem(template),
  ).thenAnswer(
    (Invocation i) => Future.value(returnedIdFromMockedRepo),
  );
  blocTest('emits [HabitTemplate] when HabitTemplateAdded is called.',
      build: () => HabitTemplateBloc(repository: repository),
      act: (HabitTemplateBloc bloc) => bloc.add(
            HabitTemplateAdded(template),
          ),
      expect: [
        HabitTemplateState.loaded(habitTemplateToMap(
          template.copyWith(
            id: Id(returnedIdFromMockedRepo),
          ),
        ))
      ],
      wait: Duration(seconds: 2));
}

HashMap<String, HabitTemplate> habitTemplateToMap(HabitTemplate template) {
  return HashMap<String, HabitTemplate>.from({template.id.value: template});
}
