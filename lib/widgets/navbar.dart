import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'glow_button.dart';

/// Bar navigasi atas: logo, menu (desktop) atau hamburger (mobile),
/// dan tombol "Hubungi Saya". Menyorot menu yang sedang aktif.
class Navbar extends StatelessWidget {
  final bool isMobile;
  final String activeSection;
  final void Function(String sectionId) onNavTap;
  final VoidCallback onHamburgerTap;
  final bool mobileMenuOpen;

  const Navbar({
    super.key,
    required this.isMobile,
    required this.activeSection,
    required this.onNavTap,
    required this.onHamburgerTap,
    required this.mobileMenuOpen,
  });

  static const _items = [
    ('home', 'Beranda'),
    ('skills', 'Keahlian'),
    ('projects', 'Proyek'),
    ('contact', 'Kontak'),
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.background.withOpacity(0.6),
            border: const Border(
              bottom: BorderSide(color: AppColors.surfaceBorder),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                height: 72,
                child: Row(
                  children: [
                    _Logo(onTap: () => onNavTap('home')),
                    const Spacer(),
                    if (!isMobile) ...[
                      for (final item in _items) _NavLink(
                        label: item.$2,
                        active: activeSection == item.$1,
                        onTap: () => onNavTap(item.$1),
                      ),
                      const SizedBox(width: 28),
                      GlowButton(
                        label: 'Hubungi Saya',
                        onPressed: () => onNavTap('contact'),
                      ),
                    ] else
                      _HamburgerIcon(
                        open: mobileMenuOpen,
                        onTap: onHamburgerTap,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onTap;
  const _Logo({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [AppColors.cyan, Color(0xFF5B8CFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cyan.withOpacity(0.45),
                    blurRadius: 18,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Text(
                'FJ',
                style: TextStyle(
                  color: Color(0xFF05121A),
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Fadli Jaya',
              style: GoogleFonts.spaceGrotesk(
                color: AppColors.text,
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final highlighted = widget.active || _hovering;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w500,
                  color: highlighted ? AppColors.text : AppColors.textDim,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: 2,
                width: widget.active ? 18 : 0,
                decoration: BoxDecoration(
                  color: AppColors.cyan,
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cyan.withOpacity(0.7),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HamburgerIcon extends StatelessWidget {
  final bool open;
  final VoidCallback onTap;
  const _HamburgerIcon({required this.open, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.surfaceBorder),
          ),
          alignment: Alignment.center,
          child: Icon(
            open ? Icons.close_rounded : Icons.menu_rounded,
            color: AppColors.text,
            size: 20,
          ),
        ),
      ),
    );
  }
}
