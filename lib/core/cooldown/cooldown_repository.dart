import 'package:shared_preferences/shared_preferences.dart';

abstract interface class CooldownRepository {
  Future<void> setCooldown(String actionKey);
  Future<int?> getRemainingCooldownInSeconds(
    String actionKey,
    Duration duration,
  );

  Future<void> clearCooldown(String actionKey);
}

class CooldownRepositoryImpl implements CooldownRepository {
  final SharedPreferences prefs;

  CooldownRepositoryImpl({required this.prefs});
  @override
  Future<void> setCooldown(String actionKey) async {
    prefs.setInt('cooldown_$actionKey', DateTime.now().millisecondsSinceEpoch);
  }

  @override
  Future<int?> getRemainingCooldownInSeconds(
    String actionKey,
    Duration duration,
  ) async {
    final millis = prefs.getInt('cooldown_$actionKey');
    if (millis == null) return null;

    final lastTime = DateTime.fromMillisecondsSinceEpoch(millis);
    final now = DateTime.now();
    final diff = now.difference(lastTime).inSeconds;

    if (diff >= duration.inSeconds) return null;

    return duration.inSeconds - diff;
  }

  @override
  Future<void> clearCooldown(String actionKey) async {
    prefs.remove('cooldown_$actionKey');
  }
}
