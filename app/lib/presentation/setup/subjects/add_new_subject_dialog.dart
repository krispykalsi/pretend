import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/subject.dart';

import 'add_new_subject_dialog_body.dart';


Future<Subject?> showAddNewSubjectDialog(BuildContext context) =>
    context.showAddNewSubjectDialog();

extension ContextWithCustomDialog on BuildContext {
  Future<Subject?> showAddNewSubjectDialog() => showDialog<Subject>(
        context: this,
        builder: (context) => const Dialog(
          shape: ContinuousRectangleBorder(),
          elevation: 0,
          child: AddNewSubjectDialogBody(),
        ),
        barrierColor: Colors.black.withOpacity(0.70),
      );
}
