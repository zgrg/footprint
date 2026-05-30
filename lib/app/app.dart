import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/l10n.dart';
import '../shared/providers/providers.dart';
import 'router.dart';
import 'theme.dart';

class FootprintApp extends ConsumerWidget {
  const FootprintApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'Footprint',
      theme: buildAppTheme(),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: supportedLocales,
      localizationsDelegates: const [
        AppStringsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
