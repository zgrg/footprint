import 'package:flutter_test/flutter_test.dart';
import 'package:footprint/core/formula.dart';

void main() {
  group('co2FromSpend', () {
    test('default inputs produce expected result', () {
      // €2000/mo × 12 × 1.0 × 0.0007 = 16.8
      expect(co2FromSpend(2000, 1.0), closeTo(16.8, 0.001));
    });

    test('scales linearly with spend', () {
      final base = co2FromSpend(1000, 1.0);
      expect(co2FromSpend(2000, 1.0), closeTo(base * 2, 0.001));
      expect(co2FromSpend(4000, 1.0), closeTo(base * 4, 0.001));
    });

    test('scales linearly with awareness factor', () {
      final base = co2FromSpend(2000, 1.0);
      expect(co2FromSpend(2000, 0.5), closeTo(base * 0.5, 0.001));
      expect(co2FromSpend(2000, 1.8), closeTo(base * 1.8, 0.001));
    });

    test('minimum inputs (€500, factor 0.4) produce smallest result', () {
      // €500 × 12 × 0.4 × 0.0007 = 1.68
      expect(co2FromSpend(500, 0.4), closeTo(1.68, 0.001));
    });

    test('maximum inputs (€10000, factor 1.8) produce largest result', () {
      // €10000 × 12 × 1.8 × 0.0007 = 151.2
      expect(co2FromSpend(10000, 1.8), closeTo(151.2, 0.001));
    });

    test('zero spend produces zero emissions', () {
      expect(co2FromSpend(0, 1.0), equals(0.0));
    });
  });

  group('resultBracket', () {
    test('below 4t is green', () {
      expect(resultBracket(0.0), equals(ResultBracket.green));
      expect(resultBracket(2.5), equals(ResultBracket.green));
      expect(resultBracket(3.99), equals(ResultBracket.green));
    });

    test('exactly 4t is amber', () {
      expect(resultBracket(4.0), equals(ResultBracket.amber));
    });

    test('between 4t and 8t is amber', () {
      expect(resultBracket(5.0), equals(ResultBracket.amber));
      expect(resultBracket(7.9), equals(ResultBracket.amber));
    });

    test('exactly 8t is amber', () {
      expect(resultBracket(8.0), equals(ResultBracket.amber));
    });

    test('above 8t is red', () {
      expect(resultBracket(8.01), equals(ResultBracket.red));
      expect(resultBracket(16.8), equals(ResultBracket.red));
      expect(resultBracket(100.0), equals(ResultBracket.red));
    });

    test('bracket matches default run result', () {
      final co2 = co2FromSpend(2000, 1.0); // 16.8t
      expect(resultBracket(co2), equals(ResultBracket.red));
    });

    test('bracket matches minimum run result', () {
      final co2 = co2FromSpend(500, 0.4); // 1.68t
      expect(resultBracket(co2), equals(ResultBracket.green));
    });
  });
}
