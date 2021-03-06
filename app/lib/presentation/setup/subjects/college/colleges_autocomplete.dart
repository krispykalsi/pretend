part of 'set_college_dialog_body.dart';

class _CollegesAutocomplete extends StatefulWidget {
  final CollegeBloc collegeBloc;
  final Function(College) onSelected;

  const _CollegesAutocomplete({
    Key? key,
    required this.onSelected,
    required this.collegeBloc,
  }) : super(key: key);

  @override
  _CollegesAutocompleteState createState() => _CollegesAutocompleteState();
}

class _CollegesAutocompleteState extends State<_CollegesAutocomplete> {
  List<College>? _colleges;

  static const _noCollegeEquivalent = [
    College("0", "<College not in List>", "Select this if not found")
  ];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<College>(
      fieldViewBuilder: _buildTextField,
      optionsBuilder: _buildOptions,
      optionsViewBuilder: _buildOptionsView,
      onSelected: (college) {
        FocusScope.of(context).unfocus();
        widget.onSelected(college);
      },
      displayStringForOption: (college) => college.name,
    );
  }

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return '';
    }
    return null;
  }

  Widget _buildTextField(
    BuildContext context,
    TextEditingController controller,
    FocusNode focusNode,
    VoidCallback onSubmitted,
  ) {
    const errorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 3),
      borderRadius: BorderRadius.zero,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: _validator,
        focusNode: focusNode,
        controller: controller,
        onFieldSubmitted: (_) => onSubmitted,
        textCapitalization: TextCapitalization.words,
        cursorColor: AppColors.PRIMARY,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white12,
          errorStyle: const TextStyle(height: 0),
          errorBorder: errorBorder,
          focusedErrorBorder: errorBorder,
          hintText: "College Name",
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

  Iterable<College> _buildOptions(TextEditingValue textEditingValue) {
    final fieldText = textEditingValue.text;
    if (fieldText.isEmpty) {
      return const [];
    }
    final state = widget.collegeBloc.state;
    if (_colleges == null && state is DownloadedColleges) {
      _colleges = state.colleges;
    }
    final filtered = _colleges?.where(
          (college) =>
              college.id.containsAnywhere(fieldText) ||
              college.name.containsAnywhere(fieldText) ||
              college.city.containsAnywhere(fieldText),
        ) ??
        const [];
    return filtered.isEmpty ? _noCollegeEquivalent : filtered;
  }

  Widget _buildOptionsView(
    BuildContext context,
    Function(College) onSelected,
    Iterable<College> options,
  ) {
    final state = widget.collegeBloc.state;
    if (state is DownloadingColleges) {
      return const CircularProgressIndicator();
    } else if (state is CouldNotDownloadColleges || state is NoInternet) {
      return state is NoInternet
          ? ErrorPuu(
              title: "Bad internet connection",
              body: "Can't fetch data with these peasant speeds",
            )
          : ErrorPuu(
              title: "Failed to get colleges",
              body: "Please check again later, or not?",
            );
    }

    final screenW = MediaQuery.of(context).size.width;
    final leftPadding = screenW / 20;
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: leftPadding),
          _buildListView(context, onSelected, options),
        ],
      ),
    );
  }

  Widget _buildListView(
    BuildContext context,
    Function(College) onSelected,
    Iterable<College> options,
  ) {
    final dark = AppColors.DARK.withOpacity(0.9);
    final accent = AppColors.accent;
    final bgColor = Color.alphaBlend(dark, accent);
    return Material(
      color: bgColor,
      elevation: 30,
      child: Container(
        width: 250,
        child: ListView.separated(
          padding: const EdgeInsets.all(5),
          itemBuilder: (ctx, idx) {
            return ListTile(
              title: Text(
                options.elementAt(idx).name,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              subtitle: Text(
                options.elementAt(idx).city,
                style: TextStyle(color: AppColors.SECONDARY),
              ),
              onTap: () => onSelected(options.elementAt(idx)),
            );
          },
          separatorBuilder: (_, __) {
            return Divider(color: Colors.white24, thickness: 2);
          },
          itemCount: options.length,
        ),
      ),
    );
  }
}
