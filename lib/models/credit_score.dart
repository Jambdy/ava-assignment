import 'package:freezed_annotation/freezed_annotation.dart';

part 'credit_score.freezed.dart';
part 'credit_score.g.dart';

@freezed
abstract class CreditScore with _$CreditScore {
  const factory CreditScore({
    required int currentScore,
    required int scoreChange,
    required String lastUpdated,
    required String nextUpdate,
    required List<ScoreEntry> scoreHistory,
    required String creditAgency,
    required List<CreditFactor> creditFactors,
    required List<CreditCardAccount> creditCardAccounts,
  }) = _CreditScore;

  factory CreditScore.fromJson(Map<String, dynamic> json) =>
      _$CreditScoreFromJson(json);
}

@freezed
abstract class ScoreEntry with _$ScoreEntry {
  const factory ScoreEntry({required int score, required DateTime date}) =
      _ScoreEntry;

  factory ScoreEntry.fromJson(Map<String, dynamic> json) =>
      _$ScoreEntryFromJson(json);
}

@freezed
abstract class CreditFactor with _$CreditFactor {
  const factory CreditFactor({
    required String name,
    required int value,
    required Impact impact,
    required Type type,
  }) = _CreditFactor;

  factory CreditFactor.fromJson(Map<String, dynamic> json) =>
      _$CreditFactorFromJson(json);
}

@freezed
abstract class CreditCardAccount with _$CreditCardAccount {
  const factory CreditCardAccount({
    required String accountName,
    required DateTime reportedDate,
    required int limit,
    required double balance,
  }) = _CreditCardAccount;

  factory CreditCardAccount.fromJson(Map<String, dynamic> json) =>
      _$CreditCardAccountFromJson(json);
}

/// Impact level of a credit factor
@JsonEnum()
enum Impact { high, medium, low }

/// Value type of a credit factor
@JsonEnum()
enum Type { number, percentage, months }
