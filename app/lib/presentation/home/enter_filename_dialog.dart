import 'package:flutter/material.dart';

import 'enter_filename_dialog_body.dart';

Future<String?> showEnterFilenameDialog(BuildContext context) =>
    context.showAddNewSubjectDialog();

extension ContextWithCustomDialog on BuildContext {
  Future<String?> showAddNewSubjectDialog() => showDialog<String>(
        context: this,
        builder: (context) => const Dialog(
          shape: ContinuousRectangleBorder(),
          elevation: 0,
          child: EnterFilenameDialogBody(),
        ),
        barrierColor: Colors.black.withOpacity(0.70),
      );
}
