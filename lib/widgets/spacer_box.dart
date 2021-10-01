import 'package:flutter/material.dart';

class SpacerBox extends StatelessWidget {
  final double size;

  SpacerBox._(this.size);

  SpacerBox.size8() : this._(8);
  SpacerBox.size4() : this._(4);
  SpacerBox.size12() : this._(12);
  SpacerBox.size16() : this._(16);
  SpacerBox.size24() : this._(24);
  SpacerBox.size32() : this._(32);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
    );
  }
}
