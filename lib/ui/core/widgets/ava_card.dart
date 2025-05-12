import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class AvaCard extends StatelessWidget {
  const AvaCard({
    super.key,
    this.width,
    this.height,
    this.outlined = true,
    this.borderRadius = 20,
    required this.child,
  });

  final double? height;
  final double? width;
  final bool outlined;
  final Widget child;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      constraints: const BoxConstraints(maxWidth: Constants.maxWidth),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(borderRadius),
        border:
            outlined
                ? Border.all(color: Theme.of(context).colorScheme.outline)
                : null,
      ),
      child: Padding(padding: const EdgeInsets.all(16.0), child: child),
    );
  }
}
