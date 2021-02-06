import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habit_tracker/constants/constant_colors.dart';
import 'package:habit_tracker/helper/date_time_helper.dart';
import 'package:habit_tracker/models/habit.dart';

class Checkmark extends StatelessWidget {
  final double size;
  final Habit habit;
  final DateTime date;
  final Function() onPressed;

  const Checkmark({
    Key key,
    @required this.habit,
    @required this.onPressed,
    this.date,
    this.size = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => this.onPressed(),
      child: CircleAvatar(
        radius: this.size / 2 + 8,
        backgroundColor: _backgroundColor(),
        child: Icon(
          FontAwesomeIcons.check,
          size: this.size,
          color: Colors.white,
        ),
      ),
    );
  }

  Color _backgroundColor() {
    Color color = ConstantColors.gray;

    if (DateTimeHelper().isCompletedOnDay(habit, date ?? DateTime.now())) {
      color = ConstantColors.green;
    }

    return color;
  }
}
