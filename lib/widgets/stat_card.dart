import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/models.dart';
import '../theme/app_theme.dart';
import 'glass_card.dart';

/// Satu kartu statistik di panel hero, dengan angka yang animasi "menghitung
/// naik" dari 0 menuju nilai akhir saat kartu pertama kali tampil.
class StatCard extends StatefulWidget {
  final StatItem stat;
  final Duration delay;

  const StatCard({super.key, required this.stat, this.delay = Duration.zero});

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard> {
  int _value = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) setState(() => _value = widget.stat.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 10),
      child: Column(
        children: [
          TweenAnimationBuilder<int>(
            tween: IntTween(begin: 0, end: _value),
            duration: const Duration(milliseconds: 1100),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$value',
                      style: GoogleFonts.spaceGrotesk(
                        color: AppColors.text,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: widget.stat.suffix,
                      style: GoogleFonts.spaceGrotesk(
                        color: AppColors.cyanSoft,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 6),
          Text(
            widget.stat.label.toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: AppColors.textFaint,
              fontSize: 12.5,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
