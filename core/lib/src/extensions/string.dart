extension IntelligentRegex on String {
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
}
