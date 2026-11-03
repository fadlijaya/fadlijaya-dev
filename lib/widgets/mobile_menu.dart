import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

/// Panel menu yang turun di bawah navbar saat hamburger ditekan (mobile).
class MobileMenu extends StatelessWidget {
  final String activeSection;
  final void Function(String sectionId) onNavTap;

  const MobileMenu({
    super.key,
    required this.activeSection,
    required this.onNavTap,
  });

  static const _items = [
    ('home', 'Beranda'),
    ('skills', 'Keahlian'),
    ('projects', 'Proyek'),
    ('contact', 'Kontak'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 26),
      decoration: const BoxDecoration(
        color: Color(0xF5070B12),
        border: Border(bottom: BorderSide(color: AppColors.surfaceBorder)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final item in _items)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: GestureDetector(
                onTap: () => onNavTap(item.$1),
                child: Text(
                  item.$2,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: activeSection == item.$1
                        ? AppColors.cyanSoft
                        : AppColors.textDim,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
