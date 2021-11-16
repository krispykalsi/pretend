import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretend/application/bloc/setup/subjects/fetch_subjects_online/fetch_subjects_online_bloc.dart';
import 'package:pretend/injection_container.dart';

class NoSubjectsInListSection extends StatelessWidget {
  final VoidCallback _onAddNewSubject;
  final VoidCallback _onSubjectListUpdate;
  final VoidCallback _onCollegeNotConfigured;

  final _fetchSubjectsOnlineBloc = sl<FetchSubjectsOnlineBloc>();

  NoSubjectsInListSection(
      {Key? key,
      required VoidCallback onAddNewSubject,
      required VoidCallback onSubjectListUpdate,
      required VoidCallback onCollegeNotConfigured})
      : _onAddNewSubject = onAddNewSubject,
        _onSubjectListUpdate = onSubjectListUpdate,
        _onCollegeNotConfigured = onCollegeNotConfigured,
        super(key: key);

  void _onFetchSubjectsTapped() {
    _fetchSubjectsOnlineBloc.add(const FetchSubjectsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<FetchSubjectsOnlineBloc, FetchSubjectsOnlineState>(
        bloc: _fetchSubjectsOnlineBloc,
        builder: (context, state) {
          if (state is FetchSubjectsOnlineInitial) {
            return _buildFetchSubjectsButton;
          } else if (state is Loading) {
            return CircularProgressIndicator();
          } else if (state is Loaded) {
            if (state.subjects.isEmpty) {
              return _buildNoSubjectsFoundState;
            } else {
              Future.delayed(const Duration(seconds: 1), _onSubjectListUpdate);
              return const Text(
                "Fetch successful",
                style: TextStyle(color: Colors.lightGreen),
              );
            }
          } else if (state is NoInternet) {
            return _buildNoInternetState;
          } else if (state is CollegeNotConfigured) {
            Future.delayed(const Duration(seconds: 1), _onCollegeNotConfigured);
            return const Text(
              "College not configured",
              style: TextStyle(color: Colors.redAccent),
            );
          } else if (state is Error) {
            return _buildUnexpectedErrorState(state.msg);
          }
          return _buildAddNewSubjectButton;
        },
      ),
    );
  }

  Widget _buildUnexpectedErrorState(String msg) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Something went wrong",
          style: TextStyle(color: Colors.redAccent),
        ),
        Text(msg),
        const SizedBox(height: 10),
        _buildFetchSubjectsButton,
      ],
    );
  }

  Widget get _buildNoInternetState {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Please check your internet connection",
          style: TextStyle(color: Colors.redAccent),
        ),
        const SizedBox(height: 10),
        _buildFetchSubjectsButton,
      ],
    );
  }

  Widget get _buildNoSubjectsFoundState {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("No subjects found for your college"),
        const SizedBox(height: 10),
        _buildAddNewSubjectButton,
      ],
    );
  }

  Widget get _buildFetchSubjectsButton {
    return ElevatedButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.download),
          SizedBox(width: 10),
          Text(
            "Fetch Subjects",
          ),
        ],
      ),
      onPressed: _onFetchSubjectsTapped,
    );
  }

  Widget get _buildAddNewSubjectButton {
    return ElevatedButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.add),
          SizedBox(width: 10),
          Text(
            "Add Subject Manually",
          ),
        ],
      ),
      onPressed: _onAddNewSubject,
    );
  }
}
