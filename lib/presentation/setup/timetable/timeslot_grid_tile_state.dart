import 'package:flutter/material.dart';

class TimeslotGridTileState {
  bool isSelected = false;
  Color color = Colors.white12;

  TimeslotGridTileState(this.isSelected, this.color);

  @override
  String toString() => "($isSelected, $color)";
}
