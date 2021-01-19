import 'package:habit_tracker/models/user.dart';
import 'package:habit_tracker/repositories/firestore_repository.dart';

class UserRepository extends FirestoreRepository<User> {
  static const String name = 'users';
  UserRepository()
      : super(
          name,
          (Map<String, dynamic> data) => User.fromMap(data),
        );
}
