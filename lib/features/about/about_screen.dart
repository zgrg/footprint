import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants.dart';
import '../../core/l10n.dart';
import '../../shared/widgets/yours_label.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _openDoi(String doi) async {
    final uri = Uri.parse('https://doi.org/$doi');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final body = Theme.of(context).textTheme.bodySmall
        ?.copyWith(color: colorMuted, height: 1.7);
    final heading = Theme.of(context).textTheme.bodyMedium
        ?.copyWith(fontWeight: FontWeight.bold, color: colorText);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBackground,
        elevation: 0,
        title: const YoursLabel(),
        iconTheme: const IconThemeData(color: colorMuted),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(s.appTitle,
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 22)),
            const SizedBox(height: 6),
            Text(s.version, style: body),
            const SizedBox(height: 28),

            Text(s.privacyHeading, style: heading),
            const SizedBox(height: 6),
            Text(s.privacyText, style: body),
            const SizedBox(height: 24),

            Text(s.formulaHeading, style: heading),
            const SizedBox(height: 6),
            Text(s.formulaText, style: body),
            const SizedBox(height: 24),

            Text(s.accuracyHeading, style: heading),
            const SizedBox(height: 6),
            Text(s.accuracyText, style: body),
            const SizedBox(height: 24),

            Text(s.referencesHeading, style: heading),
            const SizedBox(height: 8),
            _DoiLink(
              citation: 'Ivanova & Wood (2020). Global Sustainability 3, e18.',
              doi: '10.1017/sus.2020.12',
              onTap: _openDoi,
            ),
            _DoiLink(
              citation: 'Ivanova et al. (2016). J. Industrial Ecology 20(3).',
              doi: '10.1111/jiec.12371',
              onTap: _openDoi,
            ),
            _DoiLink(
              citation: 'Ivanova et al. (2020). Environ. Research Letters 15, 093001.',
              doi: '10.1088/1748-9326/ab8589',
              onTap: _openDoi,
            ),
            _DoiLink(
              citation: 'Wynes & Nicholas (2017). Environ. Research Letters 12, 074024.',
              doi: '10.1088/1748-9326/aa7541',
              onTap: _openDoi,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _DoiLink extends StatelessWidget {
  final String citation;
  final String doi;
  final void Function(String doi) onTap;

  const _DoiLink({
    required this.citation,
    required this.doi,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () => onTap(doi),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(citation,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: colorMuted, height: 1.5)),
            Text('doi:$doi',
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: colorGreen, height: 1.4)),
          ],
        ),
      ),
    );
  }
}
