import 'package:flutter/material.dart';

class AvaCard extends StatelessWidget {
  final double height;
  final double width;
  final bool outlined;
  final Widget child;

  const AvaCard({
    super.key,
    required this.height,
    required this.width,
    this.outlined = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border:
            outlined
                ? Border.all(color: Theme.of(context).colorScheme.outline)
                : null,
      ),
      child: Padding(padding: const EdgeInsets.all(16.0), child: child),
    );
  }
}
