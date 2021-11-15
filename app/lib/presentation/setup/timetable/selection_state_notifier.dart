import 'package:flutter/widgets.dart';

import 'typedefs.dart';

class SelectionStateNotifier extends ValueNotifier<WeekSelectionState> {
  SelectionStateNotifier([WeekSelectionState? state])
      : super(state ?? {});

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
