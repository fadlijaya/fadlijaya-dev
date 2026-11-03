import 'package:flutter/material.dart';

/// Warna & ukuran inti tema gelap dengan aksen cyan bercahaya.
class AppColors {
  AppColors._();

  static const Color background = Color(0xFF070B12);
  static const Color backgroundSoft = Color(0xFF0B111C);
  static const Color surface = Color(0x0AFFFFFF); // ~4% white
  static const Color surfaceBorder = Color(0x14FFFFFF); // ~8% white

  static const Color cyan = Color(0xFF22E8FF);
  static const Color cyanSoft = Color(0xFF7DF9FF);
  static const Color violet = Color(0xFF8F6BFF);

  static const Color text = Color(0xFFE7EDF5);
  static const Color textDim = Color(0xFF8D9BB0);
  static const Color textFaint = Color(0xFF5C6A80);

  static const Color success = Color(0xFF34F5A8);
}

class AppBreakpoints {
  AppBreakpoints._();

  static const double tablet = 980;
  static const double mobile = 760;
}

class AppRadius {
  AppRadius._();

  static const double card = 18;
  static const double pill = 999;
}

/// Lebar maksimum konten, menyerupai .container{max-width:1180px}.
const double kMaxContentWidth = 1180;
