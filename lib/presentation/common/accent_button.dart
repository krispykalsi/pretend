import 'package:flutter/material.dart';
import 'package:pretend/presentation/common/app_colors.dart';

abstract class AccentButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool? isAtRight;

  const AccentButton(this.text, {Key? key, this.onTap, this.isAtRight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _borderRadius = isAtRight == null
        ? BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          )
        : BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          );
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          color: AppColors.ACCENT,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.headline2!.fontFamily,
              fontWeight: FontWeight.bold,
              color: AppColors.DARK,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}

class NextAccentButton extends AccentButton {
  const NextAccentButton({required VoidCallback onTap})
      : super("Next", onTap: onTap);
}

class BackAccentButton extends AccentButton {
  const BackAccentButton({required VoidCallback onTap})
      : super("Back", onTap: onTap, isAtRight: false);
}

class DoneAccentButton extends AccentButton {
  const DoneAccentButton({required VoidCallback onTap})
      : super("Done", onTap: onTap);
}

class ContinueAccentButton extends AccentButton {
  const ContinueAccentButton({required VoidCallback onTap})
      : super("Continue", onTap: onTap);
}
