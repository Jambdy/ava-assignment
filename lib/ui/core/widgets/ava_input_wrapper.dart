import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../themes/color.dart';
import '../themes/theme.dart';

class AvaInputWrapper extends StatelessWidget {
  /// Value to display if disabled
  final String? displayValue;

  /// Input label
  final String label;

  /// Input widget (text, dropdown, etc.) Shown if input is enabled
  final Widget inputWidget;

  /// Whether the input is enabled or not
  final bool enabled;

  const AvaInputWrapper({
    super.key,
    required this.displayValue,
    required this.label,
    required this.inputWidget,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Text(
            label,
            style:
            enabled
                ? AppTheme.detailEmphasis
                : AppTheme.overlineRegular.copyWith(
              color: AppColors.textLight,
            ),
          ),
        ),
        enabled
            ? inputWidget
            : Text(displayValue ?? '', style: AppTheme.bodyRegular),
        const SizedBox(height: Constants.paddingDefault),
      ],
    );
  }
}
