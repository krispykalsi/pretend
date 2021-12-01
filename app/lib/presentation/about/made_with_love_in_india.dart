import 'package:flutter/material.dart';

class MadeWithLoveInIndia extends StatelessWidget {
  const MadeWithLoveInIndia({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text("Made with ❤️ in India"),
    );
  }
}
