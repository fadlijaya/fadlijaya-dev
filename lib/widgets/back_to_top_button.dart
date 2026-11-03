import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Tombol melingkar "kembali ke atas", muncul dengan fade+slide
/// saat halaman sudah discroll melewati ambang tertentu.
class BackToTopButton extends StatelessWidget {
  final bool visible;
  final VoidCallback onTap;

  const BackToTopButton({super.key, required this.visible, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: const Duration(milliseconds: 250),
      offset: visible ? Offset.zero : const Offset(0, 0.3),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: visible ? 1 : 0,
        child: IgnorePointer(
          ignoring: !visible,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surface,
                  border: Border.all(color: AppColors.cyan.withOpacity(0.35)),
                  boxShadow: [
                    BoxShadow(color: AppColors.cyan.withOpacity(0.15), blurRadius: 18),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.arrow_upward_rounded,
                  color: AppColors.cyanSoft,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
