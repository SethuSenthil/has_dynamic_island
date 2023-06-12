library has_dynamic_island;

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class HasDynamicIsland {
  /// Returns [bool] true if device has apple dynamic island.
  Future<bool> hasDynamicIsland() async {
    Map<String, List<int>> supportedMachineCodes = {
      'iPhone15': [2, 3], //iPhone 14 Series, Pro and Pro Max
      'iPhone16': [2, 3] //iPhone 15 Series, Pro and Pro Max
    };

    if (Platform.isIOS) {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      final String mechineCode = iosDeviceInfo.utsname.machine;

      final String deviceSeries = mechineCode.split(',')[0];
      final int deviceModel = int.tryParse(mechineCode.split(',')[1]) ?? -1;

      if (supportedMachineCodes.containsKey(deviceSeries)) {
        return supportedMachineCodes[deviceSeries]?.contains(deviceModel) ??
            false;
      }
    }
    return false;
  }
}
