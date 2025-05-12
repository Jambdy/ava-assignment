import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/ava_card.dart';
import '../../core/widgets/ava_outlined_circle_animation.dart';
import 'credit_score_status.dart';

class CreditScoreCard extends ConsumerWidget {
  const CreditScoreCard({
    super.key,
    required this.currentScore,
    required this.creditScoreStatus,
    required this.scoreChange,
    required this.lastUpdated,
    required this.nextUpdate,
    required this.creditAgency,
  });

  final int currentScore;
  final String creditScoreStatus;
  final int scoreChange;
  final String lastUpdated;
  final String nextUpdate;
  final String creditAgency;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AvaCard(
      height: 104,
      outlined: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CreditScoreStatus(
            scoreChange: scoreChange,
            lastUpdated: lastUpdated,
            nextUpdate: nextUpdate,
            creditAgency: creditAgency,
          ),
          AvaOutlinedCircleAnimation(
            currentValue: currentScore,
            maxValue: 850,
            underText: creditScoreStatus,
          ),
        ],
      ),
    );
  }
}
