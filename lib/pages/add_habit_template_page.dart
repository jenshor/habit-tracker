import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/blocs/habit_template_bloc/habit_template_bloc.dart';
import 'package:habit_tracker/models/habit_template.dart';

class AddHabitTemplatePage extends StatefulWidget {
  @override
  _AddHabitTemplatePageState createState() => _AddHabitTemplatePageState();
}

class _AddHabitTemplatePageState extends State<AddHabitTemplatePage> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Habit'),
      ),
      body: BlocBuilder<HabitTemplateBloc, HabitTemplateState>(
        builder: (context, state) {
          return Column(
            children: [
              TextField(
                controller: nameController,
              ),
              RaisedButton(
                onPressed: () {
                  BlocProvider.of<HabitTemplateBloc>(context).add(
                      HabitTemplateAdded(
                          HabitTemplate(name: nameController.text)));
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
