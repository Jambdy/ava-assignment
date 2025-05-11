import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/repositories/credit_score_repository.dart';
import '../state/home_state.dart';

part 'home_viewmodel.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  Future<HomeState> build() async {
    final creditScore =
        await ref.read(creditScoreRepositoryProvider).getCreditScore();
    final creditScoreStatus = _mapCreditScoreStatus(creditScore.currentScore);
    return HomeState(
      creditScore: creditScore,
      creditScoreStatus: creditScoreStatus,
    );
  }

  String _mapCreditScoreStatus(int score) {
    if (score >= 800) return 'Excellent';
    if (score >= 700) return 'Very Good';
    if (score >= 600) return 'Good';
    if (score >= 500) return 'Fair';
    return 'Poor';
  }
}
