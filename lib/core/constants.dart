import 'package:flutter/material.dart';

// Colours
const Color colorBackground = Color(0xFF0F0F0E);
const Color colorSurface = Color(0xFF1A1917);
const Color colorElevated = Color(0xFF242220);
const Color colorText = Color(0xFFE8E6E1);
const Color colorMuted = Color(0xFF7A7875);
const Color colorGreen = Color(0xFF4A9B6F);
const Color colorAmber = Color(0xFFC47B2B);
const Color colorRed = Color(0xFFB84B3A);

// Slider bounds
const double spendMin = 500.0;
const double spendMax = 10000.0;
const double spendStep = 50.0;
const double spendDefault = 2000.0;

const double lifestyleMin = 0.4;
const double lifestyleMax = 1.8;
const double lifestyleStep = 0.1;
const double lifestyleDefault = 1.0;

// Benchmarks — territorial CO₂ per capita, 2023 (Global Carbon Project / Our World in Data).
// NOTE: these are CO₂-only. The calculator output is CO₂e (all greenhouse gases), so the
// bars read slightly low relative to the user's number — fine for an indicative estimator.
const double target2050 = 2.5;          // 1.5 °C-aligned fair share (~2.3–2.5); not a literal 2050 net-zero level (~0.5–1.5)
const double worldAvg = 4.7;            // was 7.0 (that was an all-GHG CO₂e figure)
const double africaAvg = 1.0;           // was 1.1
const double southAmericaAvg = 2.5;     // was 3.1
const double asiaAvg = 4.6;             // was 4.7
const double euAvg = 6.5;               // EU-27 (geographic Europe ≈7.1); was 8.0
const double northAmericaAvg = 10.3;    // continent incl. Mexico/Central America; was 14.5 (≈ USA alone)
const double oceaniaAvg = 10.0;         // continent incl. Pacific islands; was 13.8 (≈ Australia alone)

// Estimation accuracy (±30% of result)
const double accuracyFraction = 0.30;

// Result thresholds
const double bracketGreenMax = 4.0;
const double bracketAmberMax = 8.0;

// Animation
const Duration resultAnimationDuration = Duration(milliseconds: 200);
