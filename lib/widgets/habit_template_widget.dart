import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit_template.dart';

class HabitTemplateWidget extends StatelessWidget {
  final HabitTemplate habitTemplate;

  const HabitTemplateWidget({
    Key key,
    this.habitTemplate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(habitTemplate.name),
    );
  }
}
