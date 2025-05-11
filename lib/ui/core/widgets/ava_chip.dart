import 'package:flutter/material.dart';

import '../themes/theme.dart';

class AvaChip extends StatelessWidget {
  final String text;

  const AvaChip({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
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
