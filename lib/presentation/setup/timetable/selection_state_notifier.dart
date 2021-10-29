import 'package:flutter/cupertino.dart';

import 'typedefs.dart';

class SelectionStateNotifier extends ValueNotifier<WeekSelectionState> {
  SelectionStateNotifier() : super(WeekSelectionState());

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}