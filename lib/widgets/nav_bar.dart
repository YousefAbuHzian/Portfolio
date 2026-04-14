import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/colors.dart';

class PortfolioDesktopNav extends StatelessWidget {
  final VoidCallback onHome, onAbout, onProjects, onContact;
  const PortfolioDesktopNav({
    super.key,
    required this.onHome,
    required this.onAbout,
    required this.onProjects,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        width: 1000,
        height: 70,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              decoration: BoxDecoration(
                color: AppColors.bg.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(35),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [AppColors.accent2, AppColors.accent3],
                    ).createShader(bounds),
                    child: const Text(
                      'YOUSEF ABU HZIAN',
                      style: TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    ),
                  )
                      .animate(onPlay: (controller) => controller.repeat())
                      .shimmer(
                          color: Colors.white,
                          duration: 1.seconds,
                          delay: 3.seconds),
                  const Spacer(),
                  _NavLink('Home', onHome),
                  _NavLink('About', onAbout),
                  _NavLink('Projects', onProjects),
                  _NavLink('Contact', onContact),
                  const SizedBox(width: 24),
                  const _DownloadCVBtn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DownloadCVBtn extends StatefulWidget {
  const _DownloadCVBtn();

  @override
  State<_DownloadCVBtn> createState() => _DownloadCVBtnState();
}

class _DownloadCVBtnState extends State<_DownloadCVBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.accent2 : AppColors.accent,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_forward_ios_rounded,
                  size: 12, color: Colors.white),
              SizedBox(width: 8),
              SelectionContainer.disabled(
                child: Text(
                  'Download CV',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
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

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _NavLink(this.label, this.onTap);

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SelectionContainer.disabled(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _hovered
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: _hovered ? 20 : 0,
                height: 2,
                decoration: BoxDecoration(
                  color: AppColors.accent2,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PortfolioMobileNav extends StatefulWidget {
  final VoidCallback onHome, onAbout, onProjects, onContact;
  const PortfolioMobileNav({
    super.key,
    required this.onHome,
    required this.onAbout,
    required this.onProjects,
    required this.onContact,
  });

  @override
  State<PortfolioMobileNav> createState() => _PortfolioMobileNavState();
}

class _PortfolioMobileNavState extends State<PortfolioMobileNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.bg.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [AppColors.accent2, AppColors.accent3],
                  ).createShader(bounds),
                  child: const Text(
                    'YOUSEF ABU HZIAN',
                    style: TextStyle(
                      fontFamily: 'SpaceGrotesk',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ).animate(onPlay: (controller) => controller.repeat()).shimmer(
                    color: Colors.white, duration: 1.seconds, delay: 3.seconds),
                const Spacer(),
                Theme(
                  data: Theme.of(context).copyWith(
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: PopupMenuButton<String>(
                    offset: const Offset(0, 65),
                    elevation: 0,
                    color: AppColors.bg3.withValues(alpha: 0.95),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                          color: Colors.white.withValues(alpha: 0.1)),
                    ),
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.accentGlow.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.menu_rounded,
                        color: AppColors.accent2,
                        size: 22,
                      ),
                    ),
                    onSelected: (v) {
                      switch (v) {
                        case 'home':
                          widget.onHome();
                          break;
                        case 'about':
                          widget.onAbout();
                          break;
                        case 'projects':
                          widget.onProjects();
                          break;
                        case 'contact':
                          widget.onContact();
                          break;
                      }
                    },
                    itemBuilder: (_) => [
                      _menuItem('home', Icons.home_rounded, 'Home'),
                      _menuItem('about', Icons.person_rounded, 'About'),
                      _menuItem('projects', Icons.folder_rounded, 'Projects'),
                      _menuItem('contact', Icons.send_rounded, 'Contact'),
                      _menuItem('contact', Icons.download_rounded, 'Download CV'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PopupMenuItem<String> _menuItem(String v, IconData icon, String label) {
    return PopupMenuItem(
      value: v,
      height: 48,
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          SelectionContainer.disabled(
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
