part of 'themes.dart';

//Copy this CustomPainter code to the Bottom of the File
class CheckedCustomPainter extends CustomPainter {
  final BuildContext context;
  final bool isChecked;

  CheckedCustomPainter({required this.context, required this.isChecked});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    paint_0_stroke.color = Theme.of(context).colorScheme.outline;
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(
                size.width * 0.03125000, size.height * 0.03125000, size.width * 0.9375000, size.height * 0.9375000),
            bottomRight: Radius.circular(size.width * 0.2187500),
            bottomLeft: Radius.circular(size.width * 0.2187500),
            topLeft: Radius.circular(size.width * 0.2187500),
            topRight: Radius.circular(size.width * 0.2187500)),
        paint_0_stroke);

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color =
        isChecked ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.secondaryContainer;
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(
                size.width * 0.03125000, size.height * 0.03125000, size.width * 0.9375000, size.height * 0.9375000),
            bottomRight: Radius.circular(size.width * 0.2187500),
            bottomLeft: Radius.circular(size.width * 0.2187500),
            topLeft: Radius.circular(size.width * 0.2187500),
            topRight: Radius.circular(size.width * 0.2187500)),
        paint_0_fill);
    if (!isChecked) return;

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.3125000, size.height * 0.5312500);
    path_1.lineTo(size.width * 0.4687500, size.height * 0.6875000);
    path_1.lineTo(size.width * 0.7187500, size.height * 0.3437500);

    Paint paint_1_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    paint_1_stroke.color = Theme.of(context).colorScheme.outline;
    paint_1_stroke.strokeCap = StrokeCap.round;
    paint_1_stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_1, paint_1_stroke);

    Paint paint_1_fill = Paint()..style = PaintingStyle.stroke;
    paint_1_fill.color = Theme.of(context).colorScheme.secondaryContainer;
    canvas.drawPath(path_1, paint_1_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
