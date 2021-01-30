import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/blocs/habit_template_bloc/habit_template_bloc.dart';
import 'package:habit_tracker/models/habit_template.dart';
import 'package:habit_tracker/models/user.dart';
import 'package:habit_tracker/pages/add_habit_template_page.dart';
import 'package:habit_tracker/widgets/habit_template_info.dart';
import 'package:habit_tracker/widgets/spacer_box.dart';

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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlocBuilder<HabitTemplateBloc, HabitTemplateState>(
        builder: (context, state) {
          List<HabitTemplate> items = state.habitTemplates.values.toList();
          return ListView.separated(
            shrinkWrap: true,
            itemCount: items.length,
            separatorBuilder: (context, index) {
              return SpacerBox.size12();
            },
            itemBuilder: (context, index) {
              HabitTemplate habitTemplate = items[index];
              return HabitTemplateInfo(
                habitTemplate: habitTemplate,
              );
            },
          );
        },
      ),
    );
  }
}
