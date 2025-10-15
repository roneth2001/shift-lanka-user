import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedSriLankaLion extends StatefulWidget {
  final Color strokeColor;
  final double strokeWidth;
  final Duration animationDuration;

  const AnimatedSriLankaLion({
    Key? key,
    this.strokeColor = Colors.white,
    this.strokeWidth = 2.5,
    this.animationDuration = const Duration(seconds: 6),
  }) : super(key: key);

  @override
  State<AnimatedSriLankaLion> createState() => _AnimatedSriLankaLionState();
}

class _AnimatedSriLankaLionState extends State<AnimatedSriLankaLion>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Start animation and loop it
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: SriLankaLionPainter(
            progress: _animation.value,
            strokeColor: widget.strokeColor,
            strokeWidth: widget.strokeWidth,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class SriLankaLionPainter extends CustomPainter {
  final double progress;
  final Color strokeColor;
  final double strokeWidth;

  SriLankaLionPainter({
    required this.progress,
    required this.strokeColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = strokeColor.withOpacity(0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Center and scale
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final scale = math.min(size.width, size.height) * 0.35;

    final path = Path();

    // Start from sword handle (top left)
    path.moveTo(centerX + (-0.9 * scale), centerY + (-0.85 * scale));

    // Sword handle
    path.lineTo(centerX + (-0.85 * scale), centerY + (-0.75 * scale));
    
    // Sword blade
    path.lineTo(centerX + (-0.75 * scale), centerY + (-0.95 * scale));
    path.lineTo(centerX + (-0.65 * scale), centerY + (-1.0 * scale));
    path.lineTo(centerX + (-0.55 * scale), centerY + (-0.9 * scale));
    path.lineTo(centerX + (-0.65 * scale), centerY + (-0.75 * scale));

    // Lion's head top (mane flowing)
    path.cubicTo(
      centerX + (-0.5 * scale), centerY + (-0.85 * scale),
      centerX + (-0.3 * scale), centerY + (-0.95 * scale),
      centerX + (-0.1 * scale), centerY + (-0.9 * scale),
    );

    // Top of mane (wavy)
    path.cubicTo(
      centerX + (0.05 * scale), centerY + (-0.92 * scale),
      centerX + (0.15 * scale), centerY + (-0.88 * scale),
      centerX + (0.25 * scale), centerY + (-0.85 * scale),
    );

    path.cubicTo(
      centerX + (0.35 * scale), centerY + (-0.82 * scale),
      centerX + (0.45 * scale), centerY + (-0.85 * scale),
      centerX + (0.55 * scale), centerY + (-0.8 * scale),
    );

    // Right side of mane flowing down
    path.cubicTo(
      centerX + (0.6 * scale), centerY + (-0.75 * scale),
      centerX + (0.65 * scale), centerY + (-0.65 * scale),
      centerX + (0.7 * scale), centerY + (-0.5 * scale),
    );

    // Face/snout right side
    path.cubicTo(
      centerX + (0.75 * scale), centerY + (-0.35 * scale),
      centerX + (0.8 * scale), centerY + (-0.2 * scale),
      centerX + (0.85 * scale), centerY + (-0.05 * scale),
    );

    // Mouth/jaw area
    path.cubicTo(
      centerX + (0.9 * scale), centerY + (0.05 * scale),
      centerX + (0.95 * scale), centerY + (0.15 * scale),
      centerX + (0.95 * scale), centerY + (0.25 * scale),
    );

    // Tongue/lower jaw
    path.cubicTo(
      centerX + (0.93 * scale), centerY + (0.35 * scale),
      centerX + (0.85 * scale), centerY + (0.4 * scale),
      centerX + (0.75 * scale), centerY + (0.35 * scale),
    );

    // Chest area
    path.cubicTo(
      centerX + (0.65 * scale), centerY + (0.3 * scale),
      centerX + (0.55 * scale), centerY + (0.25 * scale),
      centerX + (0.45 * scale), centerY + (0.3 * scale),
    );

    // Front right leg
    path.lineTo(centerX + (0.4 * scale), centerY + (0.6 * scale));
    path.lineTo(centerX + (0.42 * scale), centerY + (0.8 * scale));
    path.lineTo(centerX + (0.45 * scale), centerY + (0.95 * scale));

    // Paw
    path.lineTo(centerX + (0.35 * scale), centerY + (0.98 * scale));
    path.lineTo(centerX + (0.3 * scale), centerY + (0.95 * scale));
    path.lineTo(centerX + (0.28 * scale), centerY + (0.85 * scale));

    // Belly
    path.cubicTo(
      centerX + (0.2 * scale), centerY + (0.75 * scale),
      centerX + (0.1 * scale), centerY + (0.7 * scale),
      centerX + (0.0 * scale), centerY + (0.72 * scale),
    );

    path.cubicTo(
      centerX + (-0.1 * scale), centerY + (0.74 * scale),
      centerX + (-0.2 * scale), centerY + (0.75 * scale),
      centerX + (-0.3 * scale), centerY + (0.78 * scale),
    );

    // Back right leg
    path.lineTo(centerX + (-0.32 * scale), centerY + (0.9 * scale));
    path.lineTo(centerX + (-0.3 * scale), centerY + (0.98 * scale));
    path.lineTo(centerX + (-0.4 * scale), centerY + (1.0 * scale));
    path.lineTo(centerX + (-0.45 * scale), centerY + (0.95 * scale));
    path.lineTo(centerX + (-0.42 * scale), centerY + (0.85 * scale));

    // Back area
    path.cubicTo(
      centerX + (-0.48 * scale), centerY + (0.7 * scale),
      centerX + (-0.52 * scale), centerY + (0.55 * scale),
      centerX + (-0.55 * scale), centerY + (0.4 * scale),
    );

    // Back left leg
    path.lineTo(centerX + (-0.6 * scale), centerY + (0.6 * scale));
    path.lineTo(centerX + (-0.62 * scale), centerY + (0.85 * scale));
    path.lineTo(centerX + (-0.6 * scale), centerY + (0.98 * scale));
    path.lineTo(centerX + (-0.7 * scale), centerY + (1.0 * scale));
    path.lineTo(centerX + (-0.75 * scale), centerY + (0.95 * scale));
    path.lineTo(centerX + (-0.72 * scale), centerY + (0.8 * scale));

    // Hindquarters
    path.cubicTo(
      centerX + (-0.78 * scale), centerY + (0.6 * scale),
      centerX + (-0.82 * scale), centerY + (0.4 * scale),
      centerX + (-0.85 * scale), centerY + (0.2 * scale),
    );

    // Back curve
    path.cubicTo(
      centerX + (-0.88 * scale), centerY + (0.0 * scale),
      centerX + (-0.9 * scale), centerY + (-0.2 * scale),
      centerX + (-0.88 * scale), centerY + (-0.4 * scale),
    );

    // Mane/neck left side
    path.cubicTo(
      centerX + (-0.85 * scale), centerY + (-0.55 * scale),
      centerX + (-0.88 * scale), centerY + (-0.7 * scale),
      centerX + (-0.9 * scale), centerY + (-0.85 * scale),
    );

    // Create path metric to draw progressively
    final pathMetrics = path.computeMetrics();
    if (pathMetrics.isNotEmpty) {
      final pathMetric = pathMetrics.first;
      final extractPath = pathMetric.extractPath(
        0.0,
        pathMetric.length * progress,
      );

      canvas.drawPath(extractPath, paint);

      // Draw a glowing dot at the end of the line
      if (progress > 0.0 && progress < 1.0) {
        final endPoint = pathMetric.getTangentForOffset(
          pathMetric.length * progress,
        )?.position;

        if (endPoint != null) {
          // Outer glow
          final glowPaint = Paint()
            ..color = strokeColor.withOpacity(0.2)
            ..style = PaintingStyle.fill;
          canvas.drawCircle(endPoint, 5.0, glowPaint);

          // Inner dot
          final dotPaint = Paint()
            ..color = strokeColor.withOpacity(0.7)
            ..style = PaintingStyle.fill;
          canvas.drawCircle(endPoint, 2.5, dotPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(SriLankaLionPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// Example usage in login screen
class LoginScreenWithLion extends StatelessWidget {
  const LoginScreenWithLion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4A148C),
              Color(0xFF5E35B1),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Animated Lion Background
            Positioned.fill(
              child: AnimatedSriLankaLion(
                strokeColor: Colors.white,
                strokeWidth: 2.5,
                animationDuration: const Duration(seconds: 6),
              ),
            ),
            
            // Your content goes here
            Center(
              child: Text(
                'Shift Lanka',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}