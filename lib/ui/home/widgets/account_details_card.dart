import 'dart:math';

import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../utils/layout_utils.dart';
import '../../core/themes/color.dart';
import '../../core/themes/theme.dart';
import '../../core/widgets/ava_card.dart';
import '../../core/widgets/ava_speech_bubble.dart';
import '../state/home_state.dart';

class AccountDetailsCard extends StatelessWidget {
  final AccountDetailsDisplay accountDetails;

  const AccountDetailsCard({super.key, required this.accountDetails});

  @override
  Widget build(BuildContext context) {
    return AvaCard(
      height: 225,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              _SpendLimitProgress(
                balanceDisplay: accountDetails.balanceDisplay,
                progressPercent: accountDetails.balanceRatio,
                width:
                    LayoutUtils.constrainedWidth(context) -
                    2 * Constants.paddingDefault,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Spend limit: \$${accountDetails.spendLimit}',
                    style: AppTheme.detailRegular,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Why is it different',
                    style: AppTheme.overlineEmphasis.copyWith(
                      color: AppColors.lightPurp,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${accountDetails.balance.toInt()}',
                    style: AppTheme.bodyEmphasis,
                  ),
                  Text(
                    '\$${accountDetails.spendLimit}',
                    style: AppTheme.bodyEmphasis,
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Balance', style: AppTheme.detailRegular),
                  Text('Credit limit', style: AppTheme.detailRegular),
                ],
              ),
            ],
          ),
          const Divider(color: AppColors.gray, thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Utilization', style: AppTheme.bodyRegular),
              Text(
                '${accountDetails.utilization}%',
                style: AppTheme.bodyEmphasis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SpendLimitProgress extends StatefulWidget {
  final String balanceDisplay;
  final double progressPercent;
  final double width;

  const _SpendLimitProgress({
    required this.balanceDisplay,
    required this.progressPercent,
    required this.width,
  });

  @override
  _SpendLimitProgressState createState() => _SpendLimitProgressState();
}

class _SpendLimitProgressState extends State<_SpendLimitProgress>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _progressAnim;
  final double _speechWidth = 42;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (2000 * widget.progressPercent).toInt()),
    );
    _progressAnim = Tween<double>(
      begin: 0,
      end: widget.progressPercent,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: AnimatedBuilder(
        animation: _progressAnim,
        builder: (_, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                // TODO: Handle dynamic speech width
                padding: EdgeInsets.only(
                  left: max(
                    widget.progressPercent * widget.width - _speechWidth / 2,
                    0,
                  ),
                  bottom: 8,
                ),
                child: Opacity(
                  opacity: _progressAnim.value / widget.progressPercent,
                  child: AvaSpeechBubble(
                    text: '\$${widget.balanceDisplay}',
                    width: _speechWidth,
                  ),
                ),
              ),
              SizedBox(
                height: 8,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.avaSecondaryLight,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: max(widget.width * _progressAnim.value - 2, 0),
                      ),
                      width: 4,
                      decoration: const BoxDecoration(
                        color: AppColors.avaSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
