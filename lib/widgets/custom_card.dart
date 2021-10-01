import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final double padding;
  const CustomCard({
    Key key,
    @required this.child,
    this.padding = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: child,
      ),
    );
  }
}
