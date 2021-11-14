part of 'subject_list_tile.dart';

class _CustomVerticalDivider extends StatelessWidget {
  const _CustomVerticalDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        width: 20,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Center(
            child: Container(
              color: AppColors.SECONDARY,
              width: 1,
            ),
          ),
        )
    );
  }
}
