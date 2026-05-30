import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';
import 'core/l10n.dart';
import 'shared/providers/providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Pick the best supported locale matching the OS language, default to English.
  final osLocale = WidgetsBinding.instance.platformDispatcher.locale;
  final initial = supportedLocales.firstWhere(
    (l) => l.languageCode == osLocale.languageCode,
    orElse: () => const Locale('en'),
  );

  runApp(
    ProviderScope(
      overrides: [
        localeProvider.overrideWith((ref) => initial),
      ],
      child: const FootprintApp(),
    ),
  );
}
