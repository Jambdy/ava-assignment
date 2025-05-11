import 'package:flutter/material.dart';

class AvaCard extends StatelessWidget {
  const AvaCard({
    super.key,
    required this.height,
    required this.width,
    this.outlined = true,
    this.borderRadius = 20,
    required this.child,
  });

  final double height;
  final double width;
  final bool outlined;
  final Widget child;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
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
