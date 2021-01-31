import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/blocs/habit_bloc/habit_bloc.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/models/user.dart';
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
    return BlocBuilder<HabitBloc, HabitState>(builder: (context, state) {
      List<Habit> items = state.habits.values.toList();
      return ListView.separated(
        shrinkWrap: true,
        itemCount: items.length,
        separatorBuilder: (context, index) {
          return SpacerBox.size12();
        },
        itemBuilder: (context, index) {
          return HabitInfo(
            habit: items[index],
          );
        },
      );
    });
  }
}
