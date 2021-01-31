import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/blocs/habit_bloc/habit_bloc.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/widgets/checkmark.dart';
import 'package:habit_tracker/widgets/spacer_box.dart';
import 'package:intl/intl.dart';

class DailyHabit extends StatelessWidget {
  final Habit habit;
  final DateTime date;
  final DateFormat monthFormatter = DateFormat('MMM');
  DailyHabit({
    Key key,
    @required this.habit,
    @required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          date.day.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SpacerBox.size4(),
        Text(
          monthFormatter.format(date),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
        ),
        SpacerBox.size24(),
        Checkmark(
          onPressed: () {
            BlocProvider.of<HabitBloc>(context).add(
              HabitCompletionToggled(
                habit: habit,
                date: date,
              ),
            );
          },
          habit: habit,
          date: date,
          size: 16,
        )
      ],
    );
  }
}
