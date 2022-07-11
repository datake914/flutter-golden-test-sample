import 'package:flutter/widgets.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

class CustomDeviceBuilder extends DeviceBuilder {
  CustomDeviceBuilder._() : super();

  factory CustomDeviceBuilder() {
    return CustomDeviceBuilder._();
  }

  static const devices = [
    Device.tabletLandscape,
    Device(
      name: 'iPhone SE2',
      size: Size(375, 667),
      devicePixelRatio: 2,
    )
  ];

  void addScenarioBuilder(DeviceScenario Function() scenarioBuilder) {
    for (final device in devices) {
      overrideDevicesForAllScenarios(devices: [device]);
      final scenario = scenarioBuilder();
      super.addScenario(
        widget: scenario.widget,
        name: scenario.name,
        onCreate: scenario.onCreate,
      );
    }
    overrideDevicesForAllScenarios(devices: devices);
  }
}

class DeviceScenario {
  DeviceScenario({
    required this.widget,
    this.name,
    this.onCreate,
  });
  final Widget widget;
  final String? name;
  final OnScenarioCreate? onCreate;
}
