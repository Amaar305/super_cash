import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:super_cash/features/live_chat/domain/entities/live_chat_channel.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveChatChannelTile extends StatelessWidget {
  const LiveChatChannelTile({super.key, required this.channel});

  final LiveChatChannel channel;

  Color _badgeColor(BuildContext context) {
    if (!channel.isEnabled) return Colors.grey;
    switch (channel.channel) {
      case 'whatsapp':
        return const Color(0xFF25D366);
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  IconData _channelIcon() {
    switch (channel.channel) {
      case 'whatsapp':
        return Iconsax.activity;
      default:
        return Icons.chat_bubble_outline_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _badgeColor(context);
    final tileColor = channel.isEnabled
        ? Theme.of(context).colorScheme.surface
        : Theme.of(context).colorScheme.surfaceContainerHighest;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: channel.isEnabled ? 1 : 0.65,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: tileColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(color: statusColor.withValues(alpha: 0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(_channelIcon(), color: statusColor),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          channel.displayName,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          channel.headline,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                  _StatusPill(isEnabled: channel.isEnabled),
                ],
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: [
                  _InfoChip(
                    icon: Icons.access_time_rounded,
                    label: channel.availabilityWindow,
                  ),
                  _InfoChip(
                    icon: Icons.flash_on_rounded,
                    label: 'Avg. response: ${channel.averageResponseTime}',
                  ),
                  _InfoChip(
                    icon: Icons.update_rounded,
                    label:
                        'Updated ${TimeOfDay.fromDateTime(channel.updatedAt).format(context)}',
                  ),
                ],
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: channel.isEnabled ? () => _launch(context) : null,
                  icon: const Icon(Icons.open_in_new_rounded),
                  label: Text(channel.isEnabled ? 'Open channel' : 'Disabled'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: channel.isEnabled ? statusColor : null,
                    foregroundColor: channel.isEnabled
                        ? Colors.white
                        : Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launch(BuildContext context) async {
    final uri = channel.preferredUri;
    if (uri == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No contact link available for now.')),
      );
      return;
    }

    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to open channel right now.')),
      );
    }
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.isEnabled});

  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final color = isEnabled ? Colors.green : Colors.redAccent;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isEnabled ? Icons.check_circle : Icons.remove_circle,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 6),
          Text(
            isEnabled ? 'Active' : 'Inactive',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.grey[700]),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey[800]),
          ),
        ],
      ),
    );
  }
}
