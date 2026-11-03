import 'models.dart';

/// Semua data konten portofolio dikumpulkan di satu tempat supaya
/// mudah diedit tanpa menyentuh kode widget.
class PortfolioData {
  PortfolioData._();

  static const String name = 'Fadli Jaya';
  static const String role = 'Mobile Engineer — spesialis Flutter & Kotlin';
  static const String tagline =
      'Membangun aplikasi mobile yang rapi, cepat, dan reliable untuk '
      'pendidikan, kesehatan, dan e-commerce — dari integrasi API hingga '
      'rilis ke Play Store & App Store. Berbasis di Makassar, bekerja '
      'dengan tim maupun klien lepas di seluruh Indonesia.';
  static const String location = 'Makassar, Indonesia';
  static const String email = 'jaya.fadly@gmail.com';
  static const String phoneDisplay = '+62 895-8006-67392';
  static const String phoneUri = '+62895800667392';

  static const String githubUrl = 'https://github.com/fadlijaya';
  static const String instagramUrl = 'https://www.instagram.com/_fadlijaya/';
  static const String linkedinUrl = 'https://www.linkedin.com/in/fadlijaya/';

  static const List<StatItem> stats = [
    StatItem(value: 5, suffix: '+', label: 'Tahun Pengalaman'),
    StatItem(value: 20, suffix: '+', label: 'Proyek Rilis'),
    StatItem(value: 15, suffix: '+', label: 'Klien Puas'),
    StatItem(value: 98, suffix: '%', label: 'Tingkat Keberhasilan'),
  ];

  static const List<SkillItem> skills = [
    SkillItem(name: 'Flutter', logoAsset: 'assets/images/skills/flutter.svg', percent: 95),
    SkillItem(name: 'Kotlin', logoAsset: 'assets/images/skills/kotlin.svg', percent: 85),
    SkillItem(name: 'Java', logoAsset: 'assets/images/skills/java.svg', percent: 85),
    SkillItem(name: 'React', logoAsset: 'assets/images/skills/react.svg', percent: 75),
    SkillItem(name: 'Firebase', logoAsset: 'assets/images/skills/firebase.svg', percent: 90),
    SkillItem(name: 'Supabase', logoAsset: 'assets/images/skills/supabase.svg', percent: 80),
    SkillItem(name: 'Laravel', logoAsset: 'assets/images/skills/laravel.svg', percent: 75),
    SkillItem(name: 'TypeScript', logoAsset: 'assets/images/skills/typescript.svg', percent: 75),
    SkillItem(name: 'Node.js', logoAsset: 'assets/images/skills/nodejs.svg', percent: 70),
  ];

  static const List<ProjectItem> projects = [
    ProjectItem(
      title: 'E-ANDALAN: Smart School',
      category: 'Aplikasi Pendidikan',
      description:
          'Ekosistem aplikasi pelayanan pendidikan dan pembelajaran '
          'terintegrasi untuk sekolah.',
      imageAsset: 'assets/images/portfolio/portfolio-app-01.png',
      tags: ['Flutter', 'Firebase', 'REST API'],
      links: [
        ProjectLink(
          label: 'Play Store',
          url:
              'https://play.google.com/store/apps/details?id=com.sekolahandalan.smartschool',
        ),
        ProjectLink(
          label: 'Website',
          url: 'https://smartschooldisdik.sulselprov.go.id/',
        ),
      ],
    ),
    ProjectItem(
      title: 'AOS — Aruna Official Store',
      category: 'E-Commerce',
      description:
          'Aplikasi e-commerce distributor perangkat jaringan & komputer, '
          'lengkap dengan katalog dan transaksi.',
      imageAsset: 'assets/images/portfolio/portfolio-app-02.png',
      tags: ['Flutter', 'Laravel', 'Payment Gateway'],
      links: [
        ProjectLink(
          label: 'Play Store',
          url:
              'https://play.google.com/store/apps/details?id=com.arunaofficial.store',
        ),
        ProjectLink(
          label: 'App Store',
          url:
              'https://apps.apple.com/id/app/aos-aruna-official-store/id6743793903?l=id',
        ),
      ],
    ),
    ProjectItem(
      title: 'Sikolata',
      category: 'Aplikasi Pendidikan',
      description:
          'Platform pembelajaran live streaming untuk siswa SD & SMP di '
          'Kabupaten Takalar, lengkap dengan classroom & learning resources.',
      imageAsset: 'assets/images/portfolio/portfolio-app-05.png',
      tags: ['Flutter', 'Live Streaming', 'Firebase'],
      links: [
        ProjectLink(
          label: 'Play Store',
          url:
              'https://play.google.com/store/apps/details?id=com.pemkabtakalar.sikolata',
        ),
      ],
    ),
    ProjectItem(
      title: 'KakaDokter',
      category: 'Kesehatan',
      description:
          'Konsultasi kesehatan online dengan dokter berlisensi, resep '
          'digital, dan manajemen informasi kesehatan dasar.',
      imageAsset: 'assets/images/portfolio/portfolio-app-04.png',
      tags: ['Flutter', 'Node.js', 'REST API'],
      links: [
        ProjectLink(
          label: 'Play Store',
          url:
              'https://play.google.com/store/apps/details?id=com.fadevstudio.kakadokter',
        ),
      ],
    ),
    ProjectItem(
      title: 'Mobile Ewaki — Pemkab Takalar',
      category: 'Pemerintahan',
      description:
          'Aplikasi evaluasi dan pengawasan kinerja Pemerintah Kabupaten '
          'Takalar untuk mendukung transparansi birokrasi.',
      imageAsset: 'assets/images/portfolio/portfolio-app-03.png',
      tags: ['Flutter', 'Laravel', 'Dashboard'],
      links: [
        ProjectLink(
          label: 'Play Store',
          url: 'https://play.google.com/store/apps/details?id=com.mobileewaki',
        ),
        ProjectLink(
          label: 'Website',
          url: 'https://ewaki.takalarkab.go.id',
        ),
      ],
    ),
    ProjectItem(
      title: 'Fatimah Motor',
      category: 'Otomotif & Bisnis',
      description:
          'Aplikasi manajemen jual-beli mobil bekas — kelola pembelian, '
          'perbaikan, dan penjualan unit dengan perhitungan keuntungan otomatis.',
      imageAsset: 'assets/images/portfolio/portfolio-app-06.png',
      tags: ['Flutter', 'Firebase', 'REST API'],
      links: [
        ProjectLink(
          label: 'Play Store',
          url:
              'https://play.google.com/store/apps/details?id=com.fadev.fatimahmotor&hl=id',
        ),
        ProjectLink(
          label: 'Website',
          url: 'https://fatimahmotor.com',
        ),
      ],
    ),
  ];
}
