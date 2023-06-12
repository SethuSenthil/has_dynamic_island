# has_dynamic_island

A Flutter package to detect the presence of Apple's Dynamic Island on iOS devices.

## Features

- Detects whether a device has Apple's Dynamic Island or not
- Checks using the device model as it is the most reliable way
  - Why did I make this a package instead of a simple gist: Its modular, easy to update across all my projects when the new Apple devices come out

## Getting Started

To use this package, include `has_dynamic_island` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  has_dynamic_island: ^1.0.0
```

## Usage

Import the package into your Dart file:

```dart
import 'package:has_dynamic_island/has_dynamic_island.dart';
```

Then, you can check if the device has Apple's Dynamic Island using the `hasDynamicIsland()` method:
If it is a non iPadOS or iOS device (AKA Android, Windows etc) it will return false

```dart
HasDynamicIsland dynamicIsland = HasDynamicIsland();
bool hasDynamicIsland = await dynamicIsland.hasDynamicIsland();
print('Device has Dynamic Island: $hasDynamicIsland');
```

## Additional Information

For more information, refer to the [documentation](https://pub.dev/packages/has_dynamic_island).

To contribute to this package, visit the [GitHub repository](https://github.com/sethusenthil/has_dynamic_island).

If you encounter any issues or have suggestions, please file them on the [issue tracker](https://github.com/sethusenthil/has_dynamic_island/issues).

## License

This package is released under the [MIT License](https://opensource.org/licenses/MIT).