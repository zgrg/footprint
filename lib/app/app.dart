import 'package:flutter/material.dart';
import 'router.dart';
import 'theme.dart';

class FootprintApp extends StatelessWidget {
  const FootprintApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Footprint',
      theme: buildAppTheme(),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
