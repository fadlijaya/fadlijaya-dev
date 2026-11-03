import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Kartu bergaya glassmorphism: latar semi-transparan + blur + border tipis,
/// opsional glow cyan saat kursor hover (desktop/web).
class GlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final bool hoverGlow;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.radius = AppRadius.card,
    this.hoverGlow = true,
    this.onTap,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final border = _hovering && widget.hoverGlow
        ? Border.all(color: AppColors.cyan.withOpacity(0.45), width: 1)
        : Border.all(color: AppColors.surfaceBorder, width: 1);

    final boxShadow = _hovering && widget.hoverGlow
        ? [
            BoxShadow(
              color: AppColors.cyan.withOpacity(0.18),
              blurRadius: 32,
              spreadRadius: -4,
            ),
          ]
        : const <BoxShadow>[];

    final content = ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: widget.padding,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(widget.radius),
            border: border,
            boxShadow: boxShadow,
          ),
          child: widget.child,
        ),
      ),
    );

    final wrapped = MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: widget.onTap != null
          ? GestureDetector(onTap: widget.onTap, child: content)
          : content,
    );

    return AnimatedScale(
      duration: const Duration(milliseconds: 220),
      scale: _hovering && widget.hoverGlow ? 1.015 : 1.0,
      child: wrapped,
    );
  }
}
