class CreditScore {
  final int currentScore;
  final int scoreChange;
  final String lastUpdated;
  final String nextUpdate;
  final List<ScoreEntry> scoreHistory;
  final String creditAgency;
  final List<CreditFactor> creditFactors;
  final List<CreditCardAccount> creditCardAccounts;

  CreditScore({
    required this.currentScore,
    required this.scoreChange,
    required this.lastUpdated,
    required this.nextUpdate,
    required this.scoreHistory,
    required this.creditAgency,
    required this.creditFactors,
    required this.creditCardAccounts,
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
  final Impact impact;
  final Type type;

  CreditFactor({
    required this.name,
    required this.value,
    required this.impact,
    required this.type,
  });
}

enum Impact { high, medium, low }

enum Type { number, percentage, months }

class CreditCardAccount {
  final String accountName;
  final DateTime reportedDate;
  final int limit;
  final double balance;

  CreditCardAccount({
    required this.accountName,
    required this.reportedDate,
    required this.limit,
    required this.balance,
  });
}
