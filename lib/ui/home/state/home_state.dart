import 'dart:ui';

import '../../../models/account_details.dart';
import '../../../models/credit_score.dart';

class HomeState {
  final CreditScore creditScore;
  final String creditScoreStatus;
  final CreditScoreGraphData creditScoreGraphData;
  final List<CreditFactorDisplay> creditFactorsDisplay;
  final AccountDetailsDisplay accountDetails;

  HomeState({
    required this.creditScore,
    required this.creditScoreStatus,
    required this.creditScoreGraphData,
    required this.creditFactorsDisplay,
    required this.accountDetails,
  });
}

class CreditScoreGraphData {
  final List<double> data;
  final int minScore;
  final int maxScore;
  final int midScore;
  final Duration duration;
  final int maxIntervals;

  CreditScoreGraphData({
    required this.data,
    required this.minScore,
    required this.maxScore,
    required this.midScore,
    required this.duration,
    required this.maxIntervals,
  });
}

class CreditFactorDisplay extends CreditFactor {
  final String displayValue;
  final Color displayColor;
  final Color textColor;
  final String impactText;

  CreditFactorDisplay({
    required super.name,
    required super.value,
    required super.impact,
    required super.type,
    required this.displayValue,
    required this.displayColor,
    required this.textColor,
    required this.impactText,
  });
}

class AccountDetailsDisplay extends AccountDetails {
  int get utilization => (balance / creditLimit).toInt() * 100;
  double get balanceRatio => balance / spendLimit;

  AccountDetailsDisplay({
    required super.spendLimit,
    required super.balance,
    required super.creditLimit,
  });
}
