import 'package:flutter/material.dart';

part 'puus.dart';

part 'puu_image.dart';

part 'error_puu.dart';

class Puu extends StatelessWidget {
  final _PuuImage puu;
  final String text;
  final double sizeInPx;
  final double maxWidthForText;
  final TextStyle? textStyle;

  const Puu(
    this.puu,
    this.text, {
    Key? key,
    this.sizeInPx = 250,
    this.textStyle,
    this.maxWidthForText = 150,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(image: puu, width: sizeInPx, height: sizeInPx),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidthForText),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: textStyle,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
