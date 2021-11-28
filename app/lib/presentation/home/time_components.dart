import 'package:flutter/material.dart';
import 'package:core/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretend/application/bloc/home/time_row/time_row_bloc.dart';
import 'package:pretend/domain/entities/timeslot.dart';
import 'package:pretend/injection_container.dart';

const _startsAt = "starts @";
const _finishesAt = "finishes @";
const _timeLeft = "time left";

class TimeComponent extends StatelessWidget {
  final Timeslot _timeslot;
  final bool _showTimeLeft;

  const TimeComponent(Timeslot timeslot, {Key? key, bool showTimeLeft = false})
      : _timeslot = timeslot,
        _showTimeLeft = showTimeLeft,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _showTimeLeft
            ? _DynamicTimeRow()
            : _TimeRow(_startsAt, _timeslot.start),
        _TimeRow(_finishesAt, _timeslot.end),
      ],
    );
  }
}

class _DynamicTimeRow extends StatefulWidget {
  const _DynamicTimeRow({Key? key}) : super(key: key);

  @override
  State<_DynamicTimeRow> createState() => _DynamicTimeRowState();
}

class _DynamicTimeRowState extends State<_DynamicTimeRow>
    with WidgetsBindingObserver {
  final _timerBloc = sl<TimeRowBloc>();

  @override
  void initState() {
    super.initState();
    _timerBloc.add(InitialiseTimerEvent());
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    _timerBloc.add(CancelTimerEvent());
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        _timerBloc.add(InitialiseTimerEvent());
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        _timerBloc.add(CancelTimerEvent());
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _timerBloc,
      builder: (context, state) {
        var time = "- min";
        if (state is MinuteChanged) {
          time = state.newTime.timeLeftFromNextHour;
        }
        return _TimeRow(_timeLeft, time, key: ValueKey(time));
      },
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
