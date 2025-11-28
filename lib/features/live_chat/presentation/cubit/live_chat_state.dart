part of 'live_chat_cubit.dart';

enum LiveChatStatus {
  initial,
  loading,
  success,
  failure;

  bool get isError => this == LiveChatStatus.failure;
  bool get isLoading => this == LiveChatStatus.loading;
}

class LiveChatState extends Equatable {
  final LiveChatStatus status;
  final List<LiveChatChannel> channels;

  const LiveChatState({required this.status, required this.channels});

  const LiveChatState.initial()
    : this(channels: const [], status: LiveChatStatus.failure);

  LiveChatState copyWith({
    LiveChatStatus? status,
    List<LiveChatChannel>? channels,
  }) {
    return LiveChatState(
      status: status ?? this.status,
      channels: channels ?? this.channels,
    );
  }

  factory LiveChatState.fromJson(Map<String, dynamic> json) {
    return LiveChatState(
      status: LiveChatStatus.values.firstWhere(
        (value) => value.name == json['status'],
        orElse: () => LiveChatStatus.initial,
      ),
      channels: (json['channels'] as List<dynamic>? ?? [])
          .map((item) => LiveChatChannel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status.name,
      'channels': channels.map((channel) => channel.toJson()).toList(),
    };
  }

  @override
  List<Object> get props => [status, channels];
}
