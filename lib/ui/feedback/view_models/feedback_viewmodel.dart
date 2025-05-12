import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/repositories/feedback_repository.dart';

part 'feedback_viewmodel.g.dart';

@riverpod
class FeedbackViewModel extends _$FeedbackViewModel {
  @override
  Future<void> build() async {}

  Future<void> submitFeedback(String feedback) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(feedbackRepositoryProvider).sendFeedback(feedback);
    });
  }
}
