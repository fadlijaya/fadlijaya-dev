import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import 'glass_card.dart';
import 'glow_button.dart';

/// Spanduk kontak dengan ajakan "Mari kita ciptakan sesuatu yang luar
/// biasa bersama-sama" dan info kontak langsung.
class ContactSection extends StatelessWidget {
  final bool isMobile;

  const ContactSection({super.key, required this.isMobile});

  Future<void> _open(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 24, vertical: isMobile ? 64 : 90),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
          child: SizedBox(
            width: double.infinity,
            child: GlassCard(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 36,
                vertical: isMobile ? 48 : 56,
              ),
              hoverGlow: false,
              child: Column(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: Text(
                      'Mari kita ciptakan sesuatu yang luar biasa bersama-sama',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: isMobile ? 24 : 36,
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                        color: AppColors.text,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: Text(
                      'Punya ide aplikasi atau butuh engineer mobile untuk proyek '
                      'Anda? Saya terbuka untuk kolaborasi, proyek lepas, maupun '
                      'kerja sama jangka panjang.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 15.5,
                        color: AppColors.textDim,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Wrap(
                    spacing: 16,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      GlowButton(
                        label: 'Kirim Email',
                        onPressed: () => _open('mailto:${PortfolioData.email}'),
                      ),
                      GlowButton(
                        label: 'Hubungkan di LinkedIn',
                        style: GlowButtonStyle.ghost,
                        onPressed: () => _open(PortfolioData.linkedinUrl),
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),
                  Wrap(
                    spacing: 28,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: [
                      _ContactMeta(
                          text: PortfolioData.email,
                          onTap: () => _open('mailto:${PortfolioData.email}')),
                      _ContactMeta(
                          text: PortfolioData.phoneDisplay,
                          onTap: () => _open('tel:${PortfolioData.phoneUri}')),
                      const _ContactMeta(text: PortfolioData.location),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ContactMeta extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  const _ContactMeta({required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    final style = GoogleFonts.inter(fontSize: 13.5, color: AppColors.textFaint);
    if (onTap == null) return Text(text, style: style);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Text(text, style: style.copyWith(color: AppColors.textDim)),
      ),
    );
  }
}
