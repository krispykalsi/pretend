import 'package:flutter/material.dart';

const _STARTS_AT = "starts @";
const _FINISHES_AT = "finishes @";
const _TIME_LEFT = "time left";

class StartsAtTimeComponent extends StatelessWidget {
  const StartsAtTimeComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TimeRow(_STARTS_AT, "1:00 PM"),
        _TimeRow(_FINISHES_AT, "2:00 PM"),
      ],
    );
  }
}

class TimeLeftTimeComponent extends StatefulWidget {
  const TimeLeftTimeComponent({Key? key}) : super(key: key);

  @override
  State<TimeLeftTimeComponent> createState() => _TimeLeftTimeComponentState();
}

class _TimeLeftTimeComponentState extends State<TimeLeftTimeComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TimeRow(_TIME_LEFT, "1h 06m"),
        _TimeRow(_FINISHES_AT, "2:00 PM"),
      ],
    );
  }
}

class _TimeRow extends StatelessWidget {
  const _TimeRow(this.leftString, this.rightString, {Key? key}) : super(key: key);

  final String leftString;
  final String rightString;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 130 * MediaQuery.of(context).textScaleFactor,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              leftString,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              rightString,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
