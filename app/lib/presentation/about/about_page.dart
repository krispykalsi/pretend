import 'package:core/app_colors.dart';
import 'package:core/widgets.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import 'contribution_section.dart';
import 'creator_section.dart';
import 'made_with_love_in_india.dart';
import 'thanks_section.dart';


class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      textStyle: Theme.of(context).textTheme.bodyText1,
      color: AppColors.DARK,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: FadedEdgeBox(
              intensity: 0.5,
              offsetFromBottom: 0.05,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    CreatorSection(),
                    ContributeSection(),
                    ThanksSection(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: MadeWithLoveInIndia(),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            child: BackAccentButton(onTap: () => context.router.pop()),
          )
        ],
      ),
    );
  }
}
