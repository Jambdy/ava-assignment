import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/credit_score.dart';

part 'credit_score_repository.g.dart';

@riverpod
CreditScoreRepository creditScoreRepository(Ref ref) => CreditScoreRepository();

class CreditScoreRepository {
  Future<CreditScore> getCreditScore() async {
    // TODO: Implement conversion from mock API response
    return CreditScore(
      currentScore: 720,
      scoreChange: 2,
      lastUpdated: DateTime.now().subtract(const Duration(days: 1)),
      nextUpdate: DateTime.now().add(const Duration(days: 30)),
      scoreHistory: [
        ScoreEntry(
          score: 650,
          date: DateTime.now().subtract(const Duration(days: 10)),
        ),
        ScoreEntry(
          score: 710,
          date: DateTime.now().subtract(const Duration(days: 9)),
        ),
        ScoreEntry(
          score: 720,
          date: DateTime.now().subtract(const Duration(days: 8)),
        ),
        ScoreEntry(
          score: 750,
          date: DateTime.now().subtract(const Duration(days: 7)),
        ),
        ScoreEntry(
          score: 710,
          date: DateTime.now().subtract(const Duration(days: 6)),
        ),
        ScoreEntry(score: 680, date: DateTime.now()),
      ],
      creditAgency: 'Experian',
      creditFactors: [
        const CreditFactor(
          name: 'Payment History',
          value: 100,
          impact: Impact.high,
          type: Type.percentage,
        ),
        const CreditFactor(
          name: 'Credit Card Utilization',
          value: 4,
          impact: Impact.low,
          type: Type.percentage,
        ),
        const CreditFactor(
          name: 'Derogatory Marks',
          value: 0,
          impact: Impact.medium,
          type: Type.number,
        ),
        const CreditFactor(
          name: 'Age of Credit History',
          value: 68,
          impact: Impact.medium,
          type: Type.months,
        ),
        const CreditFactor(
          name: 'Hard Inquiries',
          value: 0,
          impact: Impact.low,
          type: Type.number,
        ),
        const CreditFactor(
          name: 'Total Accounts',
          value: 15,
          impact: Impact.low,
          type: Type.number,
        ),
      ],
      creditCardAccounts: [
        CreditCardAccount(
          accountName: 'Chase Freedom',
          reportedDate: DateTime.now().subtract(const Duration(days: 30)),
          limit: 5000,
          balance: 5000,
        ),
        CreditCardAccount(
          accountName: 'Discover It',
          reportedDate: DateTime.now().subtract(const Duration(days: 60)),
          limit: 3000,
          balance: 1500,
        ),
        CreditCardAccount(
          accountName: 'Capital One Quicksilver',
          reportedDate: DateTime.now().subtract(const Duration(days: 90)),
          limit: 10000,
          balance: 5000,
        ),
      ],
    );
  }
}
