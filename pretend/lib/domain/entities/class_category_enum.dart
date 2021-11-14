import 'dart:ui';

import 'package:core/app_colors.dart';

class ClassCategories {
  static const lab = "lab";
  static const theory = "theory";
  static const tutorial = "tutorial";

  static List<String> get values => const [lab, theory, tutorial];
}

extension ClassCategory on AppColors {
  static Map<String, Color> colors = const {
    ClassCategories.lab: AppColors.LAB,
    ClassCategories.theory: AppColors.THEORY,
    ClassCategories.tutorial: AppColors.TUTORIAL,
  };
}

String getClassCategoryFromColor(Color color) {
  return ClassCategory.colors.keys.firstWhere(
    (category) => color == ClassCategory.colors[category],
    orElse: () => "",
  );
}
