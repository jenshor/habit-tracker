import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/blocs/habit_bloc/habit_bloc.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/pages/habit_detail_page.dart';
import 'package:habit_tracker/widgets/checkmark.dart';
import 'package:habit_tracker/widgets/custom_card.dart';
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => BlocProvider.value(
                child: HabitDetailPage(
                  habitId: habit.id.value,
                ),
                value: BlocProvider.of<HabitBloc>(context)),
          ),
        );
      },
      child: CustomCard(
        child: Row(
          children: [
            Checkmark(
              habit: habit,
              onPressed: () {
                BlocProvider.of<HabitBloc>(context).add(
                    HabitCompletionToggled(habit: habit, date: DateTime.now()));
              },
            ),
            SpacerBox.size24(),
            Flexible(
              child: Text(
                habit.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
