# CLAUDE.md — Footprint App

## What this app is
A two-slider CO₂ footprint estimator. Part of the "Yours" privacy-first tool suite.
Zero permissions. Zero network calls. Zero data stored. Fully offline.

## Core formula
co2_tonnes_per_year = monthly_spend_eur × 12 × awareness_factor × 0.0007
Emission intensity source: EU average 0.7 kg CO₂e per €1 household spend.
awareness_factor range: 0.4 (very high awareness) → 1.8 (very low awareness) — inverted scale.

## Architecture rules (never break these)
1. No HTTP calls anywhere — no dio, no http package, no Firebase, no analytics
2. No SharedPreferences or any persistence — all state is in-memory only
3. No permissions — AndroidManifest and Info.plist must stay clean
4. State: flutter_riverpod only — no setState except inside StatefulWidget animations
5. Navigation: go_router only
6. Fonts: google_fonts must use bundled assets (offline), not CDN fetch

## Folder structure
lib/
  main.dart
  app/         → app.dart, router.dart, theme.dart
  core/        → constants.dart, formula.dart
  features/
    calculator/ → calculator_screen.dart, spend_slider.dart,
                  lifestyle_slider.dart, result_display.dart, benchmark_bar.dart
    about/      → about_screen.dart
  shared/
    widgets/   → yours_label.dart
    providers/ → providers.dart

## Providers (shared/providers/providers.dart)
- monthlySpendProvider: StateProvider<double>, default 2000.0
- lifestyleFactorProvider: StateProvider<double>, default 1.0 — internal name kept for code stability; represents the awareness_factor (inverted: high awareness = low factor)
- co2ResultProvider: Provider<double> — derived, never set directly

## Design tokens
Background: #0F0F0E | Surface: #1A1917 | Elevated: #242220
Text: #E8E6E1 | Muted: #7A7875
Green (< 4t): #4A9B6F | Amber (4–8t): #C47B2B | Red (> 8t): #B84B3A
Font: DM Sans (bundled) | Result size: 56sp bold tabular

## Slider specs
- Spend: 500–10,000 EUR, step 50, default 2000
- CO₂ awareness: slider range 0.4–1.8, step 0.1, default 1.0 (displayed inverted: right = high awareness = low factor)
- Both use custom SliderTheme — no default Flutter blue

## Result display
- Shows X.X (large) and "t CO₂e / year" on separate rows, animated on change (TweenAnimationBuilder, 200ms)
- ±30% accuracy range shown below the result
- Colour transitions with result bracket
- Comparison: "X× the 1.5°C fair share (2.5t)" or "Below 1.5°C fair share 🌱"
- Benchmark bar always visible: 1.5°C fair share / continent averages (Africa → S. America → Asia → World → EU → Oceania → N. America)

## Privacy statement (shown in About screen)
"This app has no internet connection, stores nothing, and knows nothing about you.
Your data is your data."

## Testing
- formula_test.dart: unit tests for co2FromSpend() and resultBracket()
- widget_test.dart: smoke test both screens render without error
- No golden tests required for v1

## Localisation (lib/core/l10n.dart)
- 5 languages: English (en), Mandarin (zh), Hindi (hi), Spanish (es), French (fr)
- AppStrings class + AppStringsDelegate — use AppStrings.of(context) in all widgets
- localeProvider (Riverpod) drives the app locale; initialised from OS language in main.dart
- LanguageSelector widget at bottom of calculator screen: flag emoji buttons
- Do NOT use hardcoded strings in widgets — always go through AppStrings

## Android emulator setup (Pixel 6a, emulator-5554)
- Impeller disabled in AndroidManifest.xml (causes black screen on x86 OpenGLES):
  `<meta-data android:name="io.flutter.embedding.android.EnableImpeller" android:value="false"/>`
- Windows Firewall blocks the Dart VM Service on random ports — use a fixed port:
  `flutter run -d emulator-5554 --host-vmservice-port 40300`
- Port 40300 has inbound + outbound firewall rules added for this machine
- Port 50300 is in the Windows reserved range — do not use it
- If emulator freezes: `flutter emulators --launch Pixel_6a` then wait for `device` status in adb
- adb location: `%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe`

## GitHub / deployment
- Repo: https://github.com/zgrg/footprint
- GitHub Pages: https://zgrg.github.io/footprint/ (manual trigger only — workflow_dispatch)
- To deploy: GitHub → Actions → "Deploy to GitHub Pages" → Run workflow
- Pages source must be set to "GitHub Actions" in repo Settings → Pages
- gh CLI installed and authenticated as zgrg

## What NOT to do
- Do not add any splash screens that require network images
- Do not add Firebase, Crashlytics, Sentry, or any remote logging
- Do not add in-app purchases or ads
- Do not add login, accounts, or any user identity concept
- Do not persist slider values between sessions (intentional — reinforces privacy)
- Do not add more than these two screens for v1
