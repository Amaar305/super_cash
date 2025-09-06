import 'dart:async';

import 'package:super_cash/core/cooldown/cooldown_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cooldown_state.dart';

class CooldownCubit extends Cubit<CooldownState> {
  final CooldownRepository _cooldownRepository;
  final Map<String, Timer> _timers = {};
  final Map<String, Duration> _remaining = {};
  CooldownCubit({required CooldownRepository cooldownRepository})
    : _cooldownRepository = cooldownRepository,
      super(CooldownState({}));
  void startCooldown(String actionKey, Duration duration) async {
    await _cooldownRepository.setCooldown(actionKey);

    _timers[actionKey]?.cancel();

    _remaining[actionKey] = duration;
    emit(CooldownState({..._remaining}));

    _timers[actionKey] = Timer.periodic(Duration(seconds: 1), (timer) {
      final current = _remaining[actionKey]!;
      final updated = current - Duration(seconds: 1);

      if (updated.inSeconds <= 0) {
        timer.cancel();
        _remaining.remove(actionKey);
      } else {
        _remaining[actionKey] = updated;
      }

      emit(CooldownState({..._remaining}));
    });
  }

  void checkCooldown(String actionKey, Duration duration) async {
    final secondsLeft = await _cooldownRepository.getRemainingCooldownInSeconds(
      actionKey,
      duration,
    );
    if (secondsLeft != null && secondsLeft > 0) {
      startCooldown(actionKey, Duration(seconds: secondsLeft));
    }
  }

  Duration? getRemaining(String actionKey) {
    return _remaining[actionKey];
  }

  bool isCoolingDown(String actionKey) {
    return _remaining.containsKey(actionKey);
  }

  @override
  Future<void> close() {
    for (var timer in _timers.values) {
      timer.cancel();
    }
    return super.close();
  }
}
