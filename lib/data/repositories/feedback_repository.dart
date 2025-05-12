import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feedback_repository.g.dart';

@riverpod
FeedbackRepository feedbackRepository(Ref ref) => FeedbackRepository();

class FeedbackRepository {
  Future<void> sendFeedback(String message) async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
