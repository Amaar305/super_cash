import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:super_cash/features/live_chat/domain/entities/live_chat_channel.dart';
import 'package:super_cash/features/live_chat/presentation/widgets/live_chat_channel_tile.dart';

class LiveChatPage extends StatelessWidget {
  const LiveChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LiveChatView();
  }
}

class LiveChatView extends StatelessWidget {
  const LiveChatView({super.key});

  static final List<LiveChatChannel> _channels = _mockChannelJson
      .map((data) => LiveChatChannel.fromJson(data))
      .toList();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const AppAppBarTitle('Chat With Us'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: ListView.separated(
          itemCount: _channels.length,
          separatorBuilder: (_, __) => const Gap.v(AppSpacing.md),
          itemBuilder: (context, index) {
            final channel = _channels[index];
            return LiveChatChannelTile(channel: channel);
          },
        ),
      ),
    );
  }
}

const List<Map<String, dynamic>> _mockChannelJson = [
  {
    'id': '25cf9ffa-8b4b-4e09-9ff1-34b5f7db00e4',
    'channel': 'live_chat',
    'display_name': 'Live Chat with Agent',
    'is_enabled': true,
    'headline': 'Chat with us here live',
    'availability_window': 'Mon-Fri • 8am-6pm',
    'average_response_time': '15 minutes',
    'contact_url': 'http://167.71.92.9/admin/',
    'whatsapp_phone_number': '',
    'whatsapp_deeplink': '',
    'entrypoint_url': 'http://167.71.92.9/admin/',
    'metadata': {},
    'updated_at': '2025-11-21T17:25:00.897007+01:00',
  },
  {
    'id': '806c5418-1e06-4ee0-9d5b-ab540d573764',
    'channel': 'whatsapp',
    'display_name': 'WhatsApp Support 1',
    'is_enabled': true,
    'headline': 'Chat with our staff 24/7 online',
    'availability_window': 'Mon-Sat • 8am-6pm',
    'average_response_time': '10 minutes',
    'contact_url': '',
    'whatsapp_phone_number': '07075179929',
    'whatsapp_deeplink': '',
    'entrypoint_url': 'https://wa.me/07075179929',
    'metadata': {},
    'updated_at': '2025-11-21T17:20:44.162169+01:00',
  },
];
