import 'package:core/app_colors.dart';
import 'package:core/network.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pretend/presentation/about/white_icon.dart';

class PersonAppreciation extends StatelessWidget {
  const PersonAppreciation({
    Key? key,
    required this.name,
    required this.nickname,
    required this.image,
    required this.body,
    required this.youtubeUrl,
    required this.twitterHandle,
  }) : super(key: key);

  final String name;
  final String nickname;
  final AssetImage image;
  final String body;
  final String youtubeUrl;
  final String twitterHandle;

  @override
  Widget build(BuildContext context) {
    const nicknameStyle = TextStyle(color: AppColors.SECONDARY);
    final twitterUrl = "https://twitter.com/$twitterHandle";
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Text(" aka ", style: nicknameStyle),
                      Text(nickname, style: nicknameStyle),
                    ],
                  ),
                  Text(body, softWrap: true),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Column(
            children: [
              CircleAvatar(backgroundImage: image, radius: 50),
              Row(
                children: [
                  IconButton(
                    onPressed: () => launchURL(youtubeUrl),
                    icon: WhiteIcon(FontAwesomeIcons.youtube),
                  ),
                  IconButton(
                    onPressed: () => launchURL(twitterUrl),
                    icon: WhiteIcon(FontAwesomeIcons.twitter),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
