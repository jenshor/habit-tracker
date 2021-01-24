import 'package:habit_tracker/repositories/habit_repository.dart';
import 'package:habit_tracker/repositories/habit_template_repository.dart';
import 'package:mockito/mockito.dart';

class MockHabitTemplateRepository extends Mock
    implements HabitTemplateRepository {}

class MockHabitRepository extends Mock implements HabitRepository {}
