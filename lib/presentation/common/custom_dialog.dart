import 'package:flutter/material.dart';
import 'package:pretend/presentation/common/app_colors.dart';

Dialog _confirmationDialogBuilder(BuildContext context) => Dialog(
      shape: ContinuousRectangleBorder(),
      elevation: 0,
      child: Container(
        color: AppColors.DARK,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              'Changes will be lost!',
              style: TextStyle(
                color: AppColors.PRIMARY,
                fontSize: 24.0,
              ),
            ),
            Text(
              'Are you sure you want to go back?',
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop<bool>(true),
                  child: Text(
                    'YES',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop<bool>(false),
                  child: Text(
                    'NO',
                    style: TextStyle(
                      color: AppColors.PRIMARY,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );

extension ContextWithCustomDialog on BuildContext {
  Future<bool> showConfirmationDialog() async {
    return await showDialog<bool>(
          context: this,
          builder: _confirmationDialogBuilder,
          barrierColor: Colors.black.withOpacity(0.70),
        ) ??
        false;
  }
}
