import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habit_tracker/models/habit_template.dart';

class HabitTemplateRepository {
  FirebaseFirestore _firestore;
  String collectionName = 'habit-templates';
  String userId;
  String get collectionPath => '$userId/$collectionName';

  HabitTemplateRepository({this.userId, FirebaseFirestore firestore})
      : this._firestore = firestore ?? FirebaseFirestore.instance;

  Future add(HabitTemplate habitTemplate) {
    _firestore.collection(collectionPath).add(habitTemplate.toMap());
  }
}
