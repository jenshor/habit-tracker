import 'dart:async';
import 'package:meta/meta.dart';
import 'package:habit_tracker/models/model.dart';
import 'package:habit_tracker/repositories/repository.dart';
import 'package:mockito/mockito.dart';

class RepositoryMockHelper<Item extends Model> {
  final Repository<Item> repository;
  final StreamController<List<Item>> streamController;
  RepositoryMockHelper({@required this.repository})
      : streamController = StreamController<List<Item>>();

  void setupAddItem(
    Item item, {
    List<Item> itemsReturnedByStream,
  }) {
    if (itemsReturnedByStream == null) {
      itemsReturnedByStream = [item];
    }

    when(
      repository.addItem(item),
    ).thenAnswer(
      (Invocation i) {
        addItemsToStream(itemsReturnedByStream);
        return Future<String>.value(item.id.value);
      },
    );
  }

  void setupDeleteItem(
    Item deletedItem, {
    List<Item> itemsReturnedByStream,
  }) {
    if (itemsReturnedByStream == null) {
      itemsReturnedByStream = List<Item>.empty();
    }

    when(
      repository.deleteItem(deletedItem),
    ).thenAnswer(
      (Invocation i) {
        addItemsToStream(itemsReturnedByStream);
        return Future.value();
      },
    );
  }

  void setupUpdateItem(
    Item updatedItem, {
    List<Item> itemsReturnedByStream,
  }) {
    if (itemsReturnedByStream == null) {
      itemsReturnedByStream = [updatedItem];
    }

    when(
      repository.updateItem(updatedItem),
    ).thenAnswer(
      (Invocation i) {
        addItemsToStream(itemsReturnedByStream);
        return Future.value();
      },
    );
  }

  void setupGetStreamOfItems() {
    when(repository.getStreamOfItems())
        .thenAnswer((_) => streamController.stream);
  }

  void addItemToStream(Item item) {
    addItemsToStream([item]);
  }

  void addItemsToStream(List<Item> items) {
    streamController.add(items);
  }
}
