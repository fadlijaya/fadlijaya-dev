import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Ikon bundar untuk tautan media sosial (GitHub, Instagram, LinkedIn, Email).
class SocialIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;
  final double size;

  const SocialIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.tooltip,
    this.size = 44,
  });

  @override
  State<SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<SocialIconButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedSlide(
            duration: const Duration(milliseconds: 180),
            offset: _hovering ? const Offset(0, -0.1) : Offset.zero,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _hovering
                      ? AppColors.cyan.withOpacity(0.5)
                      : AppColors.surfaceBorder,
                ),
                boxShadow: _hovering
                    ? [
                        BoxShadow(
                          color: AppColors.cyan.withOpacity(0.25),
                          blurRadius: 16,
                        ),
                      ]
                    : const [],
              ),
              child: Icon(
                widget.icon,
                size: 19,
                color: _hovering ? AppColors.cyanSoft : AppColors.textDim,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
