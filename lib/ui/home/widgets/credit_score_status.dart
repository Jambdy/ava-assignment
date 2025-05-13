import 'package:flutter/material.dart';

import '../../core/themes/color.dart';
import '../../core/themes/theme.dart';
import '../../core/widgets/ava.dart';

class CreditScoreStatus extends StatelessWidget {
  final String scoreChangeDisplay;
  final Color scoreChangeColor;
  final String lastUpdated;
  final String nextUpdate;
  final String creditAgency;

  const CreditScoreStatus({
    super.key,
    required this.scoreChangeDisplay,
    required this.scoreChangeColor,
    required this.lastUpdated,
    required this.nextUpdate,
    required this.creditAgency,
  });

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
            AvaChip(
              text: scoreChangeDisplay,
              backgroundColor: scoreChangeColor,
            ),
          ],
        ),
        const SizedBox(width: 4),
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
