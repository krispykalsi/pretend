import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

class CustomScaffold extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? body;

  const CustomScaffold(
      {Key? key, required this.title, required this.subtitle, this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.DARK,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        toolbarHeight: 120,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleSpacing: 30,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              overflow: TextOverflow.fade,
              style: Theme.of(context).textTheme.headline2,
            ),
            Text(
              subtitle,
              overflow: TextOverflow.fade,
              style: Theme.of(context).textTheme.headline3,
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}
