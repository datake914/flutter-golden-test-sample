import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:sample_golden_test/views/pages/home_page/home_page.dart';

void main() {
  testGoldens('Golden Test with Golden Toolkit', (tester) async {
    // Define a test builder.
    final builder = DeviceBuilder()
      // Define the device setting.
      ..overrideDevicesForAllScenarios(devices: [
        Device.tabletLandscape,
        const Device(
          name: 'iPhone SE2',
          size: Size(375, 667),
          devicePixelRatio: 2,
        )
      ])
      // Add the test scenarios.
      ..addScenario(
        name: 'the initial value is not specified',
        widget: const HomePage(title: 'Flutter Demo Home Page'),
        onCreate: (key) async {
          await tester.pumpAndSettle();
          expect(find.descendant(of: find.byKey(key), matching: find.text('0')), findsOneWidget);
        },
      )
      ..addScenario(
        name: 'the initial value is specified',
        widget: const HomePage(title: 'Flutter Demo Home Page', count: 10),
        onCreate: (key) async {
          await tester.pumpAndSettle();
          expect(find.descendant(of: find.byKey(key), matching: find.text('10')), findsOneWidget);
        },
      );
    // Render a widget.
    await tester.pumpDeviceBuilder(builder);
    // Assert that a widget matches the golden image file.
    await screenMatchesGolden(tester, 'homepage');
  });
}
