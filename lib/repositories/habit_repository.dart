import 'package:habit_tracker/helper/firestore_helper.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/repositories/firestore_repository.dart';
import 'package:habit_tracker/repositories/user_repository.dart';

class HabitRepository extends FirestoreRepository<Habit> {
  HabitRepository(String userId)
      : super(
          'habits',
          (Map<String, dynamic> map) => Habit.fromMap(map),
          collectionParentPath: FirestoreHelper.getCollectionPath([
            UserRepository.name,
            userId,
          ]),
        );
}
