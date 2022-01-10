import 'package:core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretend/application/bloc/home/notifications/notifications_cubit.dart';
import 'package:pretend/injection_container.dart';

class NotificationButton extends StatelessWidget {
  final NotificationsCubit _notificationsCubit = sl<NotificationsCubit>();

  NotificationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: IconButton(
        icon: BlocBuilder(
          bloc: _notificationsCubit,
          builder: (context, state) {
            if (state is NotificationsOn) {
              return Icon(Icons.notifications, color: AppColors.accent);
            } else if (state is NotificationOff) {
              return Icon(Icons.notifications_off, color: AppColors.accent);
            } else if (state is Loading) {
              return const CircularProgressIndicator();
            }
            return const SizedBox.shrink();
          },
        ),
        onPressed: _notificationsCubit.toggleNotificationStatus,
      ),
    );
  }
}
