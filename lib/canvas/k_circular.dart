import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kommon/kommon.dart';

class KCircularWidget extends StatelessWidget {
  // 百分比
  final double percentage;
  final Size? size;
  final String? text;
  final double thickness;
  final Color? textColor;
  final Color? color;
  final double? textSize;

  const KCircularWidget(
      {Key? key,
      this.percentage = 0.0,
      this.size,
      this.thickness = 1.0,
      this.text,
      this.textColor = Colors.black54,
      this.textSize = 12,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size ?? Size.zero,
      painter: _KCircularPainter(
          percentage: percentage,
          text: text,
          thickness: thickness,
          color: color ?? Colors.lightBlueAccent,
          textColor: textColor,
          textSize: textSize),
      willChange: true,
    );
  }
}

class _KCircularPainter extends CustomPainter {
  double percentage;
  final double thickness;
  final Color color;
  final String? text;
  final Color? textColor;
  final double? textSize;

  _KCircularPainter(
      {this.percentage = 0.0,
      this.text,
      required this.thickness,
      required this.color,
      this.textColor,
      this.textSize});

  @override
  void paint(Canvas canvas, Size size) {
    double rad = min(size.width, size.height) / 2 - thickness;
    final paint = Paint();
    paint.color = Colors.blueAccent;
    paint.style = PaintingStyle.stroke;
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2), radius: rad),
        0,
        percentage * 2 * pi,
        false,
        paint);
    TextPainter tp = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
            text: text, style: TextStyle(color: textColor, fontSize: textSize)),
        textAlign: TextAlign.left);
    tp.layout();
    tp.paint(
      canvas,
      Offset(
        (size.width - tp.width) * 0.5,
        (size.height - tp.height) * 0.5,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return percentage != (oldDelegate as _KCircularPainter).percentage;
  }
}

class TimerCircular extends StatefulWidget {
  final int maxTimeMs;
  final VoidCallback? onTimeComplete;
  final Widget? onTimeCompleteWidget;
  final Size? size;
  final bool showCurrentTime;

  const TimerCircular(
      {Key? key,
      required this.maxTimeMs,
      this.onTimeComplete,
      this.onTimeCompleteWidget,
      this.size,
      this.showCurrentTime = true})
      : super(key: key);

  @override
  State<TimerCircular> createState() => _TimerCircularState();
}

class _TimerCircularState extends State<TimerCircular> {
  RxInt currentElapsedMs = 0.obs;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      currentElapsedMs.value += 100;
      if (currentElapsedMs >= widget.maxTimeMs) {
        timer.cancel();
        currentElapsedMs.value = widget.maxTimeMs;
        widget.onTimeComplete?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => currentElapsedMs.value == widget.maxTimeMs &&
            widget.onTimeCompleteWidget != null
        ? widget.onTimeCompleteWidget!
        : KCircularWidget(
            size: widget.size,
            percentage: currentElapsedMs.value * 1.0 / widget.maxTimeMs,
            text: widget.showCurrentTime
                ? "${(currentElapsedMs / 1000).toInt()}s"
                : null,
          ));
  }
}
