import 'package:app_ui/app_ui.dart';
import 'package:super_cash/app/app.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:super_cash/features/notification/presentation/widges/notificatio_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationCubit(
        fetchNotificationsUseCase: serviceLocator(),
        updateNotificationUseCase: serviceLocator(),
      )..fetchInitialNotification(),
      child: NotificationView(),
    );
  }
}

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: AppAppBarTitle('Notifications'),
        leading: AppLeadingAppBarWidget(onTap: context.pop),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: _NotificationBody(),
      ),
    );
  }
}

class _NotificationBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCubit, NotificationState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isError) {
          openSnackbar(
            SnackbarMessage.error(title: state.message),
            clearIfQueue: true,
          );
        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (_shouldShowLoading(state)) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (state.status == NotificationStatus.failure && state.data.isEmpty) {
          return _buildFailureState(context, state.message);
        }

        // Default case: show the transaction table
        return NotificatioListView(notifications: state.data);
      },
    );
  }

  bool _shouldShowLoading(NotificationState state) {
    return state.status == NotificationStatus.initial ||
        (state.status == NotificationStatus.loading && state.data.isEmpty);
  }

  Widget _buildFailureState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          ElevatedButton(
            onPressed: () =>
                context.read<NotificationCubit>().refreshNotifications(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
