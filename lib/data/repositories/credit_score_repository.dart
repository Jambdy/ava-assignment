import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/credit_score.dart';
import '../services/api_client.dart';

part 'credit_score_repository.g.dart';

@riverpod
CreditScoreRepository creditScoreRepository(Ref ref) {
  final apiClient = ref.read(apiClientProvider);
  return CreditScoreRepository(apiClient);
}

class CreditScoreRepository {
  final ApiClient _apiClient;

  CreditScoreRepository(this._apiClient);

  Future<CreditScore> getCreditScore() async {
    var creditScore = await _apiClient.getCreditScore();
    return creditScore.copyWith();
  }
}
