import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import 'glow_button.dart';
import 'hero_background.dart';
import 'social_icon_button.dart';
import 'stat_card.dart';

/// Bagian hero: badge ketersediaan, perkenalan, CTA, sosial media,
/// dan panel statistik.
class HeroSection extends StatelessWidget {
  final bool isMobile;
  final VoidCallback onViewProjects;

  const HeroSection({
    super.key,
    required this.isMobile,
    required this.onViewProjects,
  });

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final headlineSize = isMobile ? 36.0 : 58.0;
    final roleSize = isMobile ? 17.0 : 21.0;

    return Stack(
      children: [
        const Positioned.fill(child: HeroBackground()),
        _HeroContent(
          isMobile: isMobile,
          headlineSize: headlineSize,
          roleSize: roleSize,
          onViewProjects: onViewProjects,
          open: _open,
        ),
      ],
    );
  }
}

class _HeroContent extends StatelessWidget {
  final bool isMobile;
  final double headlineSize;
  final double roleSize;
  final VoidCallback onViewProjects;
  final Future<void> Function(String url) open;

  const _HeroContent({
    required this.isMobile,
    required this.headlineSize,
    required this.roleSize,
    required this.onViewProjects,
    required this.open,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, isMobile ? 140 : 168, 24, isMobile ? 70 : 100),
      child: Column(
        children: [
          // Badge ketersediaan sebagai pekerja lepas
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.cyan.withOpacity(0.08),
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(color: AppColors.cyan.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.success,
                    boxShadow: [
                      BoxShadow(color: AppColors.success.withOpacity(0.7), blurRadius: 8),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Tersedia untuk kerja lepas (freelance)',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.cyanSoft,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 26),

          // Judul: "Halo, saya" biasa + nama bergradasi cyan -> violet
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'Halo, saya ',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: headlineSize,
                  fontWeight: FontWeight.w700,
                  height: 1.08,
                  color: AppColors.text,
                ),
              ),
              _GradientName(fontSize: headlineSize),
            ],
          ),

          const SizedBox(height: 18),
          Text(
            PortfolioData.role,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: roleSize,
              fontWeight: FontWeight.w500,
              color: AppColors.textDim,
            ),
          ),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Text(
              PortfolioData.tagline,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 16,
                height: 1.75,
                color: AppColors.textDim,
              ),
            ),
          ),
          const SizedBox(height: 36),

          // Tombol ajakan bertindak
          Wrap(
            spacing: 16,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              GlowButton(label: 'Lihat Karya Saya', onPressed: onViewProjects),
              GlowButton(
                label: 'Unduh CV',
                style: GlowButtonStyle.ghost,
                icon: Icons.file_download_outlined,
                onPressed: () => open(
                  'https://github.com/fadlijaya/fadlijaya.github.io/raw/master/assets/docs/CV-Fadli-Jaya.pdf',
                ),
              ),
            ],
          ),
          const SizedBox(height: 38),

          // Tautan media sosial
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocialIconButton(
                icon: Icons.code_rounded,
                tooltip: 'GitHub',
                onTap: () => open(PortfolioData.githubUrl),
              ),
              const SizedBox(width: 14),
              SocialIconButton(
                icon: Icons.camera_alt_outlined,
                tooltip: 'Instagram',
                onTap: () => open(PortfolioData.instagramUrl),
              ),
              const SizedBox(width: 14),
              SocialIconButton(
                icon: Icons.business_center_outlined,
                tooltip: 'LinkedIn',
                onTap: () => open(PortfolioData.linkedinUrl),
              ),
              const SizedBox(width: 14),
              SocialIconButton(
                icon: Icons.email_outlined,
                tooltip: 'Email',
                onTap: () => open('mailto:${PortfolioData.email}'),
              ),
            ],
          ),
          const SizedBox(height: 64),

          // Panel statistik
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = isMobile ? 2 : 4;
                const spacing = 18.0;
                final cardWidth =
                    (constraints.maxWidth - spacing * (crossAxisCount - 1)) / crossAxisCount;
                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: [
                    for (var i = 0; i < PortfolioData.stats.length; i++)
                      SizedBox(
                        width: cardWidth,
                        child: StatCard(
                          stat: PortfolioData.stats[i],
                          delay: Duration(milliseconds: 150 * i),
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

class _GradientName extends StatelessWidget {
  final double fontSize;
  const _GradientName({required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [AppColors.cyan, AppColors.violet],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        PortfolioData.name,
        textAlign: TextAlign.center,
        style: GoogleFonts.spaceGrotesk(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          height: 1.08,
          color: Colors.white,
        ),
      ),
    );
  }
}
