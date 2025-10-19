import 'dart:math' as math;

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _pulse; // halo pulse
  late final AnimationController _float; // gentle float
  late final AnimationController _bg;    // animated gradient
  late final AnimationController _dots;  // loading dots

  @override
  void initState() {
    super.initState();

    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();

    _float = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat(reverse: true);

    _bg = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _dots = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();

    // After a short delay, go to login
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  @override
  void dispose() {
    _pulse.dispose();
    _float.dispose();
    _bg.dispose();
    _dots.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([_bg, _pulse, _float]),
        builder: (context, _) {
          // Animate gradient direction
          final a = math.sin(_bg.value * 2 * math.pi);
          final b = math.cos(_bg.value * 2 * math.pi);

          return Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(a, b),
                end: Alignment(-b, -a),
                colors: const [
                  Color(0xFF2D0B3A), // deep purple
                  Color(0xFF4A1B5E),
                  Color(0xFF111014),
                ],
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Subtle vignette
                Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      radius: 0.9,
                      colors: [
                        Colors.white.withOpacity(0.06),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),

                // Pulsing halo ring behind logo
                CustomPaint(
                  painter: _HaloPainter(
                    progress: _pulse.value,
                    color: const Color(0xFFFF6A00), // SHIFT orange
                  ),
                  size: size,
                ),

                // Floating glass card with logo
                Transform.translate(
                  offset: Offset(0, math.sin(_float.value * math.pi) * -8),
                  child: _GlassCard(child: _LogoWithGlow(pulse: _pulse)),
                ),

                // Loading text + progress
                Positioned(
                  bottom: size.height * 0.12,
                  child: _LoadingDots(controller: _dots),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
//
class _HaloPainter extends CustomPainter {
  _HaloPainter({required this.progress, required this.color});
  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = 90 + progress * 60;

    final p1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12 * (1 - progress)
      ..color = color.withOpacity(0.35 * (1 - progress));
    canvas.drawCircle(center, radius, p1);

    final p2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6 * (1 - progress)
      ..color = color.withOpacity(0.20 * (1 - progress));
    canvas.drawCircle(center, radius + 24, p2);
  }

  @override
  bool shouldRepaint(covariant _HaloPainter old) =>
      old.progress != progress || old.color != color;
}

class _GlassCard extends StatelessWidget {
  const _GlassCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.18), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 30,
            spreadRadius: -4,
            offset: const Offset(0, 18),
          )
        ],
      ),
      child: child,
    );
  }
}


class _LoadingDots extends StatelessWidget {
  const _LoadingDots({required this.controller});
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        final step = (controller.value * 3).floor() % 3; // 0..2
        final dots = ['.', '..', '...'][step];
        return Column(
          children: [
            // progress bar
            Container(
              width: 180,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(100),
              ),
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: controller.value.clamp(0.2, 1.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF9A3C), Color(0xFFFF6A00)],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Loading$dots',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.w600,
                fontSize: 16,
                letterSpacing: 0.6,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _LogoWithGlow extends StatelessWidget {
  const _LogoWithGlow({required this.pulse});
  final AnimationController pulse;

  @override
  Widget build(BuildContext context) {
    final scale = Tween<double>(begin: 0.98, end: 1.03)
        .animate(CurvedAnimation(parent: pulse, curve: Curves.easeInOut));

    return AnimatedBuilder(
      animation: pulse,
      builder: (context, _) {
        return Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF6A00).withOpacity(0.45),
                blurRadius: 45 * scale.value,
                spreadRadius: 2 * scale.value,
              ),
            ],
          ),
          child: Transform.scale(
            scale: scale.value,
            child: Image.asset(
              'assets/logo.png', // <-- put your logo here
              width: 160,
              height: 160,
              filterQuality: FilterQuality.high,
            ),
          ),
        );
      },
    );
  }
}