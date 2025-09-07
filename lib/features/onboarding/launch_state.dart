import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LaunchState extends ChangeNotifier {
  LaunchState(this._prefs);

  final SharedPreferences _prefs;

  bool? _onboarded; // null = loading
  bool? get onboarded => _onboarded;

  // Show Welcome right after onboarding
  // Persist if you want to never show again after first run.
  bool _welcomePending = false;
  bool get welcomePending => _welcomePending;

  bool _isLoginPage=true;
  bool get isLoginPage=>_isLoginPage;

  Future<void> load() async {
    _onboarded = _prefs.getBool('onboarded') ?? false;
    // If you want Welcome only on first install, don’t persist welcome;
    // it will be set to true only when onboarding completes.
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    await _prefs.setBool('onboarded', true);
    _onboarded = true;
    _welcomePending = true; // <-- trigger Welcome next
    notifyListeners();
  }

  void completeWelcome(bool isLogin) {
    if (_welcomePending) {
      _welcomePending = false;
      _isLoginPage = isLogin;
      notifyListeners();
    }
  }
}
