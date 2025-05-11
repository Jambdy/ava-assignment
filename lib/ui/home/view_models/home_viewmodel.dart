import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/repositories/credit_score_repository.dart';
import '../../../models/credit_score.dart';
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
    return HomeState(
      creditScore: creditScore,
      creditScoreStatus: creditScoreStatus,
      creditScoreGraphData: creditScoreGraphData,
    );
  }

  String _mapCreditScoreStatus(int score) {
    if (score >= 800) return 'Excellent';
    if (score >= 700) return 'Very Good';
    if (score >= 600) return 'Good';
    if (score >= 500) return 'Fair';
    return 'Poor';
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
