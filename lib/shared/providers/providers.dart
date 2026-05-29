import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/formula.dart';

final monthlySpendProvider = StateProvider<double>((ref) => 2000.0);

final lifestyleFactorProvider = StateProvider<double>((ref) => 1.0);

final co2ResultProvider = Provider<double>((ref) {
  final spend = ref.watch(monthlySpendProvider);
  final factor = ref.watch(lifestyleFactorProvider);
  return co2FromSpend(spend, factor);
});
