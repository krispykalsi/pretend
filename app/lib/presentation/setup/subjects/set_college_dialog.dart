import 'package:flutter/material.dart';

import 'set_college_dialog_body.dart';

Future<bool> showSetCollegeDialog(BuildContext context) =>
    context.showSetCollegeDialog();

extension ContextWithCustomDialog on BuildContext {
  Future<bool> showSetCollegeDialog() async =>
      await showDialog<bool>(
        context: this,
        builder: (context) => const Dialog(
          shape: ContinuousRectangleBorder(),
          elevation: 5,
          child: SetCollegeDialogBody(),
        ),
        barrierColor: Colors.black.withOpacity(0.70),
      ) ??
      false;
}
