import 'package:flutter/material.dart';

class ButtonDone extends StatelessWidget {
  final VoidCallback onTap;

  const ButtonDone({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 48,
      icon: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.green.shade600,
        ),
        // margin: const EdgeInsets.all(12),
        child: Center(
          child: Icon(
            Icons.check,
            size: 32,
          ),
        ),
      ),
      onPressed: onTap,
    );
  }
}
