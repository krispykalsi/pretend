import 'package:flutter/widgets.dart';

import 'typedefs.dart';

class SelectionStateNotifier extends ValueNotifier<WeekSelectionState> {
  SelectionStateNotifier([WeekSelectionState? state])
      : super(state != null ? state : WeekSelectionState());

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
