import 'package:core/network.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'about_section.dart';
import 'white_icon.dart';

class ContributeSection extends StatelessWidget {
  const ContributeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AboutSection(
      heading: "Contribute",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
              "Don’t waste time on silly things and go contribute to this app. You can leave design suggestions, ideas for new features, report bugs, write tests; everything counts as a contribution :D Also I’m a sucker for constructive criticism, pls roast the code/design."),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildButton(
                "Code",
                FontAwesomeIcons.github,
                "https://github.com/ISKalsi/pretend"
              ),
              const SizedBox(width: 12),
              _buildButton(
                "Design",
                FontAwesomeIcons.figma,
                "https://www.figma.com/file/R1PNiApujy4o5uTYYGVfLv/Pretend?node-id=0%3A1"
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildButton(String text, IconData icon, String url) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => launchURL(url),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 4),
          WhiteIcon(icon),
        ],
      ),
    );
  }
}
