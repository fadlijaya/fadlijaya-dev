# Fadli Jaya — Portfolio (Flutter)

Versi Flutter dari website portofolio, dibangun ulang sebagai widget Dart
(bukan sekadar membungkus HTML) dengan tema gelap, aksen cyan bercahaya,
dan kartu glassmorphism. Target utamanya adalah **Flutter Web**, tapi
karena ditulis dengan `Widget` biasa, project ini juga bisa dijalankan
sebagai aplikasi Android/iOS tanpa perubahan berarti.

## ⚠️ Penting — dibuat tanpa Flutter SDK

Kode ini ditulis manual (bukan hasil `flutter create` + run) karena
sandbox tempat saya bekerja tidak memiliki Flutter SDK terpasang dan
tidak bisa mengunduhnya (domain `storage.googleapis.com` diblokir oleh
proxy jaringan sandbox). Artinya:

- Saya **belum** menjalankan `flutter pub get`, `flutter analyze`, atau
  `flutter run` untuk memverifikasi project ini.
- Struktur folder, nama API, dan sintaks sudah saya tulis seteliti
  mungkin sesuai Flutter SDK stabil terbaru, tapi tetap **cek dengan
  `flutter analyze` di komputer kamu** sebelum dipakai serius.
- Folder `android/`, `ios/`, `web/`, dll **belum ada** — lihat langkah 1
  di bawah untuk men-generate-nya.

## Struktur project

```
lib/
  main.dart                   # entry point + layout halaman & scroll-spy
  theme/app_theme.dart        # warna, breakpoint, radius
  data/
    models.dart                # model Skill, Project, Stat
    portfolio_data.dart        # SEMUA konten teks/data ada di sini
  widgets/
    navbar.dart                 # bar navigasi + highlight menu aktif
    mobile_menu.dart            # dropdown menu untuk layar kecil
    hero_section.dart           # perkenalan, CTA, sosial, stat panel
    stat_card.dart              # kartu angka statistik (animasi hitung naik)
    skills_section.dart         # grid Keterampilan & Teknologi
    skill_bar_card.dart         # kartu 1 skill + bilah kemahiran animasi
    projects_section.dart       # grid Proyek Terpilih
    project_card.dart           # kartu 1 proyek + tag + tautan toko aplikasi
    contact_section.dart        # spanduk kontak
    footer_section.dart         # footer + navigasi + sosial
    back_to_top_button.dart     # tombol kembali ke atas
    background_ambience.dart    # glow radial dekoratif di belakang halaman
    glass_card.dart             # kartu glassmorphism dasar (dipakai di semua section)
    glow_button.dart            # tombol CTA primary/ghost
    social_icon_button.dart     # ikon sosial bundar
    section_header.dart         # judul section (eyebrow + title + deskripsi)
assets/
  images/
    photos/profil.jpg
    portfolio/portfolio-app-0X.png
    favicons.png
```

Semua teks, link, dan data proyek ada di satu file:
`lib/data/portfolio_data.dart` — edit di situ saja kalau mau mengubah isi,
tidak perlu menyentuh file widget.

## Cara menjalankan

1. **Generate folder platform** (android/ios/web/dll belum disertakan di
   sini). Di dalam folder project, jalankan:
   ```bash
   flutter create . --platforms=web,android,ios
   ```
   Perintah ini aman — ia hanya menambahkan file yang belum ada, tidak
   menimpa `lib/` atau `pubspec.yaml` yang sudah dibuat.

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Jalankan di web (mode development):**
   ```bash
   flutter run -d chrome
   ```

4. **Build untuk produksi (GitHub Pages / hosting statis):**
   ```bash
   flutter build web --release
   ```
   Hasilnya ada di `build/web/` — unggah seluruh isi folder itu ke
   GitHub Pages (atau hosting statis lain) menggantikan `index.html`
   lama.

## Catatan konten

- **Tombol "Unduh CV"** saat ini mengarah ke
  `https://github.com/fadlijaya/fadlijaya.github.io/raw/master/assets/docs/CV-Fadli-Jaya.pdf`.
  File itu **belum ada** di repo kamu — upload PDF ke path tersebut, atau
  ubah URL-nya di `lib/widgets/hero_section.dart` (cari `_open(` pada
  tombol "Unduh CV").
- Ikon sosial (GitHub/Instagram/LinkedIn) memakai ikon Material bawaan
  Flutter (`Icons.code_rounded`, dst), bukan logo asli brand — supaya
  tidak perlu menambah dependency `flutter_svg`. Kalau mau logo asli,
  gampang: tambahkan `flutter_svg` lalu ganti `Icon(...)` di
  `social_icon_button.dart` dengan `SvgPicture.asset(...)`.
- Angka di panel statistik (tahun pengalaman, jumlah proyek, dst) ada di
  `PortfolioData.stats` — silakan sesuaikan dengan data terbaru kamu.
- Font menggunakan paket `google_fonts` (Space Grotesk untuk judul,
  Inter untuk body) — otomatis diunduh saat runtime pertama kali
  (butuh koneksi internet saat development; untuk build offline penuh,
  font bisa di-bundle manual via `fonts:` di `pubspec.yaml`).
