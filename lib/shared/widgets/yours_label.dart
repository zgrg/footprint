import 'package:flutter/material.dart';
import '../../core/constants.dart';

class YoursLabel extends StatelessWidget {
  const YoursLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Yours',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: colorMuted,
            fontFamily: 'DM Sans',
            letterSpacing: 1.2,
          ),
    );
  }
}
