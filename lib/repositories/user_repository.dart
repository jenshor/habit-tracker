import 'package:habit_tracker/models/model.dart';
import 'package:habit_tracker/models/user.dart';
import 'package:habit_tracker/repositories/firestore_repository.dart';

class UserRepository extends FirestoreRepository<User> {
  static const String name = 'users';
  UserRepository(
    User Function(Map<String, dynamic> data) mapDataToItem,
  ) : super(
          name,
          mapDataToItem,
        );
}
