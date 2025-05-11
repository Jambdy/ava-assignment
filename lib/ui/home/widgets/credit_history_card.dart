import 'package:flutter/material.dart';

import '../../core/themes/color.dart';
import '../../core/themes/theme.dart';
import '../../core/widgets/ava_card.dart';
import '../state/home_state.dart';
import 'credit_history_chart.dart';
import 'credit_score_status.dart';

class CreditHistoryCard extends StatelessWidget {
  const CreditHistoryCard({
    super.key,
    required this.scoreChange,
    required this.lastUpdated,
    required this.nextUpdate,
    required this.creditAgency,
    required this.creditScoreGraphData,
  });

  final int scoreChange;
  final String lastUpdated;
  final String nextUpdate;
  final String creditAgency;
  final CreditScoreGraphData creditScoreGraphData;

  @override
  Widget build(BuildContext context) {
    return AvaCard(
      height: 260,
      width: 340,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CreditScoreStatus(
            scoreChange: scoreChange,
            lastUpdated: lastUpdated,
            nextUpdate: nextUpdate,
            creditAgency: creditAgency,
          ),
          SizedBox(
            height: 97,
            child: CreditHistoryChart(
              creditScoreGraphData: creditScoreGraphData,
            ),
          ),
          Center(
            child: Column(
              children: [
                Text('Last 12 months', style: AppTheme.overlineEmphasis),
                Text(
                  'Score calculated using VantageScore 3.0',
                  style: AppTheme.overlineRegular.copyWith(
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
