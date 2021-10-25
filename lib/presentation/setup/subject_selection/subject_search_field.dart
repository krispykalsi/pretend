import 'package:flutter/material.dart';
import 'package:pretend/presentation/common/app_colors.dart';

class SubjectSearchField extends StatelessWidget {
  final TextEditingController controller;

  const SubjectSearchField({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          scrollPadding: const EdgeInsets.all(0),
          cursorColor: Colors.white,
          controller: controller,
          onEditingComplete: () {
            var text = controller.text;
            print(text);
            controller.text = text;
            FocusScope.of(context).unfocus();
          },
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: AppColors.SECONDARY,
            ),
            hintText: "Search by name or code",
            hintStyle: Theme.of(context).textTheme.bodyText2,
            border: InputBorder.none,
          ),
        ),
        Container(
          height: 1,
          color: AppColors.SECONDARY,
        ),
      ],
    );
  }
}
