import 'dart:async';

import 'package:habit_tracker/models/model.dart';
import 'package:habit_tracker/repositories/repository.dart';
import 'package:mockito/mockito.dart';

class RepositoryMockHelper<Item extends Model> {
  final Repository<Item> repository;
  final StreamController<List<Item>> streamController;
  RepositoryMockHelper(this.repository)
      : streamController = StreamController<List<Item>>();

  void setupAddItem(
    Item template,
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
    Item itemToDelete, {
    List<Item> habitTemplatesToBeEmittedByStream,
  }) {
    if (habitTemplatesToBeEmittedByStream == null) {
      habitTemplatesToBeEmittedByStream = List<Item>.empty();
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
