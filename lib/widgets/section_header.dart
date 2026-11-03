import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

/// Header judul section: eyebrow kecil + judul besar + deskripsi singkat,
/// rata tengah, dipakai ulang di tiap section (Skills, Projects, dst).
class SectionHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String description;

  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final titleSize = width < AppBreakpoints.mobile ? 26.0 : 36.0;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 620),
        child: Column(
          children: [
            Text(
              eyebrow.toUpperCase(),
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: AppColors.cyanSoft,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.spaceGrotesk(
                color: AppColors.text,
                fontSize: titleSize,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: AppColors.textDim,
                fontSize: 15,
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
