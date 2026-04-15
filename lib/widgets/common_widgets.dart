import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/colors.dart';

class SectionLabel extends StatelessWidget {
  final String text;
  const SectionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 40, height: 1, color: AppColors.border),
        const SizedBox(width: 10),
        Text(
          text.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'SpaceGrotesk',
            fontSize: 11,
            letterSpacing: 2,
            color: AppColors.accent2,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: Container(height: 1, color: AppColors.border)),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'SpaceGrotesk',
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
      ),
    );
  }
}

class SectionSub extends StatelessWidget {
  final String text;
  const SectionSub(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        color: AppColors.textSecondary,
      ),
    );
  }
}

class GlowButton extends StatefulWidget {
  final String label;
  final bool outline;
  final VoidCallback? onTap;
  const GlowButton(
      {super.key, required this.label, this.outline = false, this.onTap});

  @override
  State<GlowButton> createState() => _GlowButtonState();
}

class _GlowButtonState extends State<GlowButton> {
  bool _hovered = false;
  bool _isPressed = false;
  bool get _isActive => _hovered || _isPressed;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            color: widget.outline
                ? Colors.transparent
                : (_isActive ? AppColors.accent2 : AppColors.accent),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: widget.outline
                  ? (_isActive ? AppColors.accent : AppColors.border)
                  : Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: _isActive ? 18 : 0,
                child: Opacity(
                  opacity: _isActive ? 1 : 0,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.arrow_forward_ios_rounded,
                        size: 12, color: Colors.white),
                  ),
                ),
              ),
              SelectionContainer.disabled(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontFamily: 'SpaceGrotesk',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: widget.outline ? AppColors.accent2 : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScrollReveal extends StatefulWidget {
  final Widget child;
  const ScrollReveal({super.key, required this.child});

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal> {
  bool _visible = false;
  late final GlobalKey _key;

  @override
  void initState() {
    super.initState();
    _key = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _key,
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
          if (mounted) setState(() => _visible = true);
        }
      },
      child: widget.child
          .animate(target: _visible ? 1 : 0)
          .fadeIn(duration: 800.ms, curve: Curves.easeOutCubic)
          .slideY(
              begin: 0.1, end: 0, duration: 800.ms, curve: Curves.easeOutCubic),
    );
  }
}
