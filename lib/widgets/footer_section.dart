import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';

/// Footer: baris copyright tipis di bagian paling bawah halaman.
class FooterSection extends StatelessWidget {
  final bool isMobile;

  const FooterSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;

    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.surfaceBorder)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
          child: Wrap(
            spacing: 12,
            runSpacing: 8,
            alignment: WrapAlignment.spaceBetween,
            children: [
              Text(
                '© $year ${PortfolioData.name}. Seluruh hak cipta dilindungi.',
                style: GoogleFonts.inter(color: AppColors.textFaint, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
