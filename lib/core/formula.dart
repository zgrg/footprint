double co2FromSpend(double monthlySpendEur, double lifestyleFactor) {
  return monthlySpendEur * 12 * lifestyleFactor * 0.0007;
}

enum ResultBracket { green, amber, red }

ResultBracket resultBracket(double co2TonnesPerYear) {
  if (co2TonnesPerYear < 4) return ResultBracket.green;
  if (co2TonnesPerYear <= 8) return ResultBracket.amber;
  return ResultBracket.red;
}
