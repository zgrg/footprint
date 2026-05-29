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

// Benchmarks (t CO₂e/year)
const double target2050 = 2.5;
const double worldAvg = 7.0;
const double euAvg = 8.0;
const double germanAvg = 11.0;
const double top1Percent = 70.0;

// Result thresholds
const double bracketGreenMax = 4.0;
const double bracketAmberMax = 8.0;

// Animation
const Duration resultAnimationDuration = Duration(milliseconds: 200);
