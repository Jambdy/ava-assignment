import 'package:flutter/material.dart';

import '../../core/themes/color.dart';
import '../../core/themes/theme.dart';
import '../../core/widgets/ava_card.dart';
import '../state/home_state.dart';

class CreditCardAccountsCard extends StatelessWidget {
  final List<CreditCardAccountDisplay> cCAccounts;

  const CreditCardAccountsCard({super.key, required this.cCAccounts});

  @override
  Widget build(BuildContext context) {
    return AvaCard(
      width: 343,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: cCAccounts.length,
        itemBuilder: (_, i) => _CreditCardAccount(cCAccount: cCAccounts[i]),
        separatorBuilder:
            (_, __) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: const Divider(color: AppColors.gray, height: 1),
            ),
      ),
    );
  }
}

class _CreditCardAccount extends StatelessWidget {
  final CreditCardAccountDisplay cCAccount;

  const _CreditCardAccount({required this.cCAccount});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(cCAccount.accountName, style: AppTheme.bodyEmphasis),
              Text('${cCAccount.utilization}%', style: AppTheme.bodyEmphasis),
            ],
          ),
          _AnimatedProgressBar(
            progressPercent: cCAccount.balance / cCAccount.limit,
            width: 343 - 2 * 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${cCAccount.balanceDisplay} Balance',
                style: AppTheme.detailRegular,
              ),
              Text(
                '\$${cCAccount.limitDisplay} Limit',
                style: AppTheme.detailRegular,
              ),
            ],
          ),
          Text(
            'Reported on ${cCAccount.formattedReportedDate}',
            style: AppTheme.overlineRegular.copyWith(
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedProgressBar extends StatefulWidget {
  final double width;
  final double progressPercent;

  const _AnimatedProgressBar({
    required this.progressPercent,
    required this.width,
  });

  @override
  _AnimatedProgressBarState createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<_AnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _progressAnim;

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
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.linear));
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
      height: 8,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.gray,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          AnimatedBuilder(
            animation: _progressAnim,
            builder: (_, __) {
              // Check if the progress is at the end of the bar
              var roundedEnd = _progressAnim.value >= 1 - (4 / widget.width);
              return Container(
                width: widget.width * _progressAnim.value,
                decoration: BoxDecoration(
                  color: AppColors.avaSecondary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(999),
                    bottomLeft: Radius.circular(999),
                    topRight: roundedEnd ? Radius.circular(999) : Radius.zero,
                    bottomRight:
                        roundedEnd ? Radius.circular(999) : Radius.zero,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
