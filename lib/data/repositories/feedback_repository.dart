import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/api_client.dart';

part 'feedback_repository.g.dart';

@riverpod
FeedbackRepository feedbackRepository(Ref ref) {
  final apiClient = ref.read(apiClientProvider);
  return FeedbackRepository(apiClient);
}

class FeedbackRepository {
  final ApiClient _apiClient;

  FeedbackRepository(this._apiClient);

  Future<void> sendFeedback(String message) async {
    await _apiClient.sendFeedback(message);
  }
}
