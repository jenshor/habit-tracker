import 'package:flutter/material.dart';

class OverviewDetailRow extends StatelessWidget {
  final String detail;
  final String text;
  const OverviewDetailRow({
    Key key,
    this.detail,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 40,
          child: Text(
            detail,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    );
  }
}
