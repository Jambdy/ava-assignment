import 'dart:ui';

import '../../../models/account_details.dart';
import '../../../models/credit_score.dart';

class HomeState {
  final CreditScore creditScore;
  final String creditScoreStatus;
  final CreditScoreGraphData creditScoreGraphData;
  final List<CreditFactorDisplay> creditFactorsDisplay;
  final AccountDetailsDisplay accountDetails;
  final CreditCardAccountsAggregate creditCardAccountsAggregate;

  HomeState({
    required this.creditScore,
    required this.creditScoreStatus,
    required this.creditScoreGraphData,
    required this.creditFactorsDisplay,
    required this.accountDetails,
    required this.creditCardAccountsAggregate,
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

  String get balanceDisplay => balance.toInt().toString();

  AccountDetailsDisplay({
    required super.spendLimit,
    required super.balance,
    required super.creditLimit,
  });
}

class CreditCardAccountsAggregate {
  final String totalBalanceDisplay;
  final String totalLimitDisplay;
  final int totalUtilization;
  final CreditUtilizationGrade utilizationGrade;
  final List<CreditCardAccountDisplay> creditCardAccountsDisplay;

  CreditCardAccountsAggregate({
    required this.totalBalanceDisplay,
    required this.totalLimitDisplay,
    required this.totalUtilization,
    required this.utilizationGrade,
    required this.creditCardAccountsDisplay,
  });
}

class CreditUtilizationGrade {
  final String gradeText;
  final int gradeRank;
  final int section;

  CreditUtilizationGrade({
    required this.gradeText,
    required this.gradeRank,
    required this.section,
  });
}

class CreditCardAccountDisplay extends CreditCardAccount {
  final String formattedReportedDate;
  final String balanceDisplay;
  final String limitDisplay;
  final int utilization;

  CreditCardAccountDisplay({
    required super.accountName,
    required super.reportedDate,
    required super.limit,
    required super.balance,
    required this.formattedReportedDate,
    required this.balanceDisplay,
    required this.limitDisplay,
    required this.utilization,
  });
}
