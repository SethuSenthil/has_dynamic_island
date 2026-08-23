library;

import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class HasDynamicIsland {
  /// Returns [bool] true if device has Apple Dynamic Island.
  Future<bool> hasDynamicIsland() async {
    final Map<String, List<int>> supportedMachineCodes = {
      // iPhone 14 Pro (2), 14 Pro Max (3)
      // iPhone 15 (4), 15 Plus (5)
      'iPhone15': [2, 3, 4, 5],

      // iPhone 15 Pro (1), 15 Pro Max (2)
      'iPhone16': [1, 2],

      // iPhone 16 Pro (1), 16 Pro Max (2)
      // iPhone 16 (3), 16 Plus (4)
      'iPhone17': [1, 2, 3, 4],

      // iPhone 17 series (besides iPhone 17e which is "5")
      'iPhone18': [1, 2, 3, 4],
    };

    if (Platform.isIOS) {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;

      // Note: If running on a simulator, the machine code might be 'x86_64' or 'arm64'.
      // Depending on your device_info_plus version, you may want to return a fallback or
      // rely on 'model' if you strictly need simulator testing support.
      if (!iosDeviceInfo.isPhysicalDevice) {
        // Optional: Add simulator logic here if needed for debugging.
        // Otherwise, it will safely fall through to return false.
      }

      final String machineCode = iosDeviceInfo.utsname.machine;
      final List<String> machineParts = machineCode.split(',');

      if (machineParts.isEmpty) return false;

      final String deviceSeries = machineParts[0];
      final int deviceModel =
          machineParts.length > 1 ? int.tryParse(machineParts[1]) ?? -1 : -1;

      if (supportedMachineCodes.containsKey(deviceSeries)) {
        // If the first element is -1, all models in the series are supported.
        if (supportedMachineCodes[deviceSeries]!.first == -1) {
          return true;
        }
        return supportedMachineCodes[deviceSeries]!.contains(deviceModel);
      }
    }
    return false;
  }
}
