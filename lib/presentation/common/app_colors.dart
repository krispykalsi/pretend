import 'dart:ui';

import 'package:pretend/domain/entities/class_category_enum.dart';

class AppColors {
  static const PRIMARY = Color(0xffffffff);
  static const SECONDARY = Color(0xff9c9c9c);
  static var ACCENT = Color(0xffffc2c2);
  static const DARK = Color(0xff242424);
  static const THEORY = Color(0xfffff733);
  static const TUTORIAL = Color(0xff33f3ff);
  static const LAB = Color(0xff99ff33);

  static Map<String, Color> classCategory = const {
    ClassCategories.LAB: AppColors.LAB,
    ClassCategories.THEORY: AppColors.THEORY,
    ClassCategories.TUTORIAL: AppColors.TUTORIAL,
  };
}

String getClassCategoryFromColor(Color color) {
  return AppColors.classCategory.keys.firstWhere(
    (category) => color == AppColors.classCategory[category],
    orElse: () => "",
  );
}
