import '../../../models/credit_score.dart';

class HomeState {
  final CreditScore creditScore;
  final String creditScoreStatus;

  HomeState({
    required this.creditScore,
    required this.creditScoreStatus,
  });
}