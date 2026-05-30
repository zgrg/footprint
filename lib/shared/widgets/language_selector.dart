import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../../core/l10n.dart';
import '../providers/providers.dart';

class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(localeProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: supportedLocales.map((locale) {
        final isSelected = locale.languageCode == current.languageCode;
        final (flag, code) = localeFlags[locale.languageCode]!;

        return GestureDetector(
          onTap: () =>
              ref.read(localeProvider.notifier).state = locale,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: isSelected ? colorElevated : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? colorMuted : Colors.transparent,
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  flag,
                  style: TextStyle(
                    fontSize: isSelected ? 22 : 18,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  code,
                  style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 9,
                    color: isSelected ? colorText : colorMuted,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
