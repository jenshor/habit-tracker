import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habit_tracker/models/habit_template.dart';
import 'package:habit_tracker/repositories/firestore_repository.dart';
import 'package:habit_tracker/repositories/user_repository.dart';
import 'package:meta/meta.dart';

class HabitTemplateRepository extends FirestoreRepository<HabitTemplate> {
  HabitTemplateRepository(
      {@required String userId, FirebaseFirestore firestore})
      : super(
          'habit-templates',
          (Map<String, dynamic> map) => HabitTemplate.fromMap(map),
          firestore: firestore,
          collectionParentPath: '${UserRepository.name}/$userId',
        );
}
