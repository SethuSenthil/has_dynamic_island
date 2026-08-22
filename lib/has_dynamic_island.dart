library has_dynamic_island;

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class HasDynamicIsland {
  /// Returns [bool] true if device has Apple Dynamic Island.
  Future<bool> hasDynamicIsland() async {
    final Map<String, List<int>> supportedMachineCodes = {
      // iPhone 14 Pro / Pro Max
      'iPhone15': [2, 3],

      // All iPhone 15 models
      'iPhone16': [-1],

      // iPhone 16 / 16 Plus / 16 Pro / 16 Pro Max
      'iPhone17': [1, 2, 3, 4],

      // iPhone 17 / 17 Air / 17 Pro / 17 Pro Max
      // iPhone 17e is intentionally excluded.
      'iPhone18': [1, 2, 3, 4],
    };

    if (Platform.isIOS) {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      final String machineCode = iosDeviceInfo.utsname.machine;

      final List<String> machineParts = machineCode.split(',');
      final String deviceSeries = machineParts[0];
      final int deviceModel =
          machineParts.length > 1 ? int.tryParse(machineParts[1]) ?? -1 : -1;

      if (supportedMachineCodes.containsKey(deviceSeries)) {
        // If the first element is -1, all models in the series are supported.
        if (supportedMachineCodes[deviceSeries]!.first == -1) {
          return true;
        }

        return supportedMachineCodes[deviceSeries]?.contains(deviceModel) ??
            false;
      }
    }

    return false;
  }
}
