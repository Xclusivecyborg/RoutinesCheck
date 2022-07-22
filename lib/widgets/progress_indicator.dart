import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:routine_checks_mobile/utils/colors.dart';

class RoutineProgressIndicator extends StatefulWidget {
  const RoutineProgressIndicator({
    Key? key,
    this.completed = 50,
    this.missed = 50,
    this.pending = 50,
    this.size = 200,
  }) : super(key: key);
  final double completed, missed, pending, size;
  @override
  State<RoutineProgressIndicator> createState() =>
      _RoutineProgressIndicatorState();
}

class _RoutineProgressIndicatorState extends State<RoutineProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controller2;
  late Animation<double> _animation;
  late Animation<double> _animation2;
  late double completedPercentage;
  @override
  void initState() {
    completedPercentage =
        widget.completed / (widget.completed + widget.missed) * 100;
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 4000,
        ));
    _animation = Tween<double>(begin: 0, end: widget.completed)
        .animate(_controller)
      ..addListener(() => setState(() {}));
    _controller2 = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 4000,
        ));
    _animation2 = Tween<double>(begin: 0, end: widget.missed)
        .animate(_controller)
      ..addListener(() => setState(() {}));

    _controller.forward();
    _controller2.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: _ProgressPainter(
          firstPercentage: _animation.value,
          secondPercentage: _animation2.value,
        ),
        child: SizedBox(
          height: widget.size,
          width: widget.size,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  completedPercentage.isNaN
                      ? "0"
                      : '${(completedPercentage.toInt())}%',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (!completedPercentage.isNaN)
                  Text(
                    completedPercentage >= 70.0 ? "👍🏽" : "😞 ",
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProgressPainter extends CustomPainter {
  final double firstPercentage;
  final double secondPercentage;

  _ProgressPainter({
    required this.firstPercentage,
    required this.secondPercentage,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final paint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 40
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    //Completed percentage arcpaint
    final arcpaint = Paint()
      ..shader = AppColors.completedGradient
      .createShader(const Rect.fromLTWH(40, 100, 300, 100))
      ..strokeWidth = 40
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;
    var startAngle = math.pi * firstPercentage / 100;
    double sweepAngle = math.pi * (firstPercentage / 50);

    //Pending percentage circle
    canvas.drawCircle(center, radius, paint);

    //Completed percentage arcpaint
    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      startAngle,
      sweepAngle,
      false,
      arcpaint,
    );

    //missed percentage arcpaint
    final arcpaint2 = Paint()
      ..shader = AppColors.missedGradient.createShader(const Rect.fromLTWH(40, 100, 300, 100))
      ..strokeWidth = 40
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;
    var startAngle2 = sweepAngle + math.pi * firstPercentage / 100;
    double sweepAngle2 = math.pi * (secondPercentage / 50);

//missed percentage arc
    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      startAngle2,
      sweepAngle2,
      false,
      arcpaint2,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
