import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/blocs/habit_bloc/habit_bloc.dart';
import 'package:habit_tracker/models/habit.dart';

class AddHabitPage extends StatefulWidget {
  @override
  _AddHabitPageState createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Habit'),
      ),
      body: BlocBuilder<HabitBloc, HabitState>(
        builder: (context, state) {
          return Column(
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
    );
  }
}
