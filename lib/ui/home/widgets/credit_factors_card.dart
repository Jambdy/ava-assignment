import 'package:flutter/material.dart';

import '../../core/themes/color.dart';
import '../../core/themes/theme.dart';
import '../../core/widgets/ava.dart';
import '../state/home_state.dart';

class CreditFactorsCard extends StatelessWidget {
  const CreditFactorsCard({super.key, required this.creditFactorsDisplay});

  final List<CreditFactorDisplay> creditFactorsDisplay;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children:
            creditFactorsDisplay.map((factor) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: AvaCard(
                  height: 160,
                  width: 144,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 2,
                            ),
                            child: Text(
                              factor.name,
                              textAlign: TextAlign.center,
                              style: AppTheme.detailEmphasis.copyWith(
                                color: AppColors.textPrimaryDark,
                              ),
                            ),
                          ),
                          Text(
                            factor.displayValue,
                            style: AppTheme.title.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 28,
                        width: 112,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: factor.displayColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: const EdgeInsets.all(0),
                          ),
                          onPressed: () {},
                          child: Text(
                            factor.impactText,
                            style: AppTheme.interSmallBold.copyWith(
                              color: factor.textColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
