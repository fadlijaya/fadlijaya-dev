import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'widgets/background_ambience.dart';
import 'widgets/contact_section.dart';
import 'widgets/footer_section.dart';
import 'widgets/hero_section.dart';
import 'widgets/mobile_menu.dart';
import 'widgets/navbar.dart';
import 'widgets/projects_section.dart';
import 'widgets/skills_section.dart';
import 'widgets/back_to_top_button.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fadli Jaya — Mobile Engineer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.background,
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  String _activeSection = 'home';
  bool _showBackToTop = false;
  bool _mobileMenuOpen = false;

  static const double _navHeight = 72;

  Map<String, GlobalKey> get _sectionKeys => {
        'home': _homeKey,
        'skills': _skillsKey,
        'projects': _projectsKey,
        'contact': _contactKey,
      };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    final showTop = _scrollController.offset > 500;
    if (showTop != _showBackToTop) {
      setState(() => _showBackToTop = showTop);
    }

    String current = _activeSection;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 2) {
      // Sudah mentok di bawah (footer sekarang tipis): section terakhir
      // bisa saja tidak pernah melewati batas navbar, jadi paksa aktif.
      current = 'contact';
    } else {
      double bestDy = double.negativeInfinity;
      _sectionKeys.forEach((id, key) {
        final ctx = key.currentContext;
        if (ctx == null) return;
        final box = ctx.findRenderObject() as RenderBox?;
        if (box == null || !box.attached) return;
        final dy = box.localToGlobal(Offset.zero).dy;
        // Pilih section terakhir yang sudah melewati batas bawah navbar.
        if (dy <= _navHeight + 80 && dy > bestDy) {
          bestDy = dy;
          current = id;
        }
      });
    }
    if (current != _activeSection) {
      setState(() => _activeSection = current);
    }
  }

  void _scrollToSection(String id) {
    setState(() => _mobileMenuOpen = false);
    final ctx = _sectionKeys[id]?.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      alignment: 0,
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < AppBreakpoints.mobile;
    final isTablet = width >= AppBreakpoints.mobile && width < AppBreakpoints.tablet;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const Positioned.fill(child: BackgroundAmbience()),
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Spacer agar konten pertama tidak tertutup navbar fixed.
                Container(
                  key: _homeKey,
                  child: HeroSection(
                    isMobile: isMobile,
                    onViewProjects: () => _scrollToSection('projects'),
                  ),
                ),
                Container(
                  key: _skillsKey,
                  child: SkillsSection(isMobile: isMobile, isTablet: isTablet),
                ),
                Container(
                  key: _projectsKey,
                  child: ProjectsSection(isMobile: isMobile, isTablet: isTablet),
                ),
                Container(
                  key: _contactKey,
                  child: ContactSection(isMobile: isMobile),
                ),
                FooterSection(isMobile: isMobile),
              ],
            ),
          ),
          // Navbar fixed di atas, plus dropdown menu mobile di bawahnya.
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Navbar(
                  isMobile: isMobile,
                  activeSection: _activeSection,
                  onNavTap: _scrollToSection,
                  mobileMenuOpen: _mobileMenuOpen,
                  onHamburgerTap: () => setState(() => _mobileMenuOpen = !_mobileMenuOpen),
                ),
                if (isMobile && _mobileMenuOpen)
                  MobileMenu(activeSection: _activeSection, onNavTap: _scrollToSection),
              ],
            ),
          ),
          Positioned(
            bottom: 28,
            right: 24,
            child: BackToTopButton(visible: _showBackToTop, onTap: _scrollToTop),
          ),
        ],
      ),
    );
  }
}
