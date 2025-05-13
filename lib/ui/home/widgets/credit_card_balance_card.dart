import 'package:flutter/material.dart';

import '../../core/themes/color.dart';
import '../../core/themes/theme.dart';
import '../../core/widgets/ava_card.dart';
import '../../core/widgets/ava_grade_bar.dart';
import '../../core/widgets/ava_outlined_circle_animation.dart';
import '../state/home_state.dart';

class CreditCardBalanceCard extends StatelessWidget {
  final CreditCardAccountsAggregate cCData;

  const CreditCardBalanceCard({super.key, required this.cCData});

  @override
  Widget build(BuildContext context) {
    return AvaCard(
      height: 196,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Total balance: ',
                          style: AppTheme.bodyEmphasis,
                        ),
                        TextSpan(
                          text: '\$${cCData.totalBalanceDisplay}',
                          style: AppTheme.bodyEmphasis.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Total limit: \$${cCData.totalLimitDisplay}',
                    style: AppTheme.detailRegular.copyWith(
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
              AvaOutlinedCircleAnimation(
                currentValue: cCData.totalUtilization,
                maxValue: 100,
                textSuffix: '%',
                underText: cCData.utilizationGrade.gradeText,
              ),
            ],
          ),
          AvaGradeBar(
            gradeRank: cCData.utilizationGrade.gradeRank,
            gradeText: cCData.utilizationGrade.gradeText,
            section: cCData.utilizationGrade.section,
            sections: ['0-9%', '10-29%', '30-49%', '50-74%', '<75%'],
          ),
        ],
      ),
    );
  }
}
