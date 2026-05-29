# Footprint — App Specification
**Suite:** Yours · Private Tools  
**Version:** 1.0  
**Platform:** Flutter (Android · iOS · Web)  
**Privacy model:** Zero permissions · No data collection · No network calls · Fully offline

---

## 1. Concept & Purpose

Footprint is a radically simple CO₂ estimator. It makes one philosophical argument visible: **your spending power is the dominant variable in your carbon footprint**, and your lifestyle choices act as a multiplier on that base. Two sliders. One number. No accounts, no tracking, no permissions.

The app belongs to the *Yours* suite of privacy-conscious tools — apps that require zero permissions, collect no data, make no network calls, and sell nothing.

---

## 2. Core Formula

```
CO₂e (tonnes/year) = monthly_spend_eur × 12 × lifestyle_factor × 0.0007
```

Where:
- `monthly_spend_eur` — total monthly household spending in EUR (range: 500–10,000)
- `lifestyle_factor` — multiplier reflecting green vs. high-impact choices (range: 0.4–1.8)
- `0.0007` — EU average emission intensity: 0.7 kg CO₂e per €1 spent, converted to tonnes

### Lifestyle Factor Anchors

| Factor Value | Label | Description |
|---|---|---|
| 0.4 | 🌿 Very conscious | Plant-based diet, no flights, public transport only |
| 0.7 | 🚲 Tries to reduce | Mostly vegetarian, rare flights, mixed transport |
| 1.0 | ⚖️ EU average | Typical European lifestyle |
| 1.4 | 🚗 Comfortable | Drives daily, occasional flights, mixed diet |
| 1.8 | 🔥 High impact | Frequent flights, car-dependent, meat-heavy diet |

### Reference Benchmarks (shown in result screen)

| Benchmark | Value |
|---|---|
| 🌍 Global 2050 target | 2.5 t/year |
| 🇩🇪 German average | 8.0 t/year |
| 🇪🇺 EU average | 7.2 t/year |
| 🌏 World average | 4.8 t/year |
| 💰 Global top 1% | 74.0 t/year |

---

## 3. Screens

### Screen 1 — Calculator (Home)

The only interactive screen. Full-screen, minimal.

**Layout (top to bottom):**
1. App name: `footprint` — small, muted, top-left
2. Suite label: `yours ·` — even smaller, inline before app name
3. **Slider 1 — Monthly Spend**
   - Label: "What do you spend per month?"
   - Sub-label: "All expenses — rent, food, travel, everything"
   - Range: €500 → €10,000 (step: €50)
   - Default: €2,000
   - Display: live EUR value above thumb, formatted with thousands separator
4. **Slider 2 — Lifestyle**
   - Label: "How much do you care?"
   - Range: 0.4 → 1.8 (step: 0.1)
   - Default: 1.0
   - Display: emoji + label from anchor table above, updates live
5. **Result block** — large animated number:
   - `X.X tonnes CO₂e / year`
   - Colour-coded: green (<4t), amber (4–8t), red (>8t)
   - Comparison line: "That's [X]× the 2050 target" or "You're below the 2050 target 🌱"
6. **"See context" chevron** — expands inline to show the 5 reference benchmarks as a small comparison bar

### Screen 2 — About (accessible via ℹ️ icon, top-right)

Single scrollable screen:
- What the app calculates and how (formula explained in plain language)
- Data sources (EU emission intensity, Lund University lifestyle research)
- Privacy statement: *"This app has no internet connection, stores nothing, and knows nothing about you. Your data is your data."*
- Link to Yours suite (opens browser)
- Version number

---

## 4. Design System

### Palette — Dark-first, earthy

```
Background:        #0F0F0E  (near-black, warm)
Surface:           #1A1917
Surface elevated:  #242220
Border:            #2E2C29
Text primary:      #E8E6E1
Text muted:        #7A7875
Accent green:      #4A9B6F  (result < 4t)
Accent amber:      #C47B2B  (result 4–8t)
Accent red:        #B84B3A  (result > 8t)
Slider track:      #2E2C29
Slider active:     adapts to result colour
```

Light mode: inverted surfaces, same accent colours.

### Typography

- Font: **DM Sans** (Google Fonts) — clean, neutral, legible at all sizes
- App name `footprint`: lowercase, weight 300, tracking +0.05em
- Result number: weight 700, 56sp, tabular figures
- Body / labels: weight 400, 15sp
- Sub-labels: weight 400, 13sp, muted colour

### Slider Style

- Custom track: rounded, 4dp height, filled left of thumb in accent colour
- Thumb: 22dp circle, white fill, 1dp border in accent colour, subtle shadow
- No default Flutter blue — fully custom colours matching result state
- Smooth colour transition as result changes bracket (green → amber → red)

### Animation

- Result number: AnimatedSwitcher + TweenAnimationBuilder — count-up animation on value change (200ms)
- Slider colour transitions: 300ms ease-out
- Benchmark bar: slides in from bottom when "See context" is tapped (AnimatedContainer)

---

## 5. Privacy Architecture

