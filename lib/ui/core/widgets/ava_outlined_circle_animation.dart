import 'dart:math';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../core/themes/color.dart';
import '../../core/themes/theme.dart';

class AvaOutlinedCircleAnimation extends StatefulWidget {
  /// Diameter of the widget.
  final double size;

  /// Current vale.
  final int currentValue;

  /// Max value
  final int maxValue;

  /// Text to display under counter
  final String? underText;

  /// Width of the arc stroke.
  final double strokeWidth;

  /// Duration of the animation in milliseconds.
  final int durationInMilliseconds;

  /// Display text suffix (ex. %)
  final String? textSuffix;

  const AvaOutlinedCircleAnimation({
    super.key,
    required this.currentValue,
    required this.maxValue,
    this.size = 72,
    this.strokeWidth = 6,
    this.underText,
    this.durationInMilliseconds = Constants.animationDuration,
    this.textSuffix = '',
  });

  @override
  AnimatedArcCountCircleState createState() => AnimatedArcCountCircleState();
}

class AnimatedArcCountCircleState extends State<AvaOutlinedCircleAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _angleAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds:
            (widget.durationInMilliseconds *
                    widget.currentValue /
                    widget.maxValue)
                .toInt(),
      ),
    );
    // Tween from 0 → creditScore
    _angleAnim = Tween<double>(
      begin: 0,
      end: widget.currentValue.toDouble(),
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
                  currentValue: widget.maxValue.toDouble(),
                  maxValue: widget.maxValue,
                  color: AppColors.avaSecondaryLight,
                  strokeWidth: widget.strokeWidth,
                ),
              ),
              CustomPaint(
                size: Size.square(widget.size),
                painter: _ArcPainter(
                  currentValue: _angleAnim.value,
                  maxValue: widget.maxValue,
                  color: Theme.of(context).colorScheme.secondary,
                  strokeWidth: widget.strokeWidth,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    '${_angleAnim.value.toInt()}${widget.textSuffix}',
                    style: AppTheme.graphMedium,
                  ),
                  if (widget.underText != null)
                    Text(widget.underText!, style: AppTheme.smallEmphasis),
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
  /// Value relative to the max value used to determine the sweep angle.
  final double currentValue;
  final int maxValue;
  final Color color;
  final double strokeWidth;

  _ArcPainter({
    required this.currentValue,
    required this.maxValue,
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

    // Draw the arc starting from top moving clockwise
    canvas.drawArc(
      rect,
      3 * pi / 2,
      currentValue / maxValue * pi * 2,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _ArcPainter old) {
    return old.currentValue != currentValue ||
        old.color != color ||
        old.strokeWidth != strokeWidth;
  }
}
