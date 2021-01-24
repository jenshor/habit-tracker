import 'dart:collection';
import 'package:habit_tracker/models/model.dart';

class HashMapHelper {
  static HashMap<String, Item> createMapFromItems<Item extends Model>(
    List<Item> items,
  ) {
    return HashMap<String, Item>.fromIterable(
      items,
      key: (k) => k.id.value,
      value: (v) => v,
    );
  }

  static HashMap<String, Item> createMapFromItem<Item extends Model>(
    Item item,
  ) {
    return createMapFromItems([item]);
  }
}
