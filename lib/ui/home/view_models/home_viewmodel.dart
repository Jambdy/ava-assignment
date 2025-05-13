import 'dart:math';
import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../constants/constants.dart';
import '../../../data/repositories/account_details_repository.dart';
import '../../../data/repositories/credit_score_repository.dart';
import '../../../models/account_details.dart';
import '../../../models/credit_score.dart';
import '../../core/themes/color.dart';
import '../state/home_state.dart';

part 'home_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class HomeViewModel extends _$HomeViewModel {
  @override
  Future<HomeState> build() async {
    final creditScore =
        await ref.read(creditScoreRepositoryProvider).getCreditScore();
    final creditScoreStatus = _mapCreditScoreStatus(creditScore.currentScore);
    final creditScoreGraphData = _mapCreditScoreGraphData(
      creditScore.scoreHistory,
    );
    final creditFactorDisplays = _mapCreditFactorDisplays(
      creditScore.creditFactors,
    );
    final accountDetails = _mapAccountDetails(
      await ref.read(accountDetailsRepositoryProvider).getAccountDetails(),
    );
    final creditCardAccountsAggregate = _mapCreditCardAccountsAggregate(
      creditScore.creditCardAccounts,
    );
    return HomeState(
      creditScore: creditScore,
      creditScoreStatus: creditScoreStatus,
      creditScoreGraphData: creditScoreGraphData,
      creditFactorsDisplay: creditFactorDisplays,
      accountDetails: accountDetails,
      creditCardAccountsAggregate: creditCardAccountsAggregate,
    );
  }

  String _mapCreditScoreStatus(int score) {
    if (score >= 800) return 'Excellent';
    if (score >= 700) return 'Very Good';
    if (score >= 600) return 'Good';
    if (score >= 500) return 'Fair';
    return 'Poor';
  }

  List<CreditFactorDisplay> _mapCreditFactorDisplays(
    List<CreditFactor> creditFactors,
  ) {
    return creditFactors.map((factor) {
      Color displayColor;
      Color textColor;
      String impactText;
      switch (factor.impact) {
        case Impact.high:
          displayColor = AppColors.textGreen;
          textColor = AppColors.textWhite;
          impactText = 'HIGH IMPACT';
          break;
        case Impact.medium:
          displayColor = AppColors.avaSecondary;
          textColor = AppColors.textWhite;
          impactText = 'MEDIUM IMPACT';
          break;
        case Impact.low:
          displayColor = AppColors.avaSecondaryLight;
          textColor = AppColors.textGreen;
          impactText = 'LOW IMPACT';
          break;
      }
      String displayValue;
      switch (factor.type) {
        case Type.number:
          displayValue = factor.value.toString();
          break;
        case Type.percentage:
          displayValue = '${factor.value}%';
          break;
        case Type.months:
          var y = factor.value ~/ 12;
          var m = factor.value % 12;
          displayValue = '$y yrs $m';
          break;
      }

      return CreditFactorDisplay(
        name: factor.name,
        displayValue: displayValue,
        displayColor: displayColor,
        textColor: textColor,
        impactText: impactText,
      );
    }).toList();
  }

  CreditScoreGraphData _mapCreditScoreGraphData(List<ScoreEntry> scoreHistory) {
    var maxIntervals = 12;

    // Sort the score history by date in descending order
    scoreHistory.sort((a, b) => b.date.compareTo(a.date));
    // Take the most recent events, then sort in ascending order
    var data =
        scoreHistory
            .take(maxIntervals)
            .toList()
            .reversed
            .map((e) => e.score.toDouble())
            .toList();
    var minScore = ((data.reduce(min) + 49) ~/ 50) * 50;
    var maxScore = ((data.reduce(max) + 49) ~/ 50) * 50;
    var midScore = ((maxScore + minScore) / 2).round();
    var duration = Duration(
      milliseconds:
          (Constants.animationDuration / maxIntervals * data.length).toInt(),
    );

    // Normalize the data to a 0-1 scale
    data = data.map((e) => (e - minScore) / (maxScore - minScore)).toList();

    return CreditScoreGraphData(
      data: data,
      minScore: minScore,
      maxScore: maxScore,
      midScore: midScore,
      duration: duration,
      maxIntervals: maxIntervals,
    );
  }

  AccountDetailsDisplay _mapAccountDetails(AccountDetails accountDetails) {
    var utilization =
        (accountDetails.balance / accountDetails.creditLimit * 100).toInt();
    var balanceRatio = accountDetails.balance / accountDetails.spendLimit;
    var balanceDisplay = accountDetails.balance.toInt().toString();

    return AccountDetailsDisplay(
      accountDetails: accountDetails.copyWith(),
      utilizationDisplay: utilization.toString(),
      balanceRatio: balanceRatio,
      balanceDisplay: balanceDisplay,
    );
  }

  CreditUtilizationGrade _mapCreditUtilization(int utilization) {
    if (utilization < 10) {
      return CreditUtilizationGrade(
        gradeText: 'Excellent',
        gradeRank: 1,
        section: 0,
      );
    }
    if (utilization < 75) {
      return CreditUtilizationGrade(
        gradeText: 'Fair',
        gradeRank: 2,
        section:
            (utilization < 30)
                ? 1
                : (utilization < 50)
                ? 2
                : 3,
      );
    }
    return CreditUtilizationGrade(gradeText: 'Poor', gradeRank: 3, section: 4);
  }

  CreditCardAccountsAggregate _mapCreditCardAccountsAggregate(
    List<CreditCardAccount> creditCardAccounts,
  ) {
    var totalLimit = 0;
    var totalBalance = 0.0;
    for (var account in creditCardAccounts) {
      totalLimit += account.limit;
      totalBalance += account.balance;
    }
    var totalBalanceDisplay = NumberFormat(
      '#,###',
    ).format(totalBalance.toInt());
    var totalLimitDisplay = NumberFormat('#,###').format(totalLimit);
    var totalUtilization = (totalBalance / totalLimit * 100).toInt();
    var utilizationGrade = _mapCreditUtilization(totalUtilization);

    var creditCardAccountsDisplay =
        creditCardAccounts
            .map(
              (account) => CreditCardAccountDisplay(
                accountName: account.accountName,
                limit: account.limit,
                balance: account.balance,
                formattedReportedDate: DateFormat(
                  'MMMM d, y',
                ).format(account.reportedDate),
                balanceDisplay: NumberFormat(
                  '#,###',
                ).format(account.balance.toInt()),
                limitDisplay: NumberFormat(
                  '#,###',
                ).format(account.limit.toInt()),
                utilization: (account.balance / account.limit * 100).toInt(),
              ),
            )
            .toList();
    return CreditCardAccountsAggregate(
      totalBalanceDisplay: totalBalanceDisplay,
      totalLimitDisplay: totalLimitDisplay,
      totalUtilization: totalUtilization,
      utilizationGrade: utilizationGrade,
      creditCardAccountsDisplay: creditCardAccountsDisplay,
    );
  }
}
