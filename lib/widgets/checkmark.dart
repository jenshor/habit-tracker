import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habit_tracker/blocs/habit_bloc/habit_bloc.dart';
import 'package:habit_tracker/constants/colors.dart';
import 'package:habit_tracker/models/habit.dart';

class Checkmark extends StatelessWidget {
  final Habit habit;
  const Checkmark({Key key, @required this.habit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<HabitBloc>(context).add(HabitCompletionToggled(
          habit: habit,
        ));
      },
      child: CircleAvatar(
        backgroundColor: _backgroundColor(),
        child: Icon(
          FontAwesomeIcons.check,
          size: 24,
          color: Colors.white,
        ),
      ),
    );
  }

  Color _backgroundColor() {
    Color color = ConstantColors.gray;

    if (habit != null && habit.isCompleted) {
      color = ConstantColors.green;
    }

    return color;
  }
}
