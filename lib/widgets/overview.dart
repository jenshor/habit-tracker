import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/blocs/habit_bloc/habit_bloc.dart';
import 'package:habit_tracker/widgets/custom_card.dart';
import 'package:habit_tracker/widgets/spacer_box.dart';

class Overview extends StatelessWidget {
  final Function() onHabitClick;
  final Function() onTodoClick;

  const Overview({
    Key key,
    this.onHabitClick,
    this.onTodoClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: Theme.of(context).textTheme.headline4,
        ),
        SpacerBox.size16(),
        BlocBuilder<HabitBloc, HabitState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () => onHabitClick(),
              child: CustomCard(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Habits',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SpacerBox.size16(),
                  DetailRow(
                    detail: state.totalHabits.toString(),
                    text: 'total habits',
                  ),
                  DetailRow(
                    detail: state.unfinishedHabits.toString(),
                    text: 'uncompleted habits',
                  )
                ],
              )),
            );
          },
        ),
        SpacerBox.size24(),
        CustomCard(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'To-Dos',
              style: Theme.of(context).textTheme.headline5,
            ),
            SpacerBox.size16(),
            Row(
              children: [
                Text(
                  'coming soon',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            )
          ],
        ))
      ],
    );
  }
}

class DetailRow extends StatelessWidget {
  final String detail;
  final String text;
  const DetailRow({
    Key key,
    this.detail,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 40,
          child: Text(
            detail,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    );
  }
}
