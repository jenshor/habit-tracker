import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/blocs/habit_bloc/habit_bloc.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/widgets/custom_card.dart';
import 'package:habit_tracker/widgets/custom_scaffold.dart';
import 'package:habit_tracker/widgets/daily_habit.dart';
import 'package:habit_tracker/widgets/habit_detail.dart';
import 'package:habit_tracker/widgets/spacer_box.dart';
import 'package:habit_tracker/widgets/streak_card.dart';

class HabitDetailPage extends StatelessWidget {
  final String habitId;

  const HabitDetailPage({
    Key key,
    @required this.habitId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitBloc, HabitState>(
      builder: (context, state) {
        Habit habit = state.habits[habitId];
        return CustomScaffold(
          child: habit != null ? HabitDetail(habit: habit) : Container(),
        );
      },
    );
  }
}
