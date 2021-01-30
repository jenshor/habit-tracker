import 'package:flutter/material.dart';
import 'package:habit_tracker/models/user.dart';

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
    return Container();
  }
}
