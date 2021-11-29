import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  final String text;

  const SectionHeading(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline2,
    );
  }
}
