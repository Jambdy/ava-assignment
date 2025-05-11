import 'dart:math';
import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/repositories/credit_score_repository.dart';
import '../../../models/credit_score.dart';
import '../../core/themes/color.dart';
import '../state/home_state.dart';

part 'home_viewmodel.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  Future<HomeState> build() async {
    final creditScore =
        await ref.read(creditScoreRepositoryProvider).getCreditScore();
    final creditScoreStatus = _mapCreditScoreStatus(creditScore.currentScore);
    final creditScoreGraphData = _generateCreditScoreGraphData(
      creditScore.scoreHistory,
    );
    final creditFactorDisplays = _generateCreditFactorDisplays(
      creditScore.creditFactors,
    );
    return HomeState(
      creditScore: creditScore,
      creditScoreStatus: creditScoreStatus,
      creditScoreGraphData: creditScoreGraphData,
      creditFactorsDisplay: creditFactorDisplays,
    );
  }

  String _mapCreditScoreStatus(int score) {
    if (score >= 800) return 'Excellent';
    if (score >= 700) return 'Very Good';
    if (score >= 600) return 'Good';
    if (score >= 500) return 'Fair';
    return 'Poor';
  }

  List<CreditFactorDisplay> _generateCreditFactorDisplays(
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
          impactText = 'High Impact';
          break;
        case Impact.medium:
          displayColor = AppColors.avaSecondary;
          textColor = AppColors.textWhite;
          impactText = 'Medium Impact';
          break;
        case Impact.low:
          displayColor = AppColors.avaSecondaryLight;
          textColor = AppColors.textGreen;
          impactText = 'Low Impact';
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
        value: factor.value,
        impact: factor.impact,
        type: factor.type,
        displayValue: displayValue,
        displayColor: displayColor,
        textColor: textColor,
        impactText: impactText,
      );
    }).toList();
  }

  CreditScoreGraphData _generateCreditScoreGraphData(
    List<ScoreEntry> scoreHistory,
  ) {
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
      milliseconds: (2000 / maxIntervals * data.length).toInt(),
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
}
