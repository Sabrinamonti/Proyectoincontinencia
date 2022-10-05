import 'package:flutter/material.dart';

class ThermometerWidget extends StatelessWidget {
  final Color borderColor;
  final Color innerColor;
  final Color indicatorColor;
  final Color textColor;
  final double stemWidth;
  final double indicatorBulbWidth;
  final double indicatorStemWidth;
  final double temperature;
  final double width;
  final double height;

  ThermometerWidget(
      {this.borderColor = Colors.blue,
      this.innerColor = Colors.cyanAccent,
      this.indicatorColor = Colors.black,
      this.textColor = Colors.white,
      this.stemWidth = 15.0,
      this.indicatorBulbWidth = 30.0,
      this.indicatorStemWidth = 7.0,
      this.temperature = 60.0,
      this.width = 60.0,
      this.height = 180.0}) {
    assert(height > width, 'height must be greater than width');
    assert(stemWidth < width, 'stemWidth must be less than to width');
  }

  Widget build(BuildContext context) {
    return SizedBox(
      child: CustomPaint(
        painter: ThermometerWidgetPainter(
          borderColor: borderColor,
          innerColor: innerColor,
          indicatorColor: indicatorColor,
          textColor: textColor,
          stemWidth: stemWidth,
          indicatorStemWidth: indicatorStemWidth,
          indicatorBulbWidth: indicatorBulbWidth,
          temperature: temperature,
        ),
      ),
      width: width,
      height: height,
    );
  }
}

class ThermometerWidgetPainter extends CustomPainter {
  final Color borderColor;
  final Color innerColor;
  final Color indicatorColor;
  final Color textColor;

  late Paint borderPaint;
  late Paint innerPaint;
  late Paint indicatorPaint;

  late TextPainter textPainter;
  late TextStyle textStyle;

  late double stemWidth;
  late double temperature;
  late double bulbRadius;
  late double indicatorBulbWidth;
  late double indicatorStemWidth;
  late double minTempHeight;
  late double maxTempHeight;
  late double inset;
  late double tempHeight;

  static const double graduationTickLength = 5.0;

  ThermometerWidgetPainter(
      {required this.borderColor,
      required this.innerColor,
      required this.indicatorColor,
      required this.textColor,
      required this.stemWidth,
      required this.temperature,
      required this.indicatorBulbWidth,
      required this.indicatorStemWidth}) {
    borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    innerPaint = Paint()
      ..color = innerColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    indicatorPaint = Paint()
      ..color = indicatorColor
      ..style = PaintingStyle.fill;

    textPainter = TextPainter()
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center;
  }

  @override
  void paint(Canvas canvas, Size size) {
    bulbRadius = size.width / 2;
    minTempHeight = bulbRadius;
    maxTempHeight = 0.9 * size.height;
    inset = (size.width - stemWidth) / 2;
    tempHeight = temperature / 100 * (maxTempHeight - size.width);

    drawThermometerShape(canvas, size);
    drawIndicatorAndIndicatorText(canvas, size);
    drawGraduations(canvas, size);
  }

  void drawThermometerShape(Canvas canvas, Size size) {
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(inset, 0.0, stemWidth, size.height),
            Radius.circular(10.0)),
        borderPaint);

    canvas.drawCircle(Offset(size.width / 2, size.height - bulbRadius),
        bulbRadius, borderPaint);

    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(inset, 0.0, stemWidth, size.height),
            Radius.circular(10.0)),
        innerPaint);

    canvas.drawCircle(Offset(size.width / 2, size.height - bulbRadius),
        bulbRadius, innerPaint);
  }

  void drawIndicatorAndIndicatorText(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(size.width / 2, size.height - bulbRadius),
        indicatorBulbWidth / 2, indicatorPaint);
    indicatorPaint.style = PaintingStyle.stroke;
    indicatorPaint.strokeWidth = indicatorStemWidth;
    canvas.save();
    canvas.translate(bulbRadius, size.height - bulbRadius);
    canvas.drawLine(Offset.zero, Offset(0.0, -(minTempHeight + tempHeight)),
        indicatorPaint);

    textStyle = TextStyle(
        color: textColor,
        fontFamily: 'Times New Roman',
        fontWeight: FontWeight.bold,
        fontSize: indicatorBulbWidth / 2);

    textPainter.text = TextSpan(
      text: '${temperature.toInt()}',
      style: textStyle,
    );

    textPainter.layout();
    textPainter.paint(
        canvas, Offset(-(textPainter.width / 2), -(textPainter.height / 2)));

    canvas.restore();
  }

  void drawGraduations(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(inset + stemWidth, size.height - size.width);
    double markPoint = 0;
    for (int i = 1; i <= 5; i++) {
      canvas.drawLine(
          Offset.zero, Offset(graduationTickLength, 0.0), borderPaint);
      canvas.save();
      canvas.translate(graduationTickLength, 0.0);
      textStyle = TextStyle(
          color: borderColor,
          fontFamily: 'Calibri',
          fontSize: indicatorBulbWidth / 2);
      textPainter.text = TextSpan(
        text: '$markPoint°',
        style: textStyle,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(0.0, -(textPainter.height / 2)));
      canvas.restore();
      canvas.translate(0.0, -0.25 * (maxTempHeight - size.width));
      markPoint += (80 / 4);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(ThermometerWidgetPainter oldDelegate) {
    return true;
  }
}
