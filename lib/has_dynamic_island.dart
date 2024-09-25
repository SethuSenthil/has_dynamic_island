library has_dynamic_island;

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class HasDynamicIsland {
  /// Returns [bool] true if device has apple dynamic island.
  Future<bool> hasDynamicIsland() async {
    Map<String, List<int>> supportedMachineCodes = {
      'iPhone15': [2, 3], //iPhone 14 Series, Pro and Pro Max
      'iPhone16': [-1], //All iPhone 15 Series
      'iPhone17': [
        1,
        2,
        3,
        4
      ] //iPhone 16 Pro, iPhone 16 Pro Max, iPhone 16, iPhone 16 Plus (the iPhone Air and or iPhone SE may not have dynamic island, so we are explicitly checking for Pro, Pro Max, Plus and Regular)
    };

    if (Platform.isIOS) {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      final String mechineCode = iosDeviceInfo.utsname.machine;

      final String deviceSeries = mechineCode.split(',')[0];
      final int deviceModel = int.tryParse(mechineCode.split(',')[1]) ?? -1;

      if (supportedMachineCodes.containsKey(deviceSeries)) {
        // check if the first element of the list is -1, if it is, then all models of the series are supported
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
