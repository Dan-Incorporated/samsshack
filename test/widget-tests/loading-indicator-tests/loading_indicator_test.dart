import 'package:flutter/material.dart';
import 'package:samsshack/widgets/loading_indicator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() async {
    await dotenv.load(
        fileName: "assets/env/.env"); // load environment variables from .env
  });

  // ====================================================================== /
  // LOADING INDICATOR ==================================================== /
  // ====================================================================== /

  group('WIDGET TESTS - LoadingIndicator tests', () {
    testWidgets('LoadingIndicator works with default parameters', (WidgetTester tester) async {
      // create widget
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: LoadingIndicator())));

      // search for elements
      expect(find.byType(LoadingIndicator), findsOneWidget);
    });
  });
}
