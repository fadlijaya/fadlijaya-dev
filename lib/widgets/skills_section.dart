import 'package:flutter/material.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import 'section_header.dart';
import 'skill_bar_card.dart';

/// Section "Keterampilan & Teknologi": grid kartu keahlian dengan
/// bilah tingkat kemahiran, 3 kolom di desktop, menyesuaikan di layar kecil.
class SkillsSection extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;

  const SkillsSection({super.key, required this.isMobile, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: isMobile ? 64 : 90),
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'Kemampuan',
            title: 'Keterampilan & Teknologi',
            description:
                'Tools dan bahasa yang saya pakai sehari-hari untuk membangun '
                'aplikasi mobile dan layanan backend-nya.',
          ),
          const SizedBox(height: 54),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
            child: LayoutBuilder(
              builder: (context, constraints) {
                const spacing = 18.0;
                final cardWidth =
                    (constraints.maxWidth - spacing * (crossAxisCount - 1)) / crossAxisCount;
                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: [
                    for (var i = 0; i < PortfolioData.skills.length; i++)
                      SizedBox(
                        width: cardWidth,
                        child: SkillBarCard(
                          skill: PortfolioData.skills[i],
                          delay: Duration(milliseconds: 80 * i),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
