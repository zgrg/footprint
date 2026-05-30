import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../../shared/providers/providers.dart';

class LifestyleSlider extends ConsumerWidget {
  const LifestyleSlider({super.key});

  // Awareness is the inverse of the CO2 factor:
  // high awareness → low factor → less CO2
  double _factorToAwareness(double factor) =>
      lifestyleMax + lifestyleMin - factor;

  double _awarenessToFactor(double awareness) =>
      (lifestyleMax + lifestyleMin - awareness)
          .clamp(lifestyleMin, lifestyleMax);

  String _label(double awareness) {
    if (awareness >= 1.5) return 'Very high';
    if (awareness >= 1.2) return 'High';
    if (awareness >= 0.9) return 'Average';
    if (awareness >= 0.6) return 'Low';
    return 'Very low';
  }

  // Own scale: High/Very high → green, Average → amber, Low/Very low → red
  Color _awarenessColor(double awareness) {
    if (awareness >= 1.2) return colorGreen;
    if (awareness >= 0.9) return colorAmber;
    return colorRed;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final factor = ref.watch(lifestyleFactorProvider);
    final awareness = _factorToAwareness(factor);
    final color = _awarenessColor(awareness);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('CO₂ awareness',
                style: Theme.of(context).textTheme.bodyMedium),
            Text(_label(awareness),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Less meat · less flying · public transport · less consumption',
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: colorMuted),
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: color,
            thumbColor: color,
            overlayColor: color.withAlpha(40),
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
            Text('Very low', style: Theme.of(context).textTheme.bodySmall),
            Text('Very high', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ],
    );
  }
}
