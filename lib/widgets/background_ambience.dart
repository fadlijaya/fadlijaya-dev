import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Lapisan dekoratif di belakang seluruh halaman: beberapa radial glow
/// cyan/violet lembut, menyerupai aksen "glowing cyan" pada versi web.
class BackgroundAmbience extends StatelessWidget {
  const BackgroundAmbience({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        color: AppColors.background,
        child: Stack(
          children: [
            _glow(top: -140, left: -120, size: 480, color: AppColors.cyan, opacity: 0.16),
            _glow(top: 40, right: -160, size: 420, color: AppColors.violet, opacity: 0.14),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: _glow(bottom: -260, size: 620, color: AppColors.cyan, opacity: 0.08, standalone: true),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glow({
    double? top,
    double? left,
    double? right,
    double? bottom,
    required double size,
    required Color color,
    required double opacity,
    bool standalone = false,
  }) {
    final blob = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withOpacity(opacity), color.withOpacity(0)],
        ),
      ),
    );
    if (standalone) return blob;
    return Positioned(top: top, left: left, right: right, bottom: bottom, child: blob);
  }
}
