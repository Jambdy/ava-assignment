import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class AvaCard extends StatelessWidget {
  /// The height of the card. If null, the card will adjust to its content.
  final double? height;

  /// The width of the card. If null, the card will adjust to its content.
  final double? width;

  /// Whether the card has an outlined border.
  final bool outlined;

  /// The child widget to display inside the card.
  final Widget child;

  /// The border radius of the card.
  final double borderRadius;

  const AvaCard({
    super.key,
    this.width,
    this.height,
    this.outlined = true,
    this.borderRadius = 20,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      constraints: const BoxConstraints(maxWidth: Constants.widthMax),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(borderRadius),
        border:
            outlined
                ? Border.all(color: Theme.of(context).colorScheme.outline)
                : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(Constants.paddingDefault),
        child: child,
      ),
    );
  }
}
