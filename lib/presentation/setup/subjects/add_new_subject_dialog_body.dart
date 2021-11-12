import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/presentation/common/app_colors.dart';
import 'package:auto_route/auto_route.dart';

class AddNewSubjectDialogBody extends StatefulWidget {
  const AddNewSubjectDialogBody({Key? key}) : super(key: key);

  @override
  State<AddNewSubjectDialogBody> createState() =>
      _AddNewSubjectDialogBodyState();
}

class _AddNewSubjectDialogBodyState extends State<AddNewSubjectDialogBody> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _code = "";

  void _onOkTap() {
    if (_formKey.currentState?.validate() ?? false) {
      final subject = Subject(_name, _code);
      context.router.pop(subject);
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
            SizedBox(height: 10),
            Text(
              'New subject',
              style: TextStyle(
                color: AppColors.ACCENT,
                fontSize: 28.0,
              ),
            ),
            Text('Enter subject details'),
            SizedBox(height: 30),
            _buildTextField(
              "Name",
              onChanged: (name) => _name = name,
            ),
            _buildTextField(
              "Code",
              allCaps: true,
              onChanged: (code) => _code = code,
            ),
            SizedBox(height: 10),
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

  Widget _buildTextField(
    String hintText, {
    bool allCaps = false,
    required Function(String) onChanged,
  }) {
    final errorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 3),
      borderRadius: BorderRadius.zero,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '';
          }
          return null;
        },
        onChanged: onChanged,
        textCapitalization:
            allCaps ? TextCapitalization.characters : TextCapitalization.words,
        cursorColor: AppColors.PRIMARY,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white12,
          errorStyle: TextStyle(height: 0),
          errorBorder: errorBorder,
          focusedErrorBorder: errorBorder,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyText2,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.ACCENT, width: 3),
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
            color: highlight ? AppColors.ACCENT : AppColors.PRIMARY,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
