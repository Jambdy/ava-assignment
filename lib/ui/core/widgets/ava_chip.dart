import 'package:flutter/material.dart';

import '../themes/theme.dart';

class AvaChip extends StatelessWidget {
  /// Text to display in the chip.
  final String text;

  /// Background color of the chip.
  final Color backgroundColor;

  const AvaChip({super.key, required this.text, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Text(
          text,
          style: AppTheme.detailEmphasis.copyWith(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
    );
  }
}
