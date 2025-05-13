import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../../core/themes/color.dart';
import '../../core/themes/theme.dart';
import '../view_models/feedback_viewmodel.dart';

class FeedbackOverlay extends ConsumerStatefulWidget {
  const FeedbackOverlay({super.key});

  @override
  ConsumerState<FeedbackOverlay> createState() => _FeedbackOverlayState();
}

class _FeedbackOverlayState extends ConsumerState<FeedbackOverlay> {
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feedbackViewModel = ref.read(feedbackViewModelProvider.notifier);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: maxWidth - 16,
              decoration: const BoxDecoration(
                color: AppColors.lightPurp,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
            ),
            Container(
              height: maxHeight - 14,
              decoration: const BoxDecoration(
                color: AppColors.manilla,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: const EdgeInsets.fromLTRB(
                Constants.paddingDefault,
                Constants.paddingDefault,
                Constants.paddingDefault,
                32.0,
              ),
              child: Column(
                children: [
                  const Text('Give us feedback', style: AppTheme.bodyRegular),
                  const SizedBox(height: 32),
                  Expanded(
                    child: TextField(
                      expands: true,
                      maxLines: null,
                      controller: _feedbackController,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: const InputDecoration(
                        hintText: 'Enter feedback here',
                      ),
                    ),
                  ),
                  const SizedBox(height: Constants.paddingDefault),
                  SizedBox(
                    height: 44,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        feedbackViewModel.submitFeedback(
                          _feedbackController.text,
                        );
                        context.router.pop();
                      },
                      child: const Text('Submit Feedback'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
