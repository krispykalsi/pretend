import 'package:core/network.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'about_section.dart';
import 'images.dart';
import 'white_icon.dart';

const _instagram = "https://instagram.com/ikr.oops";
const _github = "https://github.com/ISKalsi";
const _twitter = "https://twitter.com/ISKalsi";
const _linkedIn = "https://linkedin.com/in/ikroop";
const _mail = "mailto:ikroop.singh.kalsi@gmail.com";

class CreatorSection extends StatelessWidget {
  const CreatorSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AboutSection(
      heading: "Creator",
      body: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("This app is designed and developed by"),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  "Ikroop Singh Kalsi",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              Row(
                children: [
                  _buildSocialButton(FontAwesomeIcons.github, _github),
                  _buildSocialButton(FontAwesomeIcons.twitter, _twitter),
                  _buildSocialButton(FontAwesomeIcons.instagram, _instagram),
                  _buildSocialButton(FontAwesomeIcons.linkedinIn, _linkedIn),
                  _buildSocialButton(Icons.mail, _mail),
                ],
              )
            ],
          ),
          const SizedBox(width: 5),
          _meAndPuu,
        ],
      ),
    );
  }

  Stack get _meAndPuu {
    return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -97,
              left: -15,
              child: Image(image: Images.puuWaving, width: 120),
            ),
            CircleAvatar(backgroundImage: Images.me, radius: 46),
          ],
        );
  }

  Widget _buildSocialButton(IconData icon, String url) => IconButton(
        onPressed: () => launchURL(url),
        icon: WhiteIcon(icon),
      );
}
