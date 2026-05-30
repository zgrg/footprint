import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants.dart';
import '../../shared/widgets/language_selector.dart';
import '../../shared/widgets/yours_label.dart';
import 'benchmark_bar.dart';
import 'lifestyle_slider.dart';
import 'result_display.dart';
import 'spend_slider.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBackground,
        elevation: 0,
        title: const YoursLabel(),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: colorMuted),
            onPressed: () => context.push('/about'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            ResultDisplay(),
            SizedBox(height: 40),
            SpendSlider(),
            SizedBox(height: 28),
            LifestyleSlider(),
            SizedBox(height: 32),
            BenchmarkBar(),
            SizedBox(height: 40),
            LanguageSelector(),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
