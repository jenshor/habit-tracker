import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habit_tracker/constants/constant_colors.dart';
import 'package:habit_tracker/widgets/custom_card.dart';
import 'package:habit_tracker/widgets/spacer_box.dart';

class StreakCard extends StatelessWidget {
  final int streak;

  const StreakCard({
    Key key,
    @required this.streak,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: Row(
      children: [
        CircleAvatar(
          backgroundColor: ConstantColors.green,
          child: Icon(
            FontAwesomeIcons.redoAlt,
            color: Colors.white,
          ),
        ),
        SpacerBox.size16(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              streak.toString(),
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              'Streak'.toUpperCase(),
              style: Theme.of(context).textTheme.overline,
            )
          ],
        ),
      ],
    ));
  }
}
