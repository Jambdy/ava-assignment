import 'dart:ui';

class HomeState {
  final CreditScoreDisplay creditScoreDisplay;
  final CreditScoreGraphData creditScoreGraphData;
  final List<CreditFactorDisplay> creditFactorsDisplay;
  final AccountDetailsDisplay accountDetails;
  final CreditCardAccountsAggregate creditCardAccountsAggregate;

  HomeState({
    required this.creditScoreDisplay,
    required this.creditScoreGraphData,
    required this.creditFactorsDisplay,
    required this.accountDetails,
    required this.creditCardAccountsAggregate,
  });
}

class CreditScoreDisplay {
  final int currentScore;
  final String creditScoreStatus;
  final String creditAgency;
  final String lastUpdated;
  final String nextUpdate;
  final int scoreChange;

  CreditScoreDisplay({
    required this.currentScore,
    required this.creditScoreStatus,
    required this.creditAgency,
    required this.lastUpdated,
    required this.nextUpdate,
    required this.scoreChange,
  });
}

class CreditScoreGraphData {
  final List<double> data;
  final int minScore;
  final int maxScore;
  final int midScore;
  final Duration duration;

  CreditScoreGraphData({
    required this.data,
    required this.minScore,
    required this.maxScore,
    required this.midScore,
    required this.duration,
  });
}

class CreditFactorDisplay {
  final String name;
  final String displayValue;
  final Color displayColor;
  final Color textColor;
  final String impactText;

  CreditFactorDisplay({
    required this.name,
    required this.displayValue,
    required this.displayColor,
    required this.textColor,
    required this.impactText,
  });
}

class AccountDetailsDisplay {
  final String balanceDisplay;
  final double balanceRatio;
  final String creditLimitDisplay;
  final String spendLimitDisplay;
  final String utilizationDisplay;

  AccountDetailsDisplay({
    required this.balanceDisplay,
    required this.balanceRatio,
    required this.creditLimitDisplay,
    required this.spendLimitDisplay,
    required this.utilizationDisplay,
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

class CreditCardAccountDisplay {
  final String accountName;
  final int limit;
  final double balance;
  final String formattedReportedDate;
  final String balanceDisplay;
  final String limitDisplay;
  final int utilization;

  CreditCardAccountDisplay({
    required this.accountName,
    required this.limit,
    required this.balance,
    required this.formattedReportedDate,
    required this.balanceDisplay,
    required this.limitDisplay,
    required this.utilization,
  });
}
