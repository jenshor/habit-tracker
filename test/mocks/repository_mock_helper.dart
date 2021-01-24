import 'dart:async';

import 'package:habit_tracker/models/habit_template.dart';
import 'package:habit_tracker/repositories/habit_template_repository.dart';
import 'package:mockito/mockito.dart';

import 'repository_mock.dart';

class RepositoryMockHelper {
  final HabitTemplateRepository repository;
  final StreamController<List<HabitTemplate>> streamController;
  RepositoryMockHelper()
      : repository = MockHabitTemplateRepository(),
        streamController = StreamController<List<HabitTemplate>>();

  void setupAddItem(
    HabitTemplate template,
  ) {
    when(
      repository.addItem(template),
    ).thenAnswer(
      (Invocation i) {
        streamController.add([template]);
        return Future<String>.value(template.id.value);
      },
    );
  }

  void setupDeleteItem(
    HabitTemplate itemToDelete, {
    List<HabitTemplate> habitTemplatesToBeEmittedByStream,
  }) {
    if (habitTemplatesToBeEmittedByStream == null) {
      habitTemplatesToBeEmittedByStream = List<HabitTemplate>.empty();
    }

    when(
      repository.deleteItem(itemToDelete),
    ).thenAnswer(
      (Invocation i) {
        streamController.add(habitTemplatesToBeEmittedByStream);
        return Future.value();
      },
    );
  }

  void setupGetStreamOfItems() {
    when(repository.getStreamOfItems())
        .thenAnswer((_) => streamController.stream);
  }
}
