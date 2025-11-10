import 'package:app_client/app_client.dart';
import 'package:shared/shared.dart';

import 'device_info.dart';

class DeviceRegistrar {
  DeviceRegistrar({
    required AuthClient authClient,
    required Fingerprint fingerprint,
  })  : _authClient = authClient,
        _fingerprint = fingerprint;

  final AuthClient _authClient;
  final Fingerprint _fingerprint;

  Future<void> register({bool withAuth = false}) async {
    try {
      final payload = await _fingerprint.collect();
      await _authClient.request(
        method: 'POST',
        path: 'core/devices/register/',
        body: payload,
        withToken: withAuth,
      );
    } catch (error, stackTrace) {
      logE('Device registration failed: $error', stackTrace: stackTrace);
    }
  }
}
