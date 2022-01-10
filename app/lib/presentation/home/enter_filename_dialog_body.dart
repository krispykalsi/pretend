import 'package:auto_route/auto_route.dart';
import 'package:core/app_colors.dart';
import 'package:flutter/material.dart';

class EnterFilenameDialogBody extends StatefulWidget {
  const EnterFilenameDialogBody({Key? key}) : super(key: key);

  @override
  State<EnterFilenameDialogBody> createState() =>
      _EnterFilenameDialogBodyState();
}

class _EnterFilenameDialogBodyState extends State<EnterFilenameDialogBody> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";

  void _onOkTap() {
    if (_formKey.currentState?.validate() ?? false) {
      context.router.pop(_name);
    }
  }

  void _onCancelTap() {
    context.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.DARK,
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 10),
            Text(
              'Export Timetable',
              style: TextStyle(
                color: AppColors.accent,
                fontSize: 28.0,
              ),
            ),
            const Text('Enter file name'),
            const SizedBox(height: 30),
            _buildTextField(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildDialogButton("OK", _onOkTap, highlight: true),
                _buildDialogButton("CANCEL", _onCancelTap),
              ],
            )
          ],
        ),
      ),
    );
  }

  String get _defaultFileName {
    final now = DateTime.now();
    return "timetable${now.year}${now.month}${now.day}";
  }

  Widget _buildTextField() {
    const errorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 3),
      borderRadius: BorderRadius.zero,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextFormField(
        initialValue: _defaultFileName,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '';
          }
          return null;
        },
        onChanged: (name) => _name = name,
        cursorColor: AppColors.PRIMARY,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white12,
          errorStyle: const TextStyle(height: 0),
          errorBorder: errorBorder,
          focusedErrorBorder: errorBorder,
          hintText: "File name",
          hintStyle: Theme.of(context).textTheme.bodyText2,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.accent, width: 3),
            borderRadius: BorderRadius.zero,
          ),
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  TextButton _buildDialogButton(String text, VoidCallback onTap,
          {bool highlight = false}) =>
      TextButton(
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            color: highlight ? AppColors.accent : AppColors.PRIMARY,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
