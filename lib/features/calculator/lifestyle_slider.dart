import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../../core/l10n.dart';
import '../../shared/providers/providers.dart';

class LifestyleSlider extends ConsumerWidget {
  const LifestyleSlider({super.key});

  double _factorToAwareness(double factor) =>
      lifestyleMax + lifestyleMin - factor;

  double _awarenessToFactor(double awareness) =>
      (lifestyleMax + lifestyleMin - awareness)
          .clamp(lifestyleMin, lifestyleMax);

  String _label(double awareness, AppStrings s) {
    if (awareness >= 1.5) return s.veryHigh;
    if (awareness >= 1.2) return s.high;
    if (awareness >= 0.9) return s.average;
    if (awareness >= 0.6) return s.low;
    return s.veryLow;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final factor    = ref.watch(lifestyleFactorProvider);
    final awareness = _factorToAwareness(factor);
    final s         = AppStrings.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(s.co2Awareness,
                style: Theme.of(context).textTheme.bodyMedium),
            Text(_label(awareness, s),
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(color: colorAmber, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          s.awarenessHint,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: colorMuted),
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: colorAmber,
            thumbColor: colorAmber,
            overlayColor: colorAmber.withAlpha(40),
          ),
          child: Slider(
            value: awareness,
            min: lifestyleMin,
            max: lifestyleMax,
            divisions: ((lifestyleMax - lifestyleMin) / lifestyleStep).round(),
            onChanged: (v) {
              final newFactor = _awarenessToFactor(
                  double.parse(v.toStringAsFixed(1)));
              ref.read(lifestyleFactorProvider.notifier).state = newFactor;
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(s.veryLow,
                style: Theme.of(context).textTheme.bodySmall),
            Text(s.veryHigh,
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ],
    );
  }
}
