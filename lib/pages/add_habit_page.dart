import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/blocs/habit_bloc/habit_bloc.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/widgets/custom_scaffold.dart';
import 'package:habit_tracker/widgets/spacer_box.dart';

class AddHabitPage extends StatefulWidget {
  @override
  _AddHabitPageState createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {
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
          BlocBuilder<HabitBloc, HabitState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: nameController,
                  ),
                  RaisedButton(
                    onPressed: () {
                      BlocProvider.of<HabitBloc>(context)
                          .add(HabitAdded(Habit.fromDate(
                        name: nameController.text,
                        date: DateTime.now(),
                      )));
                    },
                    child: Text('Add habit'),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
