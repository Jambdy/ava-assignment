import 'dart:math';
import 'package:flutter/material.dart';

import '../../core/themes/color.dart';
import '../../core/themes/theme.dart';

class CreditScoreAnimation extends StatefulWidget {
  /// Diameter of the widget.
  final double size;

  /// How many degrees the arc should sweep to (0 → 360).
  final int creditScore;

  /// Text to display under counter
  final String? underText;

  /// Width of the arc stroke.
  final double strokeWidth;

  const CreditScoreAnimation({
    super.key,
    this.size = 100,
    this.creditScore = 270,
    this.strokeWidth = 6,
    this.underText,
  });

  @override
  AnimatedArcCountCircleState createState() => AnimatedArcCountCircleState();
}

class AnimatedArcCountCircleState extends State<CreditScoreAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _angleAnim;

  //TODO: add bottom text
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: (2000 * 850 / widget.creditScore).toInt(),
      ),
    );
    // Tween from 0 → creditScore
    _angleAnim = Tween<double>(
      begin: 0,
      end: widget.creditScore.toDouble(),
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
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _angleAnim,
        builder: (_, __) {
          return Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size.square(widget.size),
                painter: _ArcPainter(
                  sweepAngle: 850,
                  color: AppColors.avaSecondaryLight,
                  strokeWidth: widget.strokeWidth,
                ),
              ),
              CustomPaint(
                size: Size.square(widget.size),
                painter: _ArcPainter(
                  sweepAngle: _angleAnim.value,
                  color: Theme.of(context).colorScheme.secondary,
                  strokeWidth: widget.strokeWidth,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${_angleAnim.value.toInt()}',
                    style: AppTheme.graphMedium,
                  ),
                  if (widget.underText != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Text(
                        widget.underText!,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium!.copyWith(fontSize: 8),
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double sweepAngle; // in radians
  final Color color;
  final double strokeWidth;

  _ArcPainter({
    required this.sweepAngle,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..color = color
          ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, 3 * pi / 2, sweepAngle / 850 * pi * 2, false, paint);
  }

  @override
  bool shouldRepaint(covariant _ArcPainter old) {
    return old.sweepAngle != sweepAngle ||
        old.color != color ||
        old.strokeWidth != strokeWidth;
  }
}
