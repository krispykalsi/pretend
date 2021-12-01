import 'package:flutter/material.dart';

import 'about_section.dart';
import 'images.dart';
import 'person_appreciation.dart';

class ThanksSection extends StatelessWidget {
  const ThanksSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AboutSection(
      heading: "Thanks",
      body: Column(
        children: [
          PersonAppreciation(
            name: "Robert C. Martin",
            nickname: "Uncle Bob",
            image: Images.uncleBob,
            youtubeUrl: "https://www.youtube.com/results?search_query=uncle+bob",
            twitterHandle: "unclebobmartin",
            body:
                "For making 9hour presentations more engaging than most TV series. One of the best presenters I’ve ever listened to. ",
          ),
          PersonAppreciation(
            name: "Matej Rešetár",
            nickname: "Reso Coder",
            image: Images.resoCoder,
            youtubeUrl: "https://www.youtube.com/c/ResoCoder",
            twitterHandle: "resocoder",
            body:
                "For the best content on Flutter. Couldn’t have made this app as cleanly and easily without your courses. Thank you so much for the epic video and written tutorials!",
          ),
          Column(
            children: [
              Text(
                "...and the Flutter team for creating this framework and the amazing content (especially the videos).",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Image(image: Images.flutterTeam, height: 200),
            ],
          )
        ],
      ),
    );
  }
}
