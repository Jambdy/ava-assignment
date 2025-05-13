import 'package:flutter/material.dart';

import '../themes/theme.dart';

class AvaSpeechBubble extends StatelessWidget {
  /// Text to display in the speech bubble.
  final String text;

  const AvaSpeechBubble({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          // alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            text,
            style: AppTheme.detailRegular.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        CustomPaint(
          size: const Size(12, 6),
          painter: _TrianglePainter(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}

/// Paints a triangle pointing down.
class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path =
        Path()
          ..moveTo(0, 0)
          ..lineTo(size.width / 2, size.height)
          ..lineTo(size.width, 0)
          ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TrianglePainter old) => false;
}
