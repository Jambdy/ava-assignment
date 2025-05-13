import 'package:flutter/material.dart';

import '../../core/themes/color.dart';
import '../../core/themes/theme.dart';
import '../../core/widgets/ava_chip.dart';

class CreditScoreStatus extends StatelessWidget {
  const CreditScoreStatus({
    super.key,
    required this.scoreChange,
    required this.lastUpdated,
    required this.nextUpdate,
    required this.creditAgency,
  });

  final int scoreChange;
  final String lastUpdated;
  final String nextUpdate;
  final String creditAgency;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Text('Credit Score', style: AppTheme.bodyEmphasis),
            ),
            AvaChip(text: '+${scoreChange}pts'),
          ],
        ),
        Text(
          'Updated $lastUpdated | Next $nextUpdate',
          style: AppTheme.detailRegular.copyWith(color: AppColors.textLight),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            creditAgency,
            style: AppTheme.overlineEmphasis.copyWith(
              color: AppColors.lightPurp,
            ),
          ),
        ),
      ],
    );
  }
}
