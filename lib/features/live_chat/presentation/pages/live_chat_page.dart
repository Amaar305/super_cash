import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_cash/app/init/init.dart';
import 'package:super_cash/features/live_chat/presentation/presentation.dart';
import 'package:super_cash/features/live_chat/presentation/widgets/live_chat_channel_tile.dart';

class LiveChatPage extends StatelessWidget {
  const LiveChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LiveChatCubit(fetchSupportsUseCase: serviceLocator())
            ..fetchSupports(),
      child: LiveChatView(),
    );
  }
}

class LiveChatView extends StatelessWidget {
  const LiveChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const AppAppBarTitle('Chat With Us'),
        centerTitle: true,
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () =>
            context.read<LiveChatCubit>().fetchSupports(forceRefresh: true),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: LiveChatListView(),
        ),
      ),
    );
  }
}

class LiveChatListView extends StatelessWidget {
  const LiveChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    final channels = context.select(
      (LiveChatCubit element) => element.state.channels,
    );
    return ListView.separated(
      itemCount: channels.length,
      separatorBuilder: (_, __) => const Gap.v(AppSpacing.md),
      itemBuilder: (context, index) {
        final channel = channels[index];
        return LiveChatChannelTile(channel: channel);
      },
    );
  }
}
