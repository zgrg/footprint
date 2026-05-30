import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../../core/formula.dart';
import '../../core/l10n.dart';
import '../../shared/providers/providers.dart';

class ResultDisplay extends ConsumerWidget {
  const ResultDisplay({super.key});

  Color _bracketColor(ResultBracket bracket) {
    switch (bracket) {
      case ResultBracket.green: return colorGreen;
      case ResultBracket.amber: return colorAmber;
      case ResultBracket.red:   return colorRed;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final co2    = ref.watch(co2ResultProvider);
    final color  = _bracketColor(resultBracket(co2));
    final s      = AppStrings.of(context);

    final comparison = co2 < target2050
        ? s.belowTarget
        : s.aboveTarget((co2 / target2050).toStringAsFixed(1));

    return Column(
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween<double>(end: co2),
          duration: resultAnimationDuration,
          builder: (context, value, _) {
            final animColor = _bracketColor(resultBracket(value));
            final accuracy  = value * accuracyFraction;
            return Column(
              children: [
                Text(
                  value.toStringAsFixed(1),
                  style: Theme.of(context).textTheme.displayLarge
                      ?.copyWith(color: animColor),
                ),
                Text(
                  s.tCO2Year,
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: animColor, letterSpacing: 1.0),
                ),
                const SizedBox(height: 6),
                Text(
                  '± ${accuracy.toStringAsFixed(1)} t  (${s.accuracyRange})',
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: colorMuted),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 8),
        Text(
          comparison,
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: color),
        ),
      ],
    );
  }
}
