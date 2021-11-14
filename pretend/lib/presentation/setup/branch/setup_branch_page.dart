import 'package:flutter/material.dart';
import 'package:core/widgets.dart';
import 'package:pretend/presentation/setup/branch/setup_branch_page_item.dart';

class SetupBranchPage extends StatefulWidget {
  const SetupBranchPage({Key? key}) : super(key: key);

  @override
  _SetupBranchPageState createState() => _SetupBranchPageState();
}

class _SetupBranchPageState extends State<SetupBranchPage> {
  int _year = -1;
  int _batch = -1;
  int _group = -1;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Subjects",
      subtitle: "Configure your specialisation",
      body: Column(
        children: [
          SetupBranchPageItem(
            category: "Year",
            chipLabels: const ["1", "2", "3", "4"],
            onSelected: (int index) => _year = index,
          ),
          const SetupBranchPageItem(
            category: "Branch",
            child: Text("<BRANCHES>"),
          ),
          SetupBranchPageItem(
            category: "Batch",
            chipLabels: const ["1", "2"],
            onSelected: (int index) => _batch = index,
          ),
          SetupBranchPageItem(
            category: "Group",
            chipLabels: const ["A", "B", "C"],
            onSelected: (int index) => _group = index,
          ),
          const Spacer(flex: 2),
          Align(
            alignment: const Alignment(1, 0),
            child: NextAccentButton(
              onTap: () => print("$_year $_batch $_group"),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
