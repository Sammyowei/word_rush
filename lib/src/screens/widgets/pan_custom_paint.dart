import 'package:flutter/material.dart';
import 'package:word_rush/src/src.dart';

class WordCookiePainter extends CustomPainter {
  WordCookiePainter({required this.letters});

  final List<String> letters;
  @override
  void paint(Canvas canvas, Size size) {
    // Define colors and paint styles
    Paint cookiePaint = Paint()..color = Colors.brown;

    // Create a radial gradient for the cookie base (pan)
    Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );
    Gradient gradient = RadialGradient(
      colors: [Colors.brown[300]!, Colors.brown[600]!],
      stops: [0.4, 1.0],
    );

    Paint gradientPaint = Paint()..shader = gradient.createShader(rect);

    // Draw the circular cookie base with gradient
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      gradientPaint,
    );

    // Define positions for word tiles
    List<Offset> tilePositions = [
      Offset(size.width / 2 + 90, size.height / 2 - 20),
      Offset(size.width / 2 - 5, size.height / 2 - 90),
      Offset(size.width / 2 - 90, size.height / 2 - 20),
      Offset(size.width / 2 + 55, size.height / 2 + 70),
      Offset(size.width / 2 - 55, size.height / 2 + 70),
    ];

    // Paint each word tile
    Paint tilePaint = Paint()..color = Palette().btnColor;
    for (int i = 0; i < tilePositions.length; i++) {
      canvas.drawRect(
        Rect.fromCircle(
          center: tilePositions[i],
          radius: 25,
        ),
        tilePaint,
      );

      // Text on the tiles
      TextPainter(
        text: TextSpan(
          text: letters[i],
          style: TextStyle(
              color: Colors.white, fontFamily: 'Guava Candy', fontSize: 25),
        ),
        textDirection: TextDirection.ltr,
      )
        ..layout(
          minWidth: 0,
          maxWidth: size.width,
        )
        ..paint(
            canvas, tilePositions[i] - Offset(5, 10)); // Adjust text position
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
