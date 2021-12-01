import 'package:flutter/material.dart';

class FadedEdgeBox extends StatelessWidget {
  final Widget? child;
  final double intensity;
  final double offsetFromBottom;

  const FadedEdgeBox({
    Key? key,
    this.child,
    this.intensity = 0.3,
    this.offsetFromBottom = 0,
  })  : assert(intensity > 0 && intensity <= 2),
        assert(offsetFromBottom > 0 && offsetFromBottom < 2),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment(0, 1 - intensity),
          end: Alignment(0, 1 - offsetFromBottom),
          colors: const [Colors.black, Colors.transparent],
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      blendMode: BlendMode.dstIn,
      child: child,
    );
  }
}
