import 'package:flutter/material.dart';
import 'package:pretend/presentation/initial/hue_painter.dart';

class ThemeSetter extends StatefulWidget {
  final void Function(Color) onColorChange;

  const ThemeSetter({Key? key, required this.onColorChange}) : super(key: key);

  @override
  State<ThemeSetter> createState() => _ThemeSetterState();
}

class _ThemeSetterState extends State<ThemeSetter> {
  var _hue = 0.0;

  Color get _color => HSVColor.fromAHSV(1, _hue, 0.3, 1).toColor();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          setState(() {
            final hueShift = details.delta.dx;
            _hue = ((_hue + hueShift) % 360)..roundToDouble();
          });
        },
        onPanEnd: (_) => widget.onColorChange(_color),
        child: CustomPaint(
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter: HuePainter(_color),
        ),
      );
    });
  }
}
