import 'package:core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:core/app_colors.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretend/application/bloc/setup/subjects/college/college_bloc.dart';
import 'package:pretend/domain/entities/college.dart';
import 'package:pretend/injection_container.dart';

part 'colleges_autocomplete.dart';

class SetCollegeDialogBody extends StatefulWidget {
  const SetCollegeDialogBody({Key? key}) : super(key: key);

  @override
  State<SetCollegeDialogBody> createState() => _SetCollegeDialogBodyState();
}

class _SetCollegeDialogBodyState extends State<SetCollegeDialogBody> {
  final _formKey = GlobalKey<FormState>();
  final _collegeBloc = sl<CollegeBloc>()..add(GetCollegesEvent());

  String _id = "";

  void _onSetTap() {
    if (_formKey.currentState?.validate() ?? false) {
      _collegeBloc.add(SetCollegeIDEvent(_id));
    }
  }

  void _onOnCollegeSuccessfully() {
    context.router.pop(true);
  }

  void _onCancelTap() {
    context.router.pop(false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.DARK,
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: _dialogContent,
      ),
    );
  }

  Widget get _dialogContent {
    return BlocBuilder(
      bloc: _collegeBloc,
      builder: (context, state) {
        if (state is CollegeIDSetSuccessfully) {
          Future.delayed(
            const Duration(milliseconds: 700),
            _onOnCollegeSuccessfully,
          );
          return Text(
            "College successfully set!",
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          );
        } else if (state is SettingCollegeID) {
          return CircularProgressIndicator();
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            _buildHeading,
            const SizedBox(height: 30),
            _CollegesAutocomplete(
              collegeBloc: _collegeBloc,
              onSelected: (college) => _id = college.id,
            ),
            const SizedBox(height: 10),
            _buildSetCancelButtons
          ],
        );
      },
    );
  }

  Widget get _buildHeading {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'College Setup',
          style: TextStyle(
            color: AppColors.accent,
            fontSize: 28.0,
          ),
        ),
        const Text('Find your college'),
      ],
    );
  }

  Widget get _buildSetCancelButtons {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildDialogButton("SET", _onSetTap, highlight: true),
        _buildDialogButton("CANCEL", _onCancelTap),
      ],
    );
  }

  TextButton _buildDialogButton(
    String text,
    VoidCallback onTap, {
    bool highlight = false,
  }) {
    return TextButton(
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
}
