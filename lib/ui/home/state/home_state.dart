import '../../../models/credit_score.dart';

class HomeState {
  final CreditScore creditScore;
  final String creditScoreStatus;
  final CreditScoreGraphData creditScoreGraphData;

  HomeState({
    required this.creditScore,
    required this.creditScoreStatus,
    required this.creditScoreGraphData,
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
