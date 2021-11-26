import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/timeslot.dart';

const _startsAt = "starts @";
const _finishesAt = "finishes @";
const _timeLeft = "time left";

class TimeComponent extends StatefulWidget {
  final Timeslot _timeslot;
  final bool _showTimeLeft;

  const TimeComponent(Timeslot timeslot,
      {Key? key, bool showTimeLeft = false})
      : _timeslot = timeslot,
        _showTimeLeft = showTimeLeft,
        super(key: key);

  @override
  State<TimeComponent> createState() => _TimeComponentState();
}

class _TimeComponentState extends State<TimeComponent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget._showTimeLeft
            ? _TimeRow(_timeLeft, "1h 06m")
            : _TimeRow(_startsAt, widget._timeslot.start),
        _TimeRow(_finishesAt, widget._timeslot.end),
      ],
    );
  }
}

class _TimeRow extends StatelessWidget {
  const _TimeRow(this.leftString, this.rightString, {Key? key})
      : super(key: key);

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
