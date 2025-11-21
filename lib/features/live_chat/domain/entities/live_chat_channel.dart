class LiveChatChannel {
  LiveChatChannel({
    required this.id,
    required this.channel,
    required this.displayName,
    required this.isEnabled,
    required this.headline,
    required this.availabilityWindow,
    required this.averageResponseTime,
    required this.contactUrl,
    required this.whatsappPhoneNumber,
    required this.whatsappDeeplink,
    required this.entrypointUrl,
    required this.metadata,
    required this.updatedAt,
  });

  factory LiveChatChannel.fromJson(Map<String, dynamic> json) {
    return LiveChatChannel(
      id: json['id'] as String? ?? '',
      channel: json['channel'] as String? ?? '',
      displayName: json['display_name'] as String? ?? '',
      isEnabled: json['is_enabled'] as bool? ?? false,
      headline: json['headline'] as String? ?? '',
      availabilityWindow: json['availability_window'] as String? ?? '',
      averageResponseTime: json['average_response_time'] as String? ?? '',
      contactUrl: json['contact_url'] as String? ?? '',
      whatsappPhoneNumber: json['whatsapp_phone_number'] as String? ?? '',
      whatsappDeeplink: json['whatsapp_deeplink'] as String? ?? '',
      entrypointUrl: json['entrypoint_url'] as String? ?? '',
      metadata: (json['metadata'] as Map?)?.cast<String, dynamic>() ?? const {},
      updatedAt:
          DateTime.tryParse(json['updated_at'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'channel': channel,
      'display_name': displayName,
      'is_enabled': isEnabled,
      'headline': headline,
      'availability_window': availabilityWindow,
      'average_response_time': averageResponseTime,
      'contact_url': contactUrl,
      'whatsapp_phone_number': whatsappPhoneNumber,
      'whatsapp_deeplink': whatsappDeeplink,
      'entrypoint_url': entrypointUrl,
      'metadata': metadata,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Uri? get preferredUri {
    final link = contactUrl.isNotEmpty ? contactUrl : entrypointUrl;
    final whatsappLink = whatsappDeeplink.isNotEmpty
        ? whatsappDeeplink
        : whatsappPhoneNumber;
    final uriString = link.isNotEmpty ? link : whatsappLink;
    if (uriString.isEmpty) return null;
    return Uri.tryParse(uriString);
  }

  final String id;
  final String channel;
  final String displayName;
  final bool isEnabled;
  final String headline;
  final String availabilityWindow;
  final String averageResponseTime;
  final String contactUrl;
  final String whatsappPhoneNumber;
  final String whatsappDeeplink;
  final String entrypointUrl;
  final Map<String, dynamic> metadata;
  final DateTime updatedAt;
}
