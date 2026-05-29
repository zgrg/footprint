import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../../shared/providers/providers.dart';

class BenchmarkBar extends ConsumerWidget {
  const BenchmarkBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final co2 = ref.watch(co2ResultProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Compare',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: colorMuted)),
        const SizedBox(height: 12),
        _BenchmarkRow(label: '2050 target', value: target2050, userCo2: co2),
        _BenchmarkRow(label: 'Africa avg', value: africaAvg, userCo2: co2),
        _BenchmarkRow(label: 'S. America avg', value: southAmericaAvg, userCo2: co2),
        _BenchmarkRow(label: 'Asia avg', value: asiaAvg, userCo2: co2),
        _BenchmarkRow(label: 'World avg', value: worldAvg, userCo2: co2),
        _BenchmarkRow(label: 'EU avg', value: euAvg, userCo2: co2),
        _BenchmarkRow(label: 'Oceania avg', value: oceaniaAvg, userCo2: co2),
        _BenchmarkRow(label: 'N. America avg', value: northAmericaAvg, userCo2: co2),
      ],
    );
  }
}

class _BenchmarkRow extends StatelessWidget {
  final String label;
  final double value;
  final double userCo2;

  const _BenchmarkRow({
    required this.label,
    required this.value,
    required this.userCo2,
  });

  @override
  Widget build(BuildContext context) {
    final isBelow = userCo2 <= value;
    final barMax = [northAmericaAvg * 1.2, userCo2 * 1.1].reduce((a, b) => a > b ? a : b);
    final fraction = (value / barMax).clamp(0.0, 1.0);
    final userFraction = (userCo2 / barMax).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: Theme.of(context).textTheme.bodySmall),
              Text('${value.toStringAsFixed(1)} t',
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: 4),
          LayoutBuilder(builder: (context, constraints) {
            final width = constraints.maxWidth;
            return Stack(
              children: [
                Container(
                  height: 6,
                  width: width,
                  decoration: BoxDecoration(
                    color: colorElevated,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                Container(
                  height: 6,
                  width: width * fraction,
                  decoration: BoxDecoration(
                    color: colorMuted,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                Positioned(
                  left: (width * userFraction - 2).clamp(0.0, width - 4),
                  child: Container(
                    width: 4,
                    height: 6,
                    decoration: BoxDecoration(
                      color: isBelow ? colorGreen : colorRed,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
