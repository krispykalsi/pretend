import 'package:core/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretend/application/bloc/setup/subjects/fetch_subjects_online/fetch_subjects_online_bloc.dart';
import 'package:pretend/injection_container.dart';

import 'college/set_college_dialog.dart';

class NoSubjectsInListSection extends StatelessWidget {
  final VoidCallback _onAddNewSubject;
  final VoidCallback _onSubjectListUpdate;
  final bool alreadyFetchedOnce;

  final _fetchSubjectsOnlineBloc = sl<FetchSubjectsOnlineBloc>();

  NoSubjectsInListSection({
    Key? key,
    this.alreadyFetchedOnce = false,
    required VoidCallback onAddNewSubject,
    required VoidCallback onSubjectListUpdate,
  })  : _onAddNewSubject = onAddNewSubject,
        _onSubjectListUpdate = onSubjectListUpdate,
        super(key: key);

  void _onFetchSubjectsTapped() {
    _fetchSubjectsOnlineBloc.add(const FetchSubjectsEvent());
  }

  void _setCollege(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      showSetCollegeDialog(context).then((successful) {
        if (successful) {
          _fetchSubjectsOnlineBloc.add(const FetchSubjectsEvent());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<FetchSubjectsOnlineBloc, FetchSubjectsOnlineState>(
        bloc: _fetchSubjectsOnlineBloc,
        builder: (blocContext, state) {
          if (state is FetchSubjectsOnlineInitial) {
            return alreadyFetchedOnce
                ? _addAndRefreshButtons
                : _fetchSubjectsButton;
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
            _setCollege(context);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "College not configured",
                  style: TextStyle(color: Colors.redAccent),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () => _setCollege(context),
                  child: Text("Retry"),
                )
              ],
            );
          } else if (state is Error) {
            return _buildUnexpectedErrorState(state.msg);
          }
          return _addManuallyButton;
        },
      ),
    );
  }

  Widget _buildUnexpectedErrorState(String msg) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ErrorPuu(title: "Something went wrong", body: msg),
        const SizedBox(height: 10),
        _fetchSubjectsButton,
      ],
    );
  }

  Widget get _buildNoInternetState {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ErrorPuu(
          title: "Bad internet connection",
          body: "Can't fetch data with these peasant speeds",
        ),
        const SizedBox(height: 10),
        _addAndRefreshButtons,
      ],
    );
  }

  Widget get _buildNoSubjectsFoundState {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("No subjects found for your college"),
        const SizedBox(height: 10),
        _addManuallyButton,
      ],
    );
  }

  Widget get _addAndRefreshButtons {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text("If your subject didn't show up in the search then..."),
        ),
        _addManuallyButton,
        // const SizedBox(height: 8),
        // _refreshButton,
      ],
    );
  }

  // Widget get _refreshButton {
  //   return ElevatedButton(
  //     onPressed: _onFetchSubjectsTapped,
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Icon(Icons.cloud_download),
  //         const SizedBox(width: 10),
  //         Text("Update"),
  //       ],
  //     ),
  //   );
  // }

  Widget get _fetchSubjectsButton {
    return ElevatedButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.download),
          SizedBox(width: 10),
          Text("Fetch Subjects"),
        ],
      ),
      onPressed: _onFetchSubjectsTapped,
    );
  }

  Widget get _addManuallyButton {
    return ElevatedButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.add),
          SizedBox(width: 10),
          Text("Add Manually"),
        ],
      ),
      onPressed: _onAddNewSubject,
    );
  }
}