- **Zero network calls** — no HTTP, no analytics, no crash reporting SDK
- **Zero permissions** — no location, camera, notifications, storage
- **Zero persistence** — no SharedPreferences, no local DB, no files written
- **Zero dependencies on remote services** — all computation is pure Dart math
- State lives only in memory (Riverpod providers), cleared on app close
- pubspec.yaml must be audited: no package may introduce network calls or device access

---

## 6. Flutter Architecture

### State Management: Riverpod (flutter_riverpod)

Two providers only:

```dart
// providers.dart
final monthlySpendProvider = StateProvider<double>((ref) => 2000.0);
final lifestyleFactorProvider = StateProvider<double>((ref) => 1.0);

final co2ResultProvider = Provider<double>((ref) {
  final spend = ref.watch(monthlySpendProvider);
  final factor = ref.watch(lifestyleFactorProvider);
  return spend * 12 * factor * 0.0007;
});
```

### Folder Structure

```
lib/
├── main.dart
├── app/
│   ├── app.dart              # MaterialApp + theme
│   ├── router.dart           # GoRouter: / and /about
│   └── theme.dart            # ThemeData light + dark
├── core/
│   ├── constants.dart        # emission factor, slider ranges, benchmarks
│   └── formula.dart          # co2FromSpend() pure function + tests
├── features/
│   ├── calculator/
│   │   ├── calculator_screen.dart
│   │   ├── spend_slider.dart
│   │   ├── lifestyle_slider.dart
│   │   ├── result_display.dart
│   │   └── benchmark_bar.dart
│   └── about/
│       └── about_screen.dart
├── shared/
│   ├── widgets/
│   │   └── yours_label.dart  # "yours · footprint" branding widget
│   └── providers/
│       └── providers.dart
test/
├── formula_test.dart
└── widget_test.dart
```

### Dependencies (pubspec.yaml)

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.5.1    # state management
  go_router: ^14.0.0          # navigation
  google_fonts: ^6.2.1        # DM Sans — loaded from bundled assets, not network
  
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0
```

> **Note:** `google_fonts` must be configured to use **bundled fonts** (not network fetch) to preserve the zero-network-calls guarantee. See setup instructions below.

---

## 7. Constants (core/constants.dart)

```dart
class FootprintConstants {
  // Formula
  static const double emissionIntensityEuKgPerEur = 0.7;
  static const double euToTonnes = 0.001;

  // Slider ranges
  static const double minSpend = 500.0;
  static const double maxSpend = 10000.0;
  static const double defaultSpend = 2000.0;
  static const double spendStep = 50.0;

  static const double minLifestyle = 0.4;
  static const double maxLifestyle = 1.8;
  static const double defaultLifestyle = 1.0;
  static const double lifestyleStep = 0.1;

  // Benchmarks (tonnes/year)
  static const double target2050 = 2.5;
  static const double germanAverage = 8.0;
  static const double euAverage = 7.2;
  static const double worldAverage = 4.8;
  static const double top1Percent = 74.0;

  // Result colour thresholds
  static const double greenThreshold = 4.0;
  static const double amberThreshold = 8.0;

  // Lifestyle labels
  static const List<Map<String, dynamic>> lifestyleAnchors = [
    {'value': 0.4, 'emoji': '🌿', 'label': 'Very conscious'},
    {'value': 0.7, 'emoji': '🚲', 'label': 'Tries to reduce'},
    {'value': 1.0, 'emoji': '⚖️', 'label': 'EU average'},
    {'value': 1.4, 'emoji': '🚗', 'label': 'Comfortable'},
    {'value': 1.8, 'emoji': '🔥', 'label': 'High impact'},
  ];
}
```

---

## 8. Core Formula (core/formula.dart)

```dart
/// Pure function — no side effects, fully testable
double co2FromSpend({
  required double monthlySpendEur,
  required double lifestyleFactor,
}) {
  return monthlySpendEur *
      12 *
      lifestyleFactor *
      FootprintConstants.emissionIntensityEuKgPerEur *
      FootprintConstants.euToTonnes;
}

/// Returns result colour based on value
ResultBracket resultBracket(double co2Tonnes) {
  if (co2Tonnes < FootprintConstants.greenThreshold) return ResultBracket.green;
  if (co2Tonnes < FootprintConstants.amberThreshold) return ResultBracket.amber;
  return ResultBracket.red;
}

enum ResultBracket { green, amber, red }
```

---

## 9. CLAUDE.md (project root)

This file is the AI context document — place it at the repository root so Claude Code reads it automatically.

```markdown
# CLAUDE.md — Footprint App

## What this app is
A two-slider CO₂ footprint estimator. Part of the "Yours" privacy-first tool suite.
Zero permissions. Zero network calls. Zero data stored. Fully offline.

## Core formula
co2_tonnes_per_year = monthly_spend_eur × 12 × lifestyle_factor × 0.0007
Emission intensity source: EU average 0.7 kg CO₂e per €1 household spend.

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
- lifestyleFactorProvider: StateProvider<double>, default 1.0
- co2ResultProvider: Provider<double> — derived, never set directly

