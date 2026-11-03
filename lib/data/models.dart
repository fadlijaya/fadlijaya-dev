/// Model data untuk satu baris keahlian pada grid Skills.
class SkillItem {
  final String name;
  final String logoAsset;
  final int percent;

  const SkillItem({
    required this.name,
    required this.logoAsset,
    required this.percent,
  });

  /// Label tingkat kemahiran berdasarkan persentase keahlian.
  String get levelLabel {
    if (percent >= 90) return 'Ahli';
    if (percent >= 75) return 'Mahir';
    if (percent >= 60) return 'Menengah';
    return 'Pemula';
  }
}

/// Model data untuk satu tautan eksternal (Play Store, App Store, Website, dst).
class ProjectLink {
  final String label;
  final String url;

  const ProjectLink({required this.label, required this.url});
}

/// Model data untuk satu kartu di Featured Projects.
class ProjectItem {
  final String title;
  final String category;
  final String description;
  final String imageAsset;
  final List<String> tags;
  final List<ProjectLink> links;

  const ProjectItem({
    required this.title,
    required this.category,
    required this.description,
    required this.imageAsset,
    required this.tags,
    required this.links,
  });
}

/// Model data untuk satu angka pada panel statistik hero.
class StatItem {
  final int value;
  final String suffix;
  final String label;

  const StatItem({
    required this.value,
    required this.suffix,
    required this.label,
  });
}
