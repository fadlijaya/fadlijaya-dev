import 'package:flutter/material.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import 'project_card.dart';
import 'section_header.dart';

/// Section "Proyek Terpilih": grid kartu proyek, 3 kolom di desktop.
class ProjectsSection extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;

  const ProjectsSection({super.key, required this.isMobile, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: isMobile ? 64 : 90),
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'Portofolio',
            title: 'Proyek Terpilih',
            description:
                'Beberapa aplikasi yang sudah saya rancang dan kembangkan '
                'dari nol hingga rilis publik.',
          ),
          const SizedBox(height: 54),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
            child: LayoutBuilder(
              builder: (context, constraints) {
                const spacing = 22.0;
                final cardWidth =
                    (constraints.maxWidth - spacing * (crossAxisCount - 1)) / crossAxisCount;
                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: [
                    for (final project in PortfolioData.projects)
                      SizedBox(
                        width: cardWidth,
                        child: ProjectCard(project: project),
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