## Design tokens
Background: #0F0F0E | Surface: #1A1917 | Elevated: #242220
Text: #E8E6E1 | Muted: #7A7875
Green (< 4t): #4A9B6F | Amber (4–8t): #C47B2B | Red (> 8t): #B84B3A
Font: DM Sans (bundled) | Result size: 56sp bold tabular

## Slider specs
- Spend: 500–10,000 EUR, step 50, default 2000
- Lifestyle: 0.4–1.8, step 0.1, default 1.0
- Both use custom SliderTheme — no default Flutter blue

## Result display
- Shows X.X t CO₂e/year, animated on change (TweenAnimationBuilder, 200ms)
- Colour transitions with result bracket
- Comparison: "X× the 2050 target (2.5t)" or "Below 2050 target 🌱"
- Expandable benchmark bar: 2050 target / World avg / EU avg / German avg / Top 1%

## Privacy statement (shown in About screen)
"This app has no internet connection, stores nothing, and knows nothing about you.
Your data is your data."

## Testing
- formula_test.dart: unit tests for co2FromSpend() and resultBracket()
- widget_test.dart: smoke test both screens render without error
- No golden tests required for v1

## What NOT to do
- Do not add any splash screens that require network images
- Do not add Firebase, Crashlytics, Sentry, or any remote logging
- Do not add in-app purchases or ads
- Do not add login, accounts, or any user identity concept
- Do not persist slider values between sessions (intentional — reinforces privacy)
- Do not add more than these two screens for v1
```

---

## 10. Repository Setup Instructions

### Prerequisites
- Flutter SDK ≥ 3.22 (stable channel)
- Dart ≥ 3.4
- Android Studio or VS Code with Flutter + Dart plugins
- Git

### Step-by-step

```bash
# 1. Create Flutter project
flutter create --org app.yours --project-name footprint footprint
cd footprint

# 2. Clean default boilerplate
rm lib/main.dart
rm test/widget_test.dart

# 3. Create folder structure
mkdir -p lib/app lib/core lib/features/calculator lib/features/about lib/shared/widgets lib/shared/providers
touch lib/main.dart
touch lib/app/app.dart lib/app/router.dart lib/app/theme.dart
touch lib/core/constants.dart lib/core/formula.dart
touch lib/features/calculator/calculator_screen.dart
touch lib/features/calculator/spend_slider.dart
touch lib/features/calculator/lifestyle_slider.dart
touch lib/features/calculator/result_display.dart
touch lib/features/calculator/benchmark_bar.dart
touch lib/features/about/about_screen.dart
touch lib/shared/widgets/yours_label.dart
touch lib/shared/providers/providers.dart
touch test/formula_test.dart test/widget_test.dart

# 4. Replace pubspec.yaml dependencies section with:
#    (edit manually or use sed)

# 5. Add DM Sans as a bundled font asset (offline — critical for privacy)
mkdir -p assets/fonts
# Download DM Sans from Google Fonts, extract TTF files into assets/fonts/
# Then in pubspec.yaml under flutter:
#   fonts:
#     - family: DM Sans
#       fonts:
#         - asset: assets/fonts/DMSans-Regular.ttf
#         - asset: assets/fonts/DMSans-Medium.ttf
#           weight: 500
#         - asset: assets/fonts/DMSans-Bold.ttf
#           weight: 700

# 6. Install dependencies
flutter pub get

# 7. Create CLAUDE.md at root (copy Section 9 above)
touch CLAUDE.md

# 8. Verify no network calls possible — check AndroidManifest
# lib/android/app/src/main/AndroidManifest.xml should have NO
# <uses-permission android:name="android.permission.INTERNET" />

# 9. Run on all targets
flutter run -d chrome        # web
flutter run -d android       # or your connected device
flutter run -d ios           # mac only

# 10. Run tests
flutter test
```

### Git Setup

```bash
git init
git add .
git commit -m "feat: initial Footprint app scaffold"
```

Recommended `.gitignore` additions (beyond Flutter defaults):
```
.env
*.jks
*.p12
*.keystore
google-services.json
GoogleService-Info.plist
```

---

## 11. Claude Code Workflow

With `CLAUDE.md` at the root, Claude Code reads it automatically as project context on every session. Recommended prompting pattern:

**To build a screen:**
> "Implement `calculator_screen.dart` following the spec in CLAUDE.md. Use Riverpod providers from providers.dart. Do not add any network calls or persistence."

**To build a widget:**
> "Implement `spend_slider.dart` as a ConsumerWidget. Slider range 500–10,000, step 50. Use SliderTheme with the design tokens from CLAUDE.md. Update monthlySpendProvider on change."

**To add a feature:**
> "Add the expandable benchmark_bar.dart to the calculator screen. It slides in with AnimatedContainer when a chevron is tapped. Show the 5 benchmarks from FootprintConstants as horizontal bars relative to the user's result. No network, no state persistence."

**To refactor:**
> "Refactor result_display.dart to use TweenAnimationBuilder for the number count-up animation. Duration 200ms. Colour must transition smoothly between green/amber/red brackets."

