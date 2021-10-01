import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/blocs/habit_bloc/habit_bloc.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/pages/modify_habit_page.dart';
import 'package:habit_tracker/widgets/custom_card.dart';
import 'package:habit_tracker/widgets/daily_habit.dart';
import 'package:habit_tracker/widgets/rounded_button.dart';
import 'package:habit_tracker/widgets/spacer_box.dart';
import 'package:habit_tracker/widgets/streak_card.dart';

class HabitDetail extends StatelessWidget {
  final Habit habit;

  const HabitDetail({Key key, @required this.habit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                habit.name,
                style: Theme.of(context).textTheme.headline4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            RoundedButton(
                text: 'edit',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => BlocProvider.value(
                            value: BlocProvider.of<HabitBloc>(context),
                            child: ModifyHabitPage(
                              habit: habit,
                            )),
                      ));
                })
          ],
        ),
        SpacerBox.size16(),
        _multiDayOverview(habit),
        SpacerBox.size16(),
        StreakCard(
          streak: habit.streak,
        ),
        SpacerBox.size16(),
        _deleteButton(context, habit),
      ],
    );
  }

  Widget _deleteButton(BuildContext context, Habit habit) {
    return Center(
      child: TextButton(
          onPressed: () {
            Navigator.pop(context);
            BlocProvider.of<HabitBloc>(context).add(HabitDeleted(habit));
          },
          child: Text('delete this habit'.toUpperCase())),
    );
  }

  List<DateTime> dates() {
    DateTime today = DateTime.now();
    List<DateTime> dates = List<DateTime>.generate(
        5, (index) => today.subtract(Duration(days: index)));
    return dates.reversed.toList();
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
}
