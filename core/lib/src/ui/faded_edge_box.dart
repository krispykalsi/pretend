import 'package:flutter/material.dart';

class FadedEdgeBox extends StatelessWidget {
  final Widget? child;

  const FadedEdgeBox({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return const LinearGradient(
          begin: Alignment(0, 0.7),
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.transparent],
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      blendMode: BlendMode.dstIn,
      child: child,
    );
  }
}
