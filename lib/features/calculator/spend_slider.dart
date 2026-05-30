import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../../core/formula.dart';
import '../../shared/providers/providers.dart';

class SpendSlider extends ConsumerWidget {
  const SpendSlider({super.key});

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spend = ref.watch(monthlySpendProvider);
    final co2 = ref.watch(co2ResultProvider);
    final color = _bracketColor(resultBracket(co2));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Monthly spend',
                style: Theme.of(context).textTheme.bodyMedium),
            Text('€${spend.toStringAsFixed(0)}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: color,
            thumbColor: color,
            overlayColor: color.withAlpha(40),
          ),
          child: Slider(
            value: spend,
            min: spendMin,
            max: spendMax,
            divisions: ((spendMax - spendMin) / spendStep).round(),
            onChanged: (v) =>
                ref.read(monthlySpendProvider.notifier).state = v,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('€${spendMin.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.bodySmall),
            Text('€${spendMax.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ],
    );
  }
}
