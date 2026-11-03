import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

enum GlowButtonStyle { primary, ghost }

/// Tombol ajakan bertindak (CTA): varian primary bercahaya cyan,
/// atau varian ghost dengan border tipis kaca.
class GlowButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final GlowButtonStyle style;
  final IconData? icon;

  const GlowButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.style = GlowButtonStyle.primary,
    this.icon,
  });

  @override
  State<GlowButton> createState() => _GlowButtonState();
}

class _GlowButtonState extends State<GlowButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final isPrimary = widget.style == GlowButtonStyle.primary;

    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      gradient: isPrimary
          ? const LinearGradient(
              colors: [AppColors.cyan, Color(0xFF49A8FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
          : null,
      color: isPrimary ? null : AppColors.surface,
      border: isPrimary
          ? null
          : Border.all(
              color: _hovering
                  ? AppColors.cyan.withOpacity(0.5)
                  : AppColors.surfaceBorder,
            ),
      boxShadow: isPrimary
          ? [
              BoxShadow(
                color: AppColors.cyan.withOpacity(_hovering ? 0.55 : 0.35),
                blurRadius: _hovering ? 34 : 24,
                spreadRadius: -2,
              ),
            ]
          : const [],
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 180),
          offset: _hovering ? const Offset(0, -0.08) : Offset.zero,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
            decoration: decoration,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.label,
                  style: GoogleFonts.inter(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    color: isPrimary
                        ? const Color(0xFF06141C)
                        : (_hovering ? AppColors.cyanSoft : AppColors.text),
                  ),
                ),
                if (widget.icon != null) ...[
                  const SizedBox(width: 8),
                  Icon(
                    widget.icon,
                    size: 16,
                    color: isPrimary
                        ? const Color(0xFF06141C)
                        : (_hovering ? AppColors.cyanSoft : AppColors.text),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
