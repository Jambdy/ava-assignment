import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../constants/constants.dart';
import '../../models/account_details.dart';
import '../../models/credit_score.dart';
import '../../models/employment.dart';

part 'api_client.g.dart';

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  return ApiClient();
}

class ApiClient {
  // This is a placeholder for the actual API client implementation.
  // In a real-world scenario, this would include methods for making API calls,
  // and could leverage separate API models that could be mapped to the base
  // models used in the app. For simplicity existing models are used here.

  Future<AccountDetails> getAccountDetails() async {
    // Simulate a network call
    await Future.delayed(const Duration(milliseconds: Constants.mockAPIDelay));
    return AccountDetails(
      balance: Random().nextInt(101).toDouble(),
      spendLimit: 100,
      creditLimit: 600,
    );
  }

  Future<CreditScore> getCreditScore() async {
    // Simulate a network call
    await Future.delayed(const Duration(milliseconds: Constants.mockAPIDelay));
    // Dummy score history
    List<ScoreEntry> scoreHistory = [];
    var currentScore = Random().nextInt(850 - 300) + 300;
    for (int i = 1; i <= Random().nextInt(20) + 1; i++) {
      currentScore = max(
        min(currentScore + Random().nextInt(100) - 50, 850),
        300,
      );
      scoreHistory.add(
        ScoreEntry(
          score: currentScore,
          date: DateTime.now().subtract(Duration(days: Random().nextInt(365))),
        ),
      );
    }
    // TODO: Implement conversion from mock API response
    return CreditScore(
      currentScore: Random().nextInt(850 - 300) + 300,
      scoreChange: Random().nextInt(20) - 5,
      lastUpdated: DateTime.now().subtract(const Duration(days: 1)),
      nextUpdate: DateTime.now().add(const Duration(days: 30)),
      scoreHistory: scoreHistory,
      creditAgency: 'Experian',
      creditFactors: [
        CreditFactor(
          name: 'Payment History',
          value: Random().nextInt(101),
          impact: Impact.high,
          type: Type.percentage,
        ),
        CreditFactor(
          name: 'Credit Card Utilization',
          value: Random().nextInt(101),
          impact: Impact.low,
          type: Type.percentage,
        ),
        CreditFactor(
          name: 'Derogatory Marks',
          value: Random().nextInt(15),
          impact: Impact.medium,
          type: Type.number,
        ),
        CreditFactor(
          name: 'Age of Credit History',
          value: Random().nextInt(12 * 20),
          impact: Impact.medium,
          type: Type.months,
        ),
        CreditFactor(
          name: 'Hard Inquiries',
          value: Random().nextInt(15),
          impact: Impact.low,
          type: Type.number,
        ),
        CreditFactor(
          name: 'Total Accounts',
          value: Random().nextInt(15),
          impact: Impact.low,
          type: Type.number,
        ),
      ],
      creditCardAccounts: [
        CreditCardAccount(
          accountName: 'Chase Freedom',
          reportedDate: DateTime.now().subtract(const Duration(days: 30)),
          limit: 5000,
          balance: Random().nextInt(5001).toDouble(),
        ),
        CreditCardAccount(
          accountName: 'Discover It',
          reportedDate: DateTime.now().subtract(const Duration(days: 60)),
          limit: 3000,
          balance: Random().nextInt(3001).toDouble(),
        ),
        CreditCardAccount(
          accountName: 'Capital One Quicksilver',
          reportedDate: DateTime.now().subtract(const Duration(days: 90)),
          limit: 10000,
          balance: Random().nextInt(10001).toDouble(),
        ),
      ],
    );
  }

  Future<void> updateEmploymentInfo(Employment employment) async {
    // Simulate a network call
    await Future.delayed(const Duration(milliseconds: Constants.mockAPIDelay));
  }

  Future<void> sendFeedback(String message) async {
    // Simulate a network call
    await Future.delayed(const Duration(milliseconds: Constants.mockAPIDelay));
  }
}
