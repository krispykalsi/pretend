extension StringExtensions on String {
  bool containsAnywhere(String text) {
    final regex = RegExp(
        text == ""
            ? r'$[\W\D\S-]^'
            : text.replaceAllMapped(RegExp(r'[^ ]'), (Match m) {
                return m[0]! + ".*? ?";
              }),
        caseSensitive: false);
    return this.contains(regex);
  }

  String abbreviate() {
    final cleaned = this.replaceAll(RegExp(r'[^\w ]'), '');
    return cleaned.splitMapJoin(
      RegExp(r'\w+\s*'),
      onMatch: (word) => word[0]![0].toUpperCase(),
    );
  }

  String toTitleCase() {
    return this.splitMapJoin(
      RegExp(r'\w+'),
      onMatch: (word) =>
          word[0]![0].toUpperCase() + word[0]!.substring(1).toLowerCase(),
    );
  }
}
