import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/colors.dart';
import '../widgets/common_widgets.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.bg,
      padding: const EdgeInsets.only(top: 150, bottom: 20, left: 24, right: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              // --- Header ---
              _buildHeader(),
              const SizedBox(height: 80),

              // --- Main Content ---
              _buildContactContent(context),

              const SizedBox(height: 50),

              // --- Simple Footer ---
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return ScrollReveal(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 32, height: 1.5, color: AppColors.accent),
              const SizedBox(width: 16),
              const Text(
                'GET IN TOUCH',
                style: TextStyle(
                  fontFamily: 'SpaceGrotesk',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                  color: AppColors.accent2,
                ),
              ),
              const SizedBox(width: 16),
              Container(width: 32, height: 1.5, color: AppColors.accent),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Let’s make something \nextraordinary.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 52,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.05,
              letterSpacing: -2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactContent(BuildContext context) {
    const String email = 'yousefabuhzian@gmail.com';

    return ScrollReveal(
      child: Column(
        children: [
          // Giant Email
          GestureDetector(
            onTap: () => launchUrl(Uri.parse('mailto:$email'),
                mode: LaunchMode.externalApplication),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: FittedBox(
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [AppColors.accent, AppColors.accent2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Text(
                    email,
                    style: TextStyle(
                      fontFamily: 'SpaceGrotesk',
                      fontSize: 56,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -2,
                      shadows: [
                        Shadow(
                          color: AppColors.accent.withValues(alpha: 0.3),
                          blurRadius: 30,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ).animate(onPlay: (controller) => controller.repeat()).shimmer(
                    color: Colors.white, duration: 1500.ms, delay: 3.seconds),
              ),
            ),
          ),

          const SizedBox(height: 48),

          // Action Buttons
          Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            runSpacing: 15,
            children: [
              _UtilityBtn(
                icon: Icons.copy_rounded,
                label: 'Copy Email',
                onTap: () {
                  Clipboard.setData(const ClipboardData(text: email));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Email copied to clipboard',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: AppColors.bg3,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      width: 250,
                    ),
                  );
                },
              ),
              const SizedBox(width: 20),
              _UtilityBtn(
                icon: Icons.arrow_outward_rounded,
                label: 'LinkedIn',
                onTap: () => launchUrl(
                    Uri.parse('https://linkedin.com/in/yousefabuhzian'),
                    mode: LaunchMode.externalApplication),
              ),
              const SizedBox(width: 20),
              _UtilityBtn(
                icon: Icons.code_rounded,
                label: 'GitHub',
                onTap: () => launchUrl(
                    Uri.parse('https://github.com/YousefAbuHzian'),
                    mode: LaunchMode.externalApplication),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Container(
          width: 40,
          height: 1,
          color: Colors.white.withValues(alpha: 0.1),
        ),
        const SizedBox(height: 40),
        Text(
          '© ${DateTime.now().year} YOUSEF ABU HZIAN • BUILT WITH FLUTTER',
          style: TextStyle(
            fontSize: 10,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            color: Colors.white.withValues(alpha: 0.25),
            fontFamily: 'SpaceGrotesk',
          ),
        ),
      ],
    );
  }
}

class _UtilityBtn extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _UtilityBtn(
      {required this.icon, required this.label, required this.onTap});

  @override
  State<_UtilityBtn> createState() => _UtilityBtnState();
}

class _UtilityBtnState extends State<_UtilityBtn> {
  bool _isHovered = false;
  bool _isPressed = false;
  bool get _isActive => _isHovered || _isPressed;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: _isActive
                ? Colors.white
                : Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isActive
                  ? Colors.white
                  : Colors.white.withValues(alpha: 0.08),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 16,
                color: _isActive ? Colors.black : Colors.white70,
              ),
              const SizedBox(width: 10),
              SelectionContainer.disabled(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    color: _isActive ? Colors.black : Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
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
