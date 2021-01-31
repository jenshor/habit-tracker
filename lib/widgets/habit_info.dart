import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/widgets/checkmark.dart';
import 'package:habit_tracker/widgets/spacer_box.dart';

class HabitInfo extends StatelessWidget {
  final Habit habit;
  const HabitInfo({
    Key key,
    @required this.habit,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: Colors.white),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Row(
          children: [
            Checkmark(
              habit: habit,
            ),
            SpacerBox.size24(),
            Column(
              children: [
                Text(
                  habit.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
