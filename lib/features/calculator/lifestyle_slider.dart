import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../../shared/providers/providers.dart';

class LifestyleSlider extends ConsumerWidget {
  const LifestyleSlider({super.key});

  String _label(double factor) {
    if (factor <= 0.5) return 'Minimal';
    if (factor <= 0.8) return 'Low';
    if (factor <= 1.1) return 'Average';
    if (factor <= 1.4) return 'High';
    return 'Very high';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final factor = ref.watch(lifestyleFactorProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Lifestyle intensity',
                style: Theme.of(context).textTheme.bodyMedium),
            Text(_label(factor),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: colorText, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        Slider(
          value: factor,
          min: lifestyleMin,
          max: lifestyleMax,
          divisions: ((lifestyleMax - lifestyleMin) / lifestyleStep).round(),
          onChanged: (v) =>
              ref.read(lifestyleFactorProvider.notifier).state =
                  double.parse(v.toStringAsFixed(1)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Minimal',
                style: Theme.of(context).textTheme.bodySmall),
            Text('Very high',
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ],
    );
  }
}
