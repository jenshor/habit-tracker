import 'package:flutter/material.dart';
import 'package:habit_tracker/forms/widgets/modify_habit_form.dart';
import 'package:habit_tracker/widgets/custom_scaffold.dart';
import 'package:habit_tracker/widgets/spacer_box.dart';

class ModifyHabitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'New habit',
            style: Theme.of(context).textTheme.headline3,
          ),
          SpacerBox.size16(),
          ModifyHabitForm()
        ],
      ),
    );
  }
}
