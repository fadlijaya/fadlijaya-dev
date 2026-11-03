import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Latar belakang panel hero: lapisan partikel & ikon teknologi yang
/// melayang pelan. Padanan kode dari animasi CSS pada kanvas desain
/// "Hero Header Background — Foto Profil & Animasi Teknologi".
class HeroBackground extends StatefulWidget {
  const HeroBackground({super.key});

  @override
  State<HeroBackground> createState() => _HeroBackgroundState();
}

class _HeroBackgroundState extends State<HeroBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        fit: StackFit.expand,
        children: [
          _TechParticlesLayer(controller: _controller),
        ],
      ),
    );
  }
}

class _Particle {
  final double fx;
  final double fy;
  final double radius;
  final double phase;
  final Color color;

  const _Particle(this.fx, this.fy, this.radius, this.phase, this.color);
}

const List<_Particle> _particles = [
  _Particle(0.172, 0.184, 3, 0.00, AppColors.cyan),
  _Particle(0.328, 0.306, 2.5, 0.08, AppColors.cyan),
  _Particle(0.672, 0.224, 2.5, 0.18, AppColors.cyan),
  _Particle(0.797, 0.347, 3, 0.26, AppColors.violet),
  _Particle(0.234, 0.633, 2.5, 0.10, AppColors.cyan),
  _Particle(0.375, 0.531, 2, 0.36, AppColors.cyan),
  _Particle(0.609, 0.653, 3, 0.20, AppColors.violet),
  _Particle(0.75, 0.571, 2, 0.42, AppColors.cyan),
  _Particle(0.109, 0.429, 2, 0.14, AppColors.cyan),
  _Particle(0.875, 0.469, 2.5, 0.30, AppColors.cyan),
];

// Pasangan indeks partikel yang dihubungkan garis tipis berdenyut.
const List<List<int>> _particleLines = [
  [0, 1],
  [2, 3],
  [4, 5],
  [6, 7],
];

/// Lapisan "sentuhan teknologi": partikel melayang + garis penghubung
/// yang berdenyut, plus beberapa chip ikon teknologi yang mengambang —
/// padanan kode dari animasi GIF/CSS pada kanvas desain.
class _TechParticlesLayer extends StatelessWidget {
  final AnimationController controller;

  const _TechParticlesLayer({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return CustomPaint(
              painter: _ParticlesPainter(t: controller.value),
              size: Size.infinite,
            );
          },
        ),
        _TechChip(
          alignment: const Alignment(-0.734, -0.616),
          icon: Icons.code_rounded,
          iconColor: AppColors.cyanSoft,
          background: AppColors.cyan.withOpacity(0.07),
          border: AppColors.cyan.withOpacity(0.25),
          phase: 0.05,
          controller: controller,
        ),
        _TechChip(
          alignment: const Alignment(0.703, -0.429),
          icon: Icons.terminal_rounded,
          iconColor: const Color(0xFFC3B2FF),
          background: AppColors.violet.withOpacity(0.08),
          border: AppColors.violet.withOpacity(0.28),
          phase: 0.45,
          controller: controller,
        ),
        _TechChip(
          alignment: const Alignment(-0.656, 0.347),
          icon: Icons.memory_rounded,
          iconColor: AppColors.cyanSoft,
          background: AppColors.cyan.withOpacity(0.07),
          border: AppColors.cyan.withOpacity(0.25),
          phase: 0.25,
          controller: controller,
        ),
      ],
    );
  }
}

class _TechChip extends StatelessWidget {
  final Alignment alignment;
  final IconData icon;
  final Color iconColor;
  final Color background;
  final Color border;
  final double phase;
  final AnimationController controller;

  const _TechChip({
    required this.alignment,
    required this.icon,
    required this.iconColor,
    required this.background,
    required this.border,
    required this.phase,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final dy = math.sin((controller.value + phase) * 2 * math.pi) * 10;
          return Transform.translate(offset: Offset(0, dy), child: child);
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: border),
          ),
          child: Icon(icon, size: 18, color: iconColor),
        ),
      ),
    );
  }
}

class _ParticlesPainter extends CustomPainter {
  final double t;

  _ParticlesPainter({required this.t});

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()..strokeWidth = 1;
    for (final pair in _particleLines) {
      final a = _particles[pair[0]];
      final b = _particles[pair[1]];
      final wave = math.sin((t + a.phase) * 2 * math.pi);
      final opacity = (0.08 + 0.32 * (0.5 + 0.5 * wave)).clamp(0.0, 1.0);
      linePaint.color = a.color.withOpacity(opacity);
      canvas.drawLine(
        Offset(a.fx * size.width, a.fy * size.height),
        Offset(b.fx * size.width, b.fy * size.height),
        linePaint,
      );
    }

    final dotPaint = Paint();
    for (final p in _particles) {
      final wave = math.sin((t + p.phase) * 2 * math.pi);
      final opacity = (0.25 + 0.55 * (0.5 + 0.5 * wave)).clamp(0.0, 1.0);
      final dy = wave * 6;
      dotPaint.color = p.color.withOpacity(opacity);
      canvas.drawCircle(
        Offset(p.fx * size.width, p.fy * size.height + dy),
        p.radius,
        dotPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlesPainter oldDelegate) =>
      oldDelegate.t != t;
}
