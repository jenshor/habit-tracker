import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/blocs/habit_template_bloc/habit_template_bloc.dart';
import 'package:habit_tracker/models/habit_template.dart';
import 'package:habit_tracker/models/user.dart';
import 'package:habit_tracker/pages/add_habit_template_page.dart';
import 'package:habit_tracker/widgets/habit_template_info.dart';

class HabitTemplates extends StatefulWidget {
  final User user;

  const HabitTemplates({
    Key key,
    @required this.user,
  }) : super(key: key);
  @override
  _HabitTemplatesState createState() => _HabitTemplatesState();
}

class _HabitTemplatesState extends State<HabitTemplates> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitTemplateBloc, HabitTemplateState>(
      builder: (context, state) {
        return Column(
          children: [
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => BlocProvider.value(
                          value: BlocProvider.of<HabitTemplateBloc>(context),
                          child: AddHabitTemplatePage()),
                    ));
              },
              child: Text('Create new Habit'),
            ),
            ...state.habitTemplates.values
                .map((HabitTemplate habitTemplate) => HabitTemplateInfo(
                      habitTemplate: habitTemplate,
                    ))
                .toList(),
          ],
        );
      },
    );
  }
}
