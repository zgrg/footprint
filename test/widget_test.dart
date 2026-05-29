import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:footprint/app/app.dart';
import 'package:footprint/features/about/about_screen.dart';
import 'package:footprint/features/calculator/calculator_screen.dart';

void main() {
  group('CalculatorScreen', () {
    testWidgets('renders without error', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: CalculatorScreen()),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('shows spend and awareness sliders', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: CalculatorScreen()),
        ),
      );
      expect(find.text('Monthly spend'), findsOneWidget);
      expect(find.text('CO₂ awareness'), findsOneWidget);
    });

    testWidgets('shows result unit label', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: CalculatorScreen()),
        ),
      );
      expect(find.text('t CO₂e / year'), findsOneWidget);
    });

    testWidgets('shows benchmark compare section', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: CalculatorScreen()),
        ),
      );
      expect(find.text('Compare'), findsOneWidget);
    });
  });

  group('AboutScreen', () {
    testWidgets('renders without error', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: AboutScreen()),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('shows privacy statement', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: AboutScreen()),
        ),
      );
      expect(find.textContaining('No internet connection'), findsOneWidget);
    });

    testWidgets('shows references section', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: AboutScreen()),
        ),
      );
      expect(find.text('References'), findsOneWidget);
    });
  });

  group('FootprintApp', () {
    testWidgets('app boots and shows calculator screen', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: FootprintApp()));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.text('Monthly spend'), findsOneWidget);
    });
  });
}
