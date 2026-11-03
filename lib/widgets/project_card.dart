import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/models.dart';
import '../theme/app_theme.dart';
import 'glass_card.dart';

/// Kartu satu proyek unggulan: gambar + label kategori, judul, deskripsi,
/// tag teknologi, dan tautan (Play Store / App Store / Website).
class ProjectCard extends StatelessWidget {
  final ProjectItem project;

  const ProjectCard({super.key, required this.project});

  Future<void> _open(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 11,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(project.imageAsset, fit: BoxFit.cover),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.background.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppColors.cyan.withOpacity(0.35)),
                    ),
                    child: Text(
                      project.category.toUpperCase(),
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        color: AppColors.cyanSoft,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 22, 22, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.title,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  project.description,
                  style: GoogleFonts.inter(
                    fontSize: 13.6,
                    height: 1.65,
                    color: AppColors.textDim,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final tag in project.tags)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: AppColors.surfaceBorder),
                        ),
                        child: Text(
                          tag,
                          style: GoogleFonts.inter(fontSize: 11.5, color: AppColors.textDim),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 18),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (final link in project.links)
                      _ProjectLinkChip(label: link.label, onTap: () => _open(link.url)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectLinkChip extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _ProjectLinkChip({required this.label, required this.onTap});

  @override
  State<_ProjectLinkChip> createState() => _ProjectLinkChipState();
}

class _ProjectLinkChipState extends State<_ProjectLinkChip> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
          decoration: BoxDecoration(
            color: AppColors.cyan.withOpacity(_hovering ? 0.15 : 0.07),
            borderRadius: BorderRadius.circular(9),
            border: Border.all(color: AppColors.cyan.withOpacity(0.2)),
          ),
          child: Text(
            '${widget.label} →',
            style: GoogleFonts.inter(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: AppColors.cyanSoft,
            ),
          ),
        ),
      ),
    );
  }
}
