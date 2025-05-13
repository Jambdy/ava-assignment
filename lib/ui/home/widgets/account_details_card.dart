import 'dart:math';

import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../core/themes/color.dart';
import '../../core/themes/theme.dart';
import '../../core/widgets/ava.dart';
import '../state/home_state.dart';

class AccountDetailsCard extends StatelessWidget {
  final AccountDetailsDisplay details;

  const AccountDetailsCard({super.key, required this.details});

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
                balanceDisplay: details.balanceDisplay,
                progressPercent: details.balanceRatio,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Spend limit: \$${details.spendLimitDisplay}',
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
                    '\$${details.balanceDisplay}',
                    style: AppTheme.bodyEmphasis,
                  ),
                  Text(
                    '\$${details.creditLimitDisplay}',
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
                '${details.utilizationDisplay}%',
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

  const _SpendLimitProgress({
    required this.balanceDisplay,
    required this.progressPercent,
  });

  @override
  _SpendLimitProgressState createState() => _SpendLimitProgressState();
}

class _SpendLimitProgressState extends State<_SpendLimitProgress>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _progressAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds:
            (Constants.animationDuration * widget.progressPercent).toInt(),
      ),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return AnimatedBuilder(
          animation: _progressAnim,
          builder: (_, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Show speech bubble centered around the progress bar
                Padding(
                  padding: EdgeInsets.only(
                    // Stop near edge of the card
                    left: min(
                      max(widget.progressPercent * width, 16),
                      width - widget.balanceDisplay.length * 8 - 30,
                    ),
                    bottom: 8,
                  ),
                  child: Align(
                    alignment: const FractionalOffset(-0.5, 0),
                    widthFactor: 2,
                    child: Opacity(
                      opacity:
                          widget.progressPercent == 0
                              ? 1
                              : _progressAnim.value / widget.progressPercent,
                      child: AvaSpeechBubble(
                        text: '\$${widget.balanceDisplay}',
                      ),
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
                          left: min(
                            max(width * _progressAnim.value - 2, 0),
                            width - 4,
                          ),
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
        );
      },
    );
  }
}
