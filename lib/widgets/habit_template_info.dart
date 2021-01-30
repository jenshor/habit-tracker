import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit_template.dart';
import 'package:habit_tracker/widgets/checkmark.dart';
import 'package:habit_tracker/widgets/spacer_box.dart';

class HabitTemplateInfo extends StatelessWidget {
  final HabitTemplate habitTemplate;

  const HabitTemplateInfo({Key key, this.habitTemplate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: Colors.white),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Row(
          children: [
            Checkmark(
              isCompleted: true,
            ),
            SpacerBox.size24(),
            Column(
              children: [
                Text(
                  habitTemplate.name,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
