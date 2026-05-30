import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../../core/l10n.dart';
import '../../shared/providers/providers.dart';

class SpendSlider extends ConsumerWidget {
  const SpendSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spend = ref.watch(monthlySpendProvider);
    final s     = AppStrings.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(s.monthlySpend,
                style: Theme.of(context).textTheme.bodyMedium),
            Text('€${spend.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(color: colorAmber, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: colorAmber,
            thumbColor: colorAmber,
            overlayColor: colorAmber.withAlpha(40),
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
