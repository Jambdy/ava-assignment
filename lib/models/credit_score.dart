class CreditScore {
  final int currentScore;
  final int scoreChange;
  final String lastUpdated;
  final String nextUpdate;
  final List<ScoreEntry> scoreHistory;
  final String creditAgency;
  final List<CreditFactor> creditFactors;

  CreditScore({
    required this.currentScore,
    required this.scoreChange,
    required this.lastUpdated,
    required this.nextUpdate,
    required this.scoreHistory,
    required this.creditAgency,
    required this.creditFactors,
  });
}

class ScoreEntry {
  final int score;
  final DateTime date;

  ScoreEntry({required this.score, required this.date});
}

class CreditFactor {
  final String name;
  final int value;
  final String displayValue;
  final String impact;

  CreditFactor({
    required this.name,
    required this.value,
    required this.displayValue,
    required this.impact,
  });
}
