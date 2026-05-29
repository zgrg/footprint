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

---

## 12. Scientific Verification & References

This section records the peer-reviewed basis for the formula and constants, the result of verifying the Perplexity-derived numbers, and recommended corrections. The aim is scientific defensibility, not precision — the app is an order-of-magnitude estimator, and this should be stated plainly in the About screen.

### 12.1 Emission intensity constant (0.7 kg CO₂e per €1) — VERIFIED

The central constant is well supported. Ivanova & Wood (2020) linked household expenditure across 26 EU countries to greenhouse-gas intensities from the EXIOBASE multi-regional input–output model and report an **EU average carbon intensity of ≈0.7 kg CO₂e per €1 of household expenditure**. The same EXIOBASE-based method underlies Ivanova et al. (2016). The figure is a *consumption-based* (supply-chain inclusive) intensity, which is the correct basis for a spend-driven estimator.

Two caveats the spec should acknowledge:

1. **Intensity is not flat across spending.** It varies strongly by category — transport/fuel ≈1.3 kg CO₂e/€, services and electronics lower — and it rises with income (Ivanova & Wood report ≈0.86 kg/€ for the EU top 10% and ≈0.95 kg/€ for the top 1%). A single 0.7 factor therefore *underestimates* high spenders and slightly overestimates low spenders. Acceptable for a simple model, but worth a one-line disclaimer.
2. **Footprint grows slightly slower than spending** (expenditure elasticity < 1), because higher earners shift spending toward lower-intensity services. Strict proportionality (`spend × constant`) is thus a simplification, not a law.

**Verdict:** Keep 0.7. It is the best-supported single number in the model.
  
### 12.2 Linear spend → emissions model — VERIFIED (as a simplification)

Roughly two-thirds of global GHG emissions are directly or indirectly linked to household consumption (Ivanova et al., 2020), and per-capita footprint scales strongly with expenditure. The core claim — "spending power is the dominant variable" — is defensible. The linear form is a reasonable first-order approximation given the caveats in 12.1.

### 12.3 Lifestyle factor (0.4–1.8) — PARTIALLY SUPPORTED / IS A MODELLING CONSTRUCT

The *direction and rough magnitude* are supported. Wynes & Nicholas (2017) quantify the highest-impact individual actions (living car-free ≈2.0–2.6 t CO₂e/yr saved, avoiding one long-haul return flight ≈1.6 t, plant-based diet ≈0.8 t), and Ivanova et al. (2020) synthesise mitigation potentials across food, housing and transport. Together these justify that conscious choices can cut a footprint by roughly half and high-impact lifestyles can inflate it — consistent with a ~0.4–1.8 span.

However, three honest limitations:

1. The multiplier itself is **not a published constant**; it is the app's own construct. Present it as illustrative, not measured.
2. It **partially double-counts spend.** Flying less and driving less also *reduce spending*, so the lifestyle factor and the spend slider are not fully independent — applying both multiplicatively can over-state the spread at the extremes.
3. The anchor labels (plant-based, flights, transport) are qualitatively correct descriptors of the dominant levers.

**Verdict:** Keep, but relabel in the About screen as an illustrative adjustment, not a literature value.

### 12.4 Benchmarks — TWO CORRECTIONS NEEDED

| Benchmark | Spec value | Assessment | Recommended (CO₂e, current) |
|---|---|---|---|
| 1.5 °C fair share | "2050 target" 2.5 t | ⚠️ **Mislabelled.** 2.5 t ≈ a *near-term (≈2030)* 1.5 °C-aligned per-capita fair share (Oxfam/IEEP cite ≈2.3 t). A true *2050* net-zero level is ≈0.5–1.5 t. | Relabel "1.5 °C fair share ≈2.3 t" |
| German average | 8.0 t | ✅ Good — consumption/territorial ≈8.1 t CO₂e (2023). | 8.1 t |
| EU average | 7.2 t | ⚠️ **Low / unit mismatch.** Eurostat 2023 GHG footprint = **9.0 t CO₂e** per capita. 7.2 looks like CO₂-only. | 9.0 t |
| World average | 4.8 t | ⚠️ **Unit mismatch.** 4.8 ≈ CO₂-*only* territorial (~4.7 t). Full GHG footprint ≈6.7 t CO₂e. | 6.7 t |
| Global top 1% | 74.0 t | ✅ Reasonable. Oxfam ≈70 t (consumption, 2019); Chancel (2022) ≈110 t *including investments*. | ~70 t (consumption) |

**The key systemic issue is CO₂ vs CO₂e.** The formula and the 0.7 intensity are in CO₂**e** (all greenhouse gases), but two benchmarks (EU 7.2, World 4.8) appear to be CO₂-only. Mixing the two makes the comparison bar internally inconsistent. **Recommendation: state every benchmark in CO₂e** and use the right-hand column above. After this fix, a typical default run (€2,000/mo × factor 1.0 → ≈16.8 t) reads correctly as well above the EU average — which is itself a known feature of spend-based models overstating average households; consider noting the model is best for *relative* comparison, not absolute accuracy.

### 12.5 References (DOI)

- Ivanova, D., & Wood, R. (2020). The unequal distribution of household carbon footprints in Europe and its link to sustainability. *Global Sustainability*, 3, e18. https://doi.org/10.1017/sus.2020.12 — **source for the 0.7 kg CO₂e/€ intensity.**
- Ivanova, D., Stadler, K., Steen-Olsen, K., Wood, R., Vita, G., Tukker, A., & Hertwich, E. G. (2016). Environmental Impact Assessment of Household Consumption. *Journal of Industrial Ecology*, 20(3), 526–536. https://doi.org/10.1111/jiec.12371 — household consumption as a primary emissions driver; EXIOBASE method.
- Ivanova, D., Barrett, J., Wiedenhofer, D., Macura, B., Callaghan, M., & Creutzig, F. (2020). Quantifying the potential for climate change mitigation of consumption options. *Environmental Research Letters*, 15(9), 093001. https://doi.org/10.1088/1748-9326/ab8589 — ~two-thirds of GHG from consumption; mitigation potentials underpinning the lifestyle factor.
- Wynes, S., & Nicholas, K. A. (2017). The climate mitigation gap. *Environmental Research Letters*, 12(7), 074024. https://doi.org/10.1088/1748-9326/aa7541 — high-impact lifestyle actions (diet, flights, car-free); basis for lifestyle anchors. *(This is the "Lund University" source named in the About screen.)*
- Chancel, L. (2022). Global carbon inequality over 1990–2019. *Nature Sustainability*, 5(11), 931–938. https://doi.org/10.1038/s41893-022-00955-z — top 1% per-capita footprint.
- Stadler, K., et al. (2018). EXIOBASE 3: Developing a Time Series of Detailed Environmentally Extended Multi-Regional Input–Output Tables. *Journal of Industrial Ecology*, 22(3), 502–515. https://doi.org/10.1111/jiec.12715 — the underlying emission-intensity database.

Non-DOI data sources (statistics, no DOI): Eurostat, *Greenhouse gas emission footprints* (EU & member-state per-capita CO₂e, 2023); IPCC (2018), *Global Warming of 1.5 °C* (SR15) for the 1.5 °C carbon budget; Oxfam/IEEP (2021), *Carbon inequality in 2030* for the fair-share and top-1% figures.

