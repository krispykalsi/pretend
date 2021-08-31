import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const DARK = Color(0xff242424);

class SubjectCategoryBadge extends StatelessWidget {
  final Color color;
  final String text;

  SubjectCategoryBadge({
    required this.color,
    required String text,
    Key? key,
  })  : text = text.toUpperCase(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 1.5,
          horizontal: 3,
        ),
        child: Text(
          text,
          style: GoogleFonts.notoSans(
            textStyle: TextStyle(
              letterSpacing: 1.5 * MediaQuery.of(context).textScaleFactor,
              fontSize: 11,
              fontWeight: FontWeight.w900,
              color: DARK,
            ),
          ),
        ),
      ),
    );
  }
}
