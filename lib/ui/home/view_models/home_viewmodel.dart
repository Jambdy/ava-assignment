import 'dart:math';
import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../constants/constants.dart';
import '../../../data/repositories/account_details_repository.dart';
import '../../../data/repositories/credit_score_repository.dart';
import '../../../models/account_details.dart';
import '../../../models/credit_score.dart';
import '../../../utils/format_utils.dart';
import '../../core/themes/color.dart';
import '../state/home_state.dart';

part 'home_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class HomeViewModel extends _$HomeViewModel {
  @override
  Future<HomeState> build() async {
    final creditScore =
        await ref.read(creditScoreRepositoryProvider).getCreditScore();
    final accountDetails =
        await ref.read(accountDetailsRepositoryProvider).getAccountDetails();
    return _mapToHomeState(creditScore, accountDetails);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final creditScore =
          await ref.read(creditScoreRepositoryProvider).getCreditScore();
      final accountDetails =
          await ref.read(accountDetailsRepositoryProvider).getAccountDetails();
      return _mapToHomeState(creditScore, accountDetails);
    });
  }

  HomeState _mapToHomeState(
    CreditScore creditScore,
    AccountDetails accountDetails,
  ) {
    final creditScoreDisplay = _mapCreditScoreDisplay(creditScore);
    final creditScoreGraphData = _mapCreditScoreGraphData(
      creditScore.scoreHistory.map((e) => e.copyWith()).toList(),
    );
    final creditFactorDisplays = _mapCreditFactorDisplays(
      creditScore.creditFactors,
    );
    final accountDetailsDisplay = _mapAccountDetails(accountDetails);
    final creditCardAccountsAggregate = _mapCreditCardAccountsAggregate(
      creditScore.creditCardAccounts,
    );
    return HomeState(
      creditScoreDisplay: creditScoreDisplay,
      creditScoreGraphData: creditScoreGraphData,
      creditFactorsDisplay: creditFactorDisplays,
      accountDetails: accountDetailsDisplay,
      creditCardAccountsAggregate: creditCardAccountsAggregate,
    );
  }

  CreditScoreDisplay _mapCreditScoreDisplay(CreditScore creditScore) {
    return CreditScoreDisplay(
      currentScore: creditScore.currentScore,
      creditScoreStatus: _mapCreditScoreStatus(creditScore.currentScore),
      creditAgency: creditScore.creditAgency,
      lastUpdated: FormatUtils.formatDateRelative(creditScore.lastUpdated),
      nextUpdate: FormatUtils.formatDateRelative(creditScore.nextUpdate),
      scoreChangeDisplay:
          '${creditScore.scoreChange >= 0 ? '+' : '-'}${creditScore.scoreChange.abs()}pts',
      scoreChangeColor:
          creditScore.scoreChange >= 0
              ? AppColors.avaSecondary
              : AppColors.lightRed,
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
    var maxIntervals = Constants.historyIntervalMax;

    // Handle empty score history
    if (scoreHistory.isEmpty) {
      return CreditScoreGraphData(
        data: [],
        minScore: 600,
        maxScore: 800,
        midScore: 700,
        duration: const Duration(milliseconds: 0),
      );
    }

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
    var minScore = ((data.reduce(min) - 49) ~/ 50) * 50;
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
    );
  }

  AccountDetailsDisplay _mapAccountDetails(AccountDetails accountDetails) {
    var utilization =
        (accountDetails.balance / accountDetails.creditLimit * 100).toInt();
    var balanceRatio = accountDetails.balance / accountDetails.spendLimit;

    return AccountDetailsDisplay(
      utilizationDisplay: utilization.toString(),
      balanceRatio: balanceRatio,
      balanceDisplay: FormatUtils.formatNumberComma(accountDetails.balance),
      creditLimitDisplay: FormatUtils.formatNumberComma(
        accountDetails.creditLimit,
      ),
      spendLimitDisplay: FormatUtils.formatNumberComma(
        accountDetails.spendLimit,
      ),
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
    if (utilization < 50) {
      return CreditUtilizationGrade(
        gradeText: 'Fair',
        gradeRank: 2,
        section: (utilization < 30) ? 1 : 2,
      );
    }
    return CreditUtilizationGrade(
      gradeText: 'Poor',
      gradeRank: 3,
      section: (utilization < 75) ? 3 : 4,
    );
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
    var totalBalanceDisplay = FormatUtils.formatNumberComma(
      totalBalance.toInt(),
    );
    var totalLimitDisplay = FormatUtils.formatNumberComma(totalLimit);
    var totalUtilization = (totalBalance / totalLimit * 100).toInt();
    var utilizationGrade = _mapCreditUtilization(totalUtilization);

    var creditCardAccountsDisplay =
        creditCardAccounts
            .map(
              (account) => CreditCardAccountDisplay(
                accountName: account.accountName,
                limit: account.limit,
                balance: account.balance,
                formattedReportedDate: FormatUtils.formatDateShort(
                  account.reportedDate,
                ),
                balanceDisplay: FormatUtils.formatNumberComma(
                  account.balance.toInt(),
                ),
                limitDisplay: FormatUtils.formatNumberComma(
                  account.limit.toInt(),
                ),
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
