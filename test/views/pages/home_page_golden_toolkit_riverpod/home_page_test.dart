import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sample_golden_test/repositories/count_repository.dart';
import 'package:sample_golden_test/views/pages/home_page_riverpod/home_page.dart';
import 'package:sample_golden_test/views/pages/home_page_riverpod/home_page_state_notifier.dart';
import 'package:sample_golden_test/views/pages/home_page_riverpod/home_page_state_notifier_provider.dart';

import '../default_device_builder.dart';
import 'home_page_test.mocks.dart';

@GenerateMocks([CountRepository])
void main() {
  testGoldens('Golden Test with Riverpod', (tester) async {
    // Define a test builder.
    final builder = CustomDeviceBuilder()
      // Add the test scenarios.
      ..addScenarioBuilder(() {
        // Define the mock.
        final mockCountRepository = MockCountRepository();
        when(mockCountRepository.get()).thenAnswer((_) async {
          return 10;
        });
        return DeviceScenario(
          name: 'the initial value is 10',
          widget: ProviderScope(
            overrides: [
              homePageStateNotifierProvider.overrideWithValue(
                // Inject the mock.
                HomePageStateNotifier(countRepo: mockCountRepository),
              ),
            ],
            child: const HomePage(title: 'Flutter Demo Home Page'),
          ),
          onCreate: (key) async {
            await tester.pumpAndSettle();
            verify(mockCountRepository.get()).called(1);
            expect(find.descendant(of: find.byKey(key), matching: find.text('10')), findsOneWidget);
          },
        );
      });
    // Render a widget.
    await tester.pumpDeviceBuilder(builder);
    // Assert that a widget matches the golden image file.
    await screenMatchesGolden(tester, 'homepage');
  });
}
