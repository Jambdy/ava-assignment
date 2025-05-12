import 'package:flutter/material.dart';

import '../../../utils/layout_utils.dart';
import '../../core/themes/color.dart';
import '../../core/themes/theme.dart';
import '../../core/widgets/ava_card.dart';
import '../state/home_state.dart';
import 'credit_score_status.dart';

class CreditHistoryCard extends StatelessWidget {
  final int scoreChange;
  final String lastUpdated;
  final String nextUpdate;
  final String creditAgency;
  final CreditScoreGraphData creditScoreGraphData;

  const CreditHistoryCard({
    super.key,
    required this.scoreChange,
    required this.lastUpdated,
    required this.nextUpdate,
    required this.creditAgency,
    required this.creditScoreGraphData,
  });

  @override
  Widget build(BuildContext context) {
    return AvaCard(
      height: 260,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CreditScoreStatus(
            scoreChange: scoreChange,
            lastUpdated: lastUpdated,
            nextUpdate: nextUpdate,
            creditAgency: creditAgency,
          ),
          SizedBox(
            height: 97,
            child: _CreditHistoryChart(
              creditScoreGraphData: creditScoreGraphData,
            ),
          ),
          Center(
            child: Column(
              children: [
                const Text('Last 12 months', style: AppTheme.overlineEmphasis),
                Text(
                  'Score calculated using VantageScore 3.0',
                  style: AppTheme.overlineRegular.copyWith(
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CreditHistoryChart extends StatefulWidget {
  final CreditScoreGraphData creditScoreGraphData;

  const _CreditHistoryChart({required this.creditScoreGraphData});

  @override
  _CreditHistoryChartState createState() => _CreditHistoryChartState();
}

class _CreditHistoryChartState extends State<_CreditHistoryChart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: widget.creditScoreGraphData.duration,
    )..forward();
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.linear);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children:
              [
                    widget.creditScoreGraphData.maxScore,
                    widget.creditScoreGraphData.midScore,
                    widget.creditScoreGraphData.minScore,
                  ]
                  .map(
                    (e) => SizedBox(
                      height: 30,
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              e.toString(),
                              style: AppTheme.graphSmall,
                            ),
                          ),
                          Container(
                            height: 1,
                            width: LayoutUtils.constrainedWidth(context) - 122,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(44.0, 16.0, 18.0, 22.0),
          child: AnimatedBuilder(
            animation: _anim,
            builder: (_, __) {
              return CustomPaint(
                size: Size.infinite,
                painter: _LineChartPainter(
                  data: widget.creditScoreGraphData.data,
                  progress: _anim.value,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<double> data;
  final double progress;
  final Color color;
  final double strokeWidth = 2.5;
  final double dotRadius = 4;

  _LineChartPainter({
    required this.data,
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paintLine =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..color = color
          ..strokeCap = StrokeCap.round;

    final paintDot =
        Paint()
          ..style = PaintingStyle.fill
          ..color = AppColors.bgWhite
          ..strokeWidth = 1.5;

    final paintDotBorder =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..color = color;

    // Build our full list of points
    final bucketWidth = size.width / 11;
    List<Offset> points = List.generate(data.length, (i) {
      final dx = bucketWidth * i;
      final dy = size.height * (1 - data[i].clamp(0.0, 1.0));
      return Offset(dx, dy);
    });

    // How many points to fully draw, plus a partial segment fraction
    final total = (data.length - 1) * progress;
    final fullCount = total.floor(); // number of full segments
    final segmentFrac = total - fullCount; // partial segment [0..1)

    // Build path
    Path path = Path()..moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i <= fullCount; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    // partial next segment?
    if (fullCount < data.length - 1) {
      final a = points[fullCount];
      final b = points[fullCount + 1];
      final dx = a.dx + (b.dx - a.dx) * segmentFrac;
      final dy = a.dy + (b.dy - a.dy) * segmentFrac;
      path.lineTo(dx, dy);
    }

    // draw the line
    canvas.drawPath(path, paintLine);

    // draw the dots for each fully-revealed point
    for (int i = 0; i <= fullCount; i++) {
      canvas.drawCircle(points[i], dotRadius, paintDot);
      canvas.drawCircle(points[i], dotRadius, paintDotBorder);
    }
    // draw the partial dot
    if (fullCount < data.length - 1 && segmentFrac > 0) {
      final a = points[fullCount];
      final b = points[fullCount + 1];
      final dx = a.dx + (b.dx - a.dx) * segmentFrac;
      final dy = a.dy + (b.dy - a.dy) * segmentFrac;
      final pt = Offset(dx, dy);
      canvas.drawCircle(pt, dotRadius, paintDot);
      canvas.drawCircle(pt, dotRadius, paintDotBorder);
    }
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter old) =>
      old.progress != progress || old.data != data;
}
