import 'dart:ui';

import 'package:core/app_colors.dart';

class ClassCategories {
  static const LAB = "lab";
  static const THEORY = "theory";
  static const TUTORIAL = "tutorial";

  static List<String> get values => const [LAB, THEORY, TUTORIAL];
}

extension ClassCategory on AppColors {
  static Map<String, Color> colors = const {
    ClassCategories.LAB: AppColors.LAB,
    ClassCategories.THEORY: AppColors.THEORY,
    ClassCategories.TUTORIAL: AppColors.TUTORIAL,
  };
}

String getClassCategoryFromColor(Color color) {
  return ClassCategory.colors.keys.firstWhere(
    (category) => color == ClassCategory.colors[category],
    orElse: () => "",
  );
}
