import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Icon icon;
  final Function() onPressed;

  const RoundedButton({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      elevation: 0,
      padding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      onPressed: onPressed,
      icon: icon,
      label: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
