import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:super_cash/core/usecase/use_case.dart';
import 'package:super_cash/features/live_chat/live_chat.dart';

part 'live_chat_state.dart';

class LiveChatCubit extends HydratedCubit<LiveChatState> {
  final FetchSupportsUseCase _fetchSupportsUseCase;
  LiveChatCubit({required FetchSupportsUseCase fetchSupportsUseCase})
    : _fetchSupportsUseCase = fetchSupportsUseCase,
      super(LiveChatState.initial());

  Future<void> fetchSupports() async {
    if (isClosed) return;
    if (state.channels.isNotEmpty && state.status == LiveChatStatus.success) {
      return;
    }

    emit(state.copyWith(status: LiveChatStatus.loading));

    final result = await _fetchSupportsUseCase(NoParam());

    if (isClosed) return;

    result.fold(
      (_) => emit(state.copyWith(status: LiveChatStatus.failure)),
      (channels) => emit(
        state.copyWith(status: LiveChatStatus.success, channels: channels),
      ),
    );
  }

  @override
  String get id => 'live_chat_v1';
  @override
  LiveChatState? fromJson(Map<String, dynamic> json) {
    return LiveChatState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(LiveChatState state) => state.toJson();
}
