import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef FingerPrintJSON = Map<String, dynamic>;

class Fingerprint {
  Fingerprint({required SharedPreferences storage}) : _storage = storage;
  final SharedPreferences _storage;
  final _device = DeviceInfoPlugin();

  static const _kInstallId = 'install_id_v1';
  static const _pepper =
      'fp_v1_static_pepper_change_in_build'; // rotate per app release if needed

  Future<String> _getInstallId() async {
    var id = _storage.getString(_kInstallId);
    if (id == null) {
      id = _randomUuid();
      await _storage.setString(_kInstallId, id);
    }
    return id;
  }

  String _randomUuid() {
    // simple UUID v4
    final bytes = List<int>.generate(
      16,
      (_) => (DateTime.now().microsecondsSinceEpoch) & 0xff,
    );
    return base64Url.encode(bytes);
  }

  Future<FingerPrintJSON> collect() async {
    final installId = await _getInstallId();
    final pkg = await PackageInfo.fromPlatform();

    String platform = 'unknown';
    String vendorId = 'na';
    String model = 'na';
    String brand = 'na';
    String osVersion = 'na';
    bool isEmulator = false;

    if (await _isAndroid()) {
      final a = await _device.androidInfo;
      platform = 'android';
      vendorId = a.id; // ANDROID_ID
      model = a.model;
      brand = a.brand;
      osVersion = a.version.release;
      isEmulator = !(a.isPhysicalDevice);
    } else {
      final i = await _device.iosInfo;
      platform = 'ios';
      vendorId = i.identifierForVendor ?? 'na';
      model = i.utsname.machine;
      brand = 'apple';
      osVersion = i.systemVersion;
      isEmulator = !(i.isPhysicalDevice);
    }

    // canonical string
    final raw = [
      'platform=$platform',
      'vendorId=$vendorId',
      'model=$model',
      'brand=$brand',
      'os=$osVersion',
      'install=$installId',
      'app=${pkg.version}+${pkg.buildNumber}',
      'pepper=$_pepper',
    ].join('|');

    final hash = sha256.convert(utf8.encode(raw)).toString();

    return {
      'device_hash': hash,
      'attrs': {
        'platform': platform,
        'model': model,
        'brand': brand,
        'os': osVersion,
        'install_id': installId.substring(
          0,
          8,
        ), // truncated for debugging if you want
        'is_emulator': isEmulator,
        'app_version': '${pkg.version}+${pkg.buildNumber}',
      },
    };
  }

  Future<bool> _isAndroid() async {
    try {
      await _device.androidInfo;
      return true;
    } catch (_) {
      return false;
    }
  }
}
