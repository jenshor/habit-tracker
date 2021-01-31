import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/blocs/habit_bloc/habit_bloc.dart';
import 'package:habit_tracker/forms/widgets/modify_habit_form.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/widgets/custom_scaffold.dart';
import 'package:habit_tracker/widgets/spacer_box.dart';

class ModifyHabitPage extends StatefulWidget {
  @override
  _ModifyHabitPageState createState() => _ModifyHabitPageState();
}

class _ModifyHabitPageState extends State<ModifyHabitPage> {
  TextEditingController nameController = TextEditingController();

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
