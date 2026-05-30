# Footprint

A radically simple CO₂ footprint estimator. Part of the **Yours** suite of privacy-first tools.

Two sliders. One number. No accounts, no tracking, no permissions, no network calls.

---

## What it does

Footprint makes one argument visible: your spending power is the dominant variable in your carbon footprint, and your CO₂ awareness acts as a multiplier on that base.

```
CO₂e (t/year) = monthly spend × 12 × awareness factor × 0.0007
```

The 0.0007 constant is the EU average consumption-based emission intensity (0.7 kg CO₂e per €1), sourced from Ivanova & Wood (2020).

---

## Privacy

- No internet connection
- No data stored
- No permissions required
- All computation is pure in-memory math — nothing leaves the device

---

## Platforms

Flutter app targeting Android, iOS, and web.

---

## Development

```bash
flutter pub get
flutter run
flutter test
```

Requires Flutter ≥ 3.22 / Dart ≥ 3.4.

---

## How it was built

- **Concept & product direction:** zgrg
- **Technical specification:** generated with [Perplexity AI](https://www.perplexity.ai)
- **Implementation:** written with [Claude Code](https://claude.com/claude-code) (Anthropic)

---

## Scientific basis

The emission intensity constant and awareness factor range are grounded in peer-reviewed research. See the [About screen](lib/features/about/about_screen.dart) in the app for sources and limitations, including the distinction between CO₂-only benchmarks and the CO₂e formula output.

Key references:
- Ivanova & Wood (2020). *Global Sustainability* 3, e18. doi:[10.1017/sus.2020.12](https://doi.org/10.1017/sus.2020.12)
- Wynes & Nicholas (2017). *Environ. Research Letters* 12, 074024. doi:[10.1088/1748-9326/aa7541](https://doi.org/10.1088/1748-9326/aa7541)

---

## License

All rights reserved — see [LICENSE](LICENSE).  
Copyright (c) 2026 zgrg.
