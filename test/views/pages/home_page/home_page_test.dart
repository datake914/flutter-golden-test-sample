import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sample_golden_test/main.dart';
import 'package:sample_golden_test/views/pages/home_page/home_page.dart';

void main() {
  testWidgets('Pure Golden Test', (tester) async {
    // Load fonts.
    // https://api.flutter.dev/flutter/flutter_test/matchesGoldenFile.html#including-fonts
    final font = rootBundle.load('fonts/Roboto/Roboto-Medium.ttf');
    final fontLoader = FontLoader('Roboto')..addFont(font);
    await fontLoader.load();

    // Render a widget.
    await tester.pumpWidget(const MyApp());

    // Assert that there is only one Widget with the text 0.
    expect(find.text('0'), findsOneWidget);

    // Assert that a widget matches the golden image file.
    await expectLater(find.byType(HomePage), matchesGoldenFile('goldens/homepage.png'));
  });
}
