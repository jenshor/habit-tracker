import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/blocs/habit_bloc/habit_bloc.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/widgets/custom_card.dart';
import 'package:habit_tracker/widgets/custom_scaffold.dart';
import 'package:habit_tracker/widgets/daily_habit.dart';
import 'package:habit_tracker/widgets/spacer_box.dart';

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
          child: habit != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      habit.name,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    SpacerBox.size16(),
                    _multiDayOverview(habit),
                    SpacerBox.size16(),
                    _deleteButton(context, habit),
                  ],
                )
              : Container(),
        );
      },
    );
  }

  Widget _deleteButton(BuildContext context, Habit habit) {
    return Center(
      child: FlatButton(
          onPressed: () {
            Navigator.pop(context);
            BlocProvider.of<HabitBloc>(context).add(HabitDeleted(habit));
          },
          child: Text('delete this habit'.toUpperCase())),
    );
  }

  Widget _multiDayOverview(Habit habit) {
    return CustomCard(
        padding: 24,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: dates()
              .map((DateTime date) => DailyHabit(
                    habit: habit,
                    date: date,
                  ))
              .toList(),
        ));
  }

  List<DateTime> dates() {
    DateTime today = DateTime.now();
    List<DateTime> dates = List<DateTime>.generate(
        5, (index) => today.subtract(Duration(days: index)));
    return dates.reversed.toList();
  }
}
