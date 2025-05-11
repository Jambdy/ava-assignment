import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/credit_score.dart';

part 'credit_score_repository.g.dart';

@riverpod
CreditScoreRepository creditScoreRepository(Ref ref) =>
    CreditScoreRepository();

class CreditScoreRepository {
  Future<CreditScore> getCreditScore() async {
    // TODO: Implement conversion from mock API response
    return CreditScore(
      currentScore: 720,
      scoreChange: 2,
      lastUpdated: 'Today',
      nextUpdate: 'May 12',
      scoreHistory: [
        ScoreEntry(
          score: 650,
          date: DateTime.now().subtract(const Duration(days: 60)),
        ),
        ScoreEntry(
          score: 710,
          date: DateTime.now().subtract(const Duration(days: 30)),
        ),
        ScoreEntry(score: 720, date: DateTime.now()),
      ],
      creditAgency: 'Experian',
      creditFactors: [
        CreditFactor(
          name: 'Payment History',
          value: 100,
          displayValue: '100%',
          impact: 'High impact',
        ),
        CreditFactor(
          name: 'Credit Card Utilization',
          value: 4,
          displayValue: '4%',
          impact: 'Medium impact',
        ),
        CreditFactor(
          name: 'Derogatory Marks',
          value: 0,
          displayValue: '0',
          impact: 'High impact',
        ),
        CreditFactor(
          name: 'Age of Credit History',
          value: 68,
          displayValue: '5 yrs 8',
          impact: 'Medium impact',
        ),
        CreditFactor(
          name: 'Hard Inquiries',
          value: 0,
          displayValue: '0',
          impact: 'Low impact',
        ),
        CreditFactor(
          name: 'Total Accounts',
          value: 15,
          displayValue: '15',
          impact: 'Low impact',
        ),
      ],
    );
  }
}
