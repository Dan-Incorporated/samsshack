import 'package:flutter/material.dart';
import 'package:samsshack/widgets/app_bar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() async {
    await dotenv.load(
        fileName: "assets/env/.env"); // load environment variables from .env
  });

  // ====================================================================== /
  // APP BAR BASE ========================================================= /
  // ====================================================================== /


  group('WIDGET TESTS - AppBarBase tests', () {
    testWidgets('AppBarBase works with default parameters', (WidgetTester tester) async {
      // create widget
      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: AppBarBase())));

      // search for elements
      expect(find.text("Sams Shack"), findsOneWidget);
    });

    testWidgets('AppBarBase works with short title', (WidgetTester tester) async {
      // create widget
      const String title = '.';
      await tester.pumpWidget(const MaterialApp(
          home: Scaffold(
              body: AppBarBase(
        title: title,
      ))));

      // search for elements
      expect(find.text(title), findsOneWidget);
    });

    testWidgets('AppBarBase works with long title', (WidgetTester tester) async {
      // create widget
      const String title = 'this is going to be a really long title that definitely overflows';
      await tester.pumpWidget(const MaterialApp(
          home: Scaffold(
              body: AppBarBase(
        title: title,
      ))));

      // search for elements
      expect(find.textContaining(title.substring(0, 10)), findsOneWidget);
    });

    testWidgets('AppBarBase works with all params', (WidgetTester tester) async {
      // create widget
      const String title = 'normal title';
      const Color colorBackground = Colors.red;
      const Color colorTitle = Colors.green;
      await tester.pumpWidget(const MaterialApp(
          home: Scaffold(
              body: AppBarBase(
        title: title,
        colorBackground: colorBackground,
        colorTitle: colorTitle,
      ))));

      // search for elements
      expect(find.textContaining(title), findsOneWidget);
    });
  });
}
