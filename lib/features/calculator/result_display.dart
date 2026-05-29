import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../../core/formula.dart';
import '../../shared/providers/providers.dart';

class ResultDisplay extends ConsumerWidget {
  const ResultDisplay({super.key});

  Color _bracketColor(ResultBracket bracket) {
    switch (bracket) {
      case ResultBracket.green:
        return colorGreen;
      case ResultBracket.amber:
        return colorAmber;
      case ResultBracket.red:
        return colorRed;
    }
  }

  String _comparison(double co2) {
    if (co2 < target2050) return 'Below 2050 target 🌱';
    final times = (co2 / target2050).toStringAsFixed(1);
    return '$times× the 2050 target (${target2050}t)';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final co2 = ref.watch(co2ResultProvider);
    final bracket = resultBracket(co2);
    final color = _bracketColor(bracket);

    return Column(
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween<double>(end: co2),
          duration: resultAnimationDuration,
          builder: (context, value, _) {
            final animBracket = resultBracket(value);
            final animColor = _bracketColor(animBracket);
            return Text(
              '${value.toStringAsFixed(1)} t CO₂e/year',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: animColor,
                  ),
            );
          },
        ),
        const SizedBox(height: 8),
        Text(
          _comparison(co2),
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: color),
        ),
      ],
    );
  }
}
