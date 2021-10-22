import 'package:flutter/material.dart';
import 'package:pretend/domain/entities/subject.dart';
import 'package:pretend/presentation/common/custom_scaffold.dart';
import 'package:pretend/presentation/widgets/setup_timetable/compact_subject_view.dart';

class SetupTimetableView extends StatelessWidget {
  const SetupTimetableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Subjects",
      subtitle: "select your electives",
      body: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Autocomplete(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  return [Subject("Computer Networks", "IT-124")];
                },
                fieldViewBuilder:
                    (ctx, controller, focusNode, onEditingComplete) {
                  return TextField(
                    cursorColor: Colors.white,
                    focusNode: focusNode,
                    controller: controller,
                    onEditingComplete: onEditingComplete,
                    style: Theme.of(ctx).textTheme.bodyText1,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                      hintText: "Search by name or code",
                      hintStyle: Theme.of(ctx).textTheme.bodyText2,
                      border: InputBorder.none,
                    ),
                  );
                },
                onSelected: (object) {
                  print(object);
                },
                optionsViewBuilder: (ctx, Function(Object) onSelected, options) {
                  return Material(
                    color: Colors.transparent,
                    child: ListView.builder(
                      itemBuilder: (ctx, idx) {
                        return ListTile(
                          title: CompactSubjectView(options.elementAt(idx) as Subject),
                          onTap: () => onSelected(options.elementAt(idx) ?? ""),
                        );
                      },
                      itemCount: options.length,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            print("pressed");
          },
          icon: Icon(Icons.check_sharp)),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  Widget buildLeading(BuildContext context) {
    return SizedBox();
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text('suggestions');
  }
}
