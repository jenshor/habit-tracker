import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habit_tracker/constants/colors.dart';

class Checkmark extends StatelessWidget {
  final bool isCompleted;

  const Checkmark({Key key, this.isCompleted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: isCompleted ? ConstantColors.green : ConstantColors.gray,
      child: Icon(
        FontAwesomeIcons.check,
        size: 24,
        color: Colors.white,
      ),
    );
  }
}
