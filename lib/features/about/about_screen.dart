import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../shared/widgets/yours_label.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBackground,
        elevation: 0,
        title: const YoursLabel(),
        iconTheme: const IconThemeData(color: colorMuted),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Footprint',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 22)),
            const SizedBox(height: 16),
            Text(
              'This app has no internet connection, stores nothing, '
              'and knows nothing about you.\nYour data is your data.',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: colorMuted, height: 1.6),
            ),
            const SizedBox(height: 32),
            Text('How it works',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              'CO₂ (t/year) = monthly spend × 12 × lifestyle factor × 0.0007\n\n'
              'Emission intensity: EU average 0.7 kg CO₂e per €1 household spend.',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: colorMuted, height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}
