import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/constants.dart';
import '../../../utils/layout_utils.dart';
import '../../core/widgets/ava.dart';
import 'credit_score_status.dart';

class CreditScoreCard extends ConsumerWidget {
  final int currentScore;
  final String creditScoreStatus;
  final String scoreChangeDisplay;
  final Color scoreChangeColor;
  final String lastUpdated;
  final String nextUpdate;
  final String creditAgency;

  const CreditScoreCard({
    super.key,
    required this.currentScore,
    required this.creditScoreStatus,
    required this.scoreChangeDisplay,
    required this.scoreChangeColor,
    required this.lastUpdated,
    required this.nextUpdate,
    required this.creditAgency,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AvaCard(
      height: 104,
      width:
          LayoutUtils.constrainedWidth(context) - Constants.paddingDefault * 2,
      outlined: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CreditScoreStatus(
            scoreChangeDisplay: scoreChangeDisplay,
            scoreChangeColor: scoreChangeColor,
            lastUpdated: lastUpdated,
            nextUpdate: nextUpdate,
            creditAgency: creditAgency,
          ),
          AvaOutlinedCircleAnimation(
            currentValue: currentScore,
            maxValue: Constants.creditScoreMax,
            underText: creditScoreStatus,
          ),
        ],
      ),
    );
  }
}
