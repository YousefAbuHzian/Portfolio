import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/common_widgets.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.bg,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Section Header ---
              _buildHeader(),
              const SizedBox(height: 80),

              // --- Bento Grid Layout ---
              LayoutBuilder(
                builder: (context, constraints) {
                  final bool isDesktop = constraints.maxWidth > 900;
                  return isDesktop ? _buildDesktopGrid() : _buildMobileGrid();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return ScrollReveal(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 2,
                color: AppColors.accent2,
              ),
              const SizedBox(width: 12),
              const Text(
                'ABOUT ME',
                style: TextStyle(
                  fontFamily: 'SpaceGrotesk',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                  color: AppColors.accent2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Bridging the gap between \nDesign and Development',
            style: TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.1,
              letterSpacing: -1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopGrid() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Big Story Card
            Expanded(
              flex: 3,
              child: _BentoCard(
                height: 400,
                child: _buildStory(),
              ),
            ),
            const SizedBox(width: 24),
            // Experience Stat Card
            Expanded(
              flex: 2,
              child: _BentoCard(
                height: 400,
                child: _buildExpertiseList(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            // Tech Stack Card
            Expanded(
              flex: 2,
              child: _BentoCard(
                height: 300,
                child: _buildTechStack(),
              ),
            ),
            const SizedBox(width: 24),
            // Philosophy Card
            Expanded(
              flex: 3,
              child: _BentoCard(
                height: 300,
                child: _buildPhilosophy(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileGrid() {
    return Column(
      children: [
        _BentoCard(child: _buildStory()),
        const SizedBox(height: 20),
        _BentoCard(child: _buildExpertiseList()),
        const SizedBox(height: 20),
        _BentoCard(child: _buildTechStack()),
        const SizedBox(height: 20),
        _BentoCard(child: _buildPhilosophy()),
      ],
    );
  }

  // --- Card Contents ---

  Widget _buildStory() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.auto_awesome_rounded,
              color: AppColors.accent2, size: 32),
          const SizedBox(height: 24),
          const Text(
            'Profile',
            style: TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'An engineering mindset for decomposing, modelling, and optimizing systems translates naturally into building performant, visually sophisticated apps.',
            style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                color: Colors.white.withValues(alpha: 0.7),
                height: 1.6),
          ),
        ],
      ),
    );
  }

  Widget _buildExpertiseList() {
    final List<(IconData, String, String)> expertise = [
      (Icons.code_rounded, '.NET Backend', 'Scalable ASP.NET Core solutions'),
      (
        Icons.phone_iphone_rounded,
        'Flutter Mastery',
        'High-perf cross-platform apps'
      ),
      (
        Icons.storage_rounded,
        'Database Design',
        'Complex SQL & Data Architecture'
      ),
      (
        Icons.terminal_rounded,
        'Engineering Core',
        'Deep OOP , Data Structures & Algorithms'
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Focus Areas',
              style: TextStyle(
                fontFamily: 'SpaceGrotesk',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          const SizedBox(height: 24),
          ...expertise.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.accent3.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(item.$1, color: AppColors.accent3, size: 18),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.$2,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        Text(item.$3,
                            style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.5),
                                fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildTechStack() {
    final List<String> tech = [
      'Dart',
      'Flutter',
      'C#',
      'ASP.NET Core',
      'PostgreSQL',
      'C++',
      'Git',
      'State Management',
    ];

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Top Skills',
              style: TextStyle(
                fontFamily: 'SpaceGrotesk',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          const SizedBox(height: 24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tech
                .map((t) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: Colors.white.withValues(alpha: 0.1)),
                      ),
                      child: Text(t,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 12)),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPhilosophy() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.format_quote_rounded,
              color: AppColors.accent2.withValues(alpha: 0.3), size: 48),
          const SizedBox(height: 8),
          const Text(
            'I bring an engineer\'s precision to software development, turning complex problems into clean, high-performance user experiences.',
            style: TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 20,
              fontStyle: FontStyle.italic,
              color: Colors.white,
              height: 1.4,
            ),
          ),
          // const SizedBox(height: 16),
          // const Text(
          //   '— Yousef Abu Hzian',
          //   style: TextStyle(
          //     color: AppColors.accent2,
          //     fontSize: 14,
          //     fontWeight: FontWeight.bold,
          //     letterSpacing: 1,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class _BentoCard extends StatefulWidget {
  final Widget child;
  final double? height;

  const _BentoCard({required this.child, this.height});

  @override
  State<_BentoCard> createState() => _BentoCardState();
}

class _BentoCardState extends State<_BentoCard> {
  bool _isHovered = false;
  bool _isPressed = false;
  bool get _isActive => _isHovered || _isPressed;

  @override
  Widget build(BuildContext context) {
    return ScrollReveal(
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: widget.height,
            width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.bg2,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isActive
                  ? AppColors.accent2.withValues(alpha: 0.5)
                  : AppColors.border,
              width: 1, 
            ),
            boxShadow: _isActive
                ? [
                    BoxShadow(
                      color: AppColors.accent2.withValues(alpha: 0.1),
                      blurRadius: 20,
                      spreadRadius: 2,
                    )
                  ]
                : [],
          ),
          child: widget.child,
        ),
      ),
    ));
  }
}
