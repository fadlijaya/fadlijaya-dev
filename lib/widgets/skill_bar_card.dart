import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/models.dart';
import '../theme/app_theme.dart';
import 'glass_card.dart';

/// Satu kartu keahlian: ikon singkatan, nama, persentase, dan bilah
/// kemahiran yang animasi mengisi dari 0% ke nilai akhir.
class SkillBarCard extends StatefulWidget {
  final SkillItem skill;
  final Duration delay;

  const SkillBarCard({super.key, required this.skill, this.delay = Duration.zero});

  @override
  State<SkillBarCard> createState() => _SkillBarCardState();
}

class _SkillBarCardState extends State<SkillBarCard> {
  double _fill = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) setState(() => _fill = widget.skill.percent / 100);
    });
  }

  Color _levelColor(String level) {
    switch (level) {
      case 'Ahli':
        return AppColors.violet;
      case 'Mahir':
        return AppColors.cyanSoft;
      case 'Menengah':
        return AppColors.textDim;
      default:
        return AppColors.textFaint;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: AppColors.cyan.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: AppColors.cyan.withOpacity(0.25)),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  widget.skill.logoAsset,
                  width: 20,
                  height: 20,
                  semanticsLabel: 'Logo ${widget.skill.name}',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.skill.name,
                      style: GoogleFonts.inter(
                        color: AppColors.text,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.skill.levelLabel,
                      style: GoogleFonts.inter(
                        color: _levelColor(widget.skill.levelLabel),
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${widget.skill.percent}%',
                style: GoogleFonts.inter(
                  color: AppColors.textFaint,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              height: 7,
              color: Colors.white.withOpacity(0.06),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: _fill),
                  duration: const Duration(milliseconds: 1100),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return FractionallySizedBox(
                      widthFactor: value,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1AA9C7), AppColors.cyan],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.cyan.withOpacity(0.6),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
