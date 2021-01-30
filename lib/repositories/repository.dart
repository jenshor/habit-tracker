import 'package:habit_tracker/models/model.dart';

abstract class Repository<Item extends Model> {
  Future<String> addItem(Item item);
  Future<void> setItem(Item item);
  Future<void> updateItem(Item item);
  Future<void> deleteItem(Item item);
  Stream<List<Item>> getStreamOfItems();
}
