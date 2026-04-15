import 'dart:async';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/colors.dart';
import '../widgets/common_widgets.dart';
import '../widgets/particles_widget.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onExplore;
  final VoidCallback onContact;
  const HeroSection(
      {super.key, required this.onExplore, required this.onContact});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _pulseCtrl;

  // Particle Atmosphere State (Using ValueNotifiers for performance)
  final ValueNotifier<int> _particleCount = ValueNotifier(400);
  final ValueNotifier<double> _speed = ValueNotifier(1.0);
  final ValueNotifier<Color> _hoverColor = ValueNotifier(AppColors.amber);

  bool _isExpanded = false;

  final List<Color> _pickerColors = [
    Colors.white,
    AppColors.accent,
    AppColors.amber,
    AppColors.green,
    AppColors.red,
    Colors.cyanAccent,
  ];

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _particleCount.dispose();
    _speed.dispose();
    _hoverColor.dispose();
    super.dispose();
  }

  void _showMobileAtmosphere(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        decoration: BoxDecoration(
          color: AppColors.bg2,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 40,
              offset: const Offset(0, -10),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'ATMOSPHERE',
                  style: TextStyle(
                    fontFamily: 'SpaceGrotesk',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: AppColors.accent2,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white70),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildControlContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildControlContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Density
        ValueListenableBuilder<int>(
          valueListenable: _particleCount,
          builder: (context, val, _) => _SidebarSlider(
            label: 'Density',
            icon: Icons.grain,
            value: val.toDouble(),
            min: 50,
            max: 800,
            onChanged: (v) => _particleCount.value = v.toInt(),
            displayValue: val.toString(),
          ),
        ),

        // Speed
        ValueListenableBuilder<double>(
          valueListenable: _speed,
          builder: (context, val, _) => _SidebarSlider(
            label: 'Motion',
            icon: Icons.speed,
            value: val,
            min: 0.2,
            max: 4.0,
            onChanged: (v) => _speed.value = v,
            displayValue: '${val.toStringAsFixed(1)}x',
          ),
        ),

        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Divider(color: AppColors.border),
        ),

        const Text(
          'Interaction Color',
          style: TextStyle(color: Colors.white60, fontSize: 10),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _pickerColors.map((color) {
            return ValueListenableBuilder<Color>(
              valueListenable: _hoverColor,
              builder: (context, currentHover, _) {
                final isSelected = currentHover == color;
                return GestureDetector(
                  onTap: () => _hoverColor.value = color,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.white : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isSmall = MediaQuery.of(context).size.width < 900;

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          // Background Glow
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0, -0.8),
                  radius: 1.2,
                  colors: [Color(0x1F7C6FF7), Colors.transparent],
                ),
              ),
            ),
          ),

          // Particle System
          ParticlesWidget(
            particleCount: _particleCount,
            speed: _speed,
            hoverColor: _hoverColor,
          ),

          // Main Hero Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _AvailableBadge(pulseCtrl: _pulseCtrl)
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 600.ms)
                      .slideY(begin: 0.3),
                  const SizedBox(height: 24),

                  // Name
                  ValueListenableBuilder(
                      valueListenable: _hoverColor,
                      builder: (context, value, child) {
                        return RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: 'SpaceGrotesk',
                              fontSize: _responsiveFontSize(context, 64),
                              fontWeight: FontWeight.w700,
                              letterSpacing: -2,
                              height: 1.1,
                            ),
                            children: [
                              const TextSpan(
                                  text: 'Yousef ',
                                  style: TextStyle(color: Colors.white)),
                              TextSpan(
                                text: 'Abu Hzian',
                                style: TextStyle(
                                  foreground: Paint()
                                    ..shader = const LinearGradient(
                                      colors: [
                                        AppColors.accent2,
                                        AppColors.accent3
                                      ],
                                    ).createShader(
                                        const Rect.fromLTWH(0, 0, 500, 100)),
                                ),
                              ),
                            ],
                          ),
                        )
                            .animate()
                            .fadeIn(duration: 800.ms)
                            .slideY(begin: 0.3)
                            .animate(
                                onPlay: (controller) => controller.repeat())
                            .shimmer(
                                color: _hoverColor.value,
                                duration: 1500.ms,
                                delay: 3.seconds);
                      }),

                  const SizedBox(height: 12),

                  // Title
                  Text(
                    'Software Engineer & Flutter Developer',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: _responsiveFontSize(context, 18),
                      color: AppColors.textSecondary,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 800.ms, duration: 800.ms)
                      .slideY(begin: 0.3),
                  const SizedBox(height: 16),

                  const _TypingTagline()
                      .animate()
                      .fadeIn(delay: 1000.ms, duration: 800.ms),

                  const SizedBox(height: 40),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 12,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GlowButton(
                            label: 'Explore Projects', onTap: widget.onExplore),
                        GlowButton(
                            label: 'Get in Touch',
                            outline: true,
                            onTap: widget.onContact),
                      ],
                    )
                        .animate()
                        .fadeIn(delay: 1500.ms, duration: 800.ms)
                        .slideY(begin: 0.3),
                  ),

                  const SizedBox(height: 60),
                  const _StatsRow(),
                ],
              ),
            ),
          ),

          // Atmosphere Toggle (Floating for Mobile, Sidebar-integrated for Desktop)
          Positioned(
            left: isSmall ? 24 : (_isExpanded ? 260 : 24),
            top: 100,
            child: GestureDetector(
              onTap: () {
                if (isSmall) {
                  _showMobileAtmosphere(context);
                } else {
                  setState(() => _isExpanded = !_isExpanded);
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.bg2,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.border),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 10)
                  ],
                ),
                child: Icon(
                  isSmall
                      ? Icons.tune_rounded
                      : (_isExpanded ? Icons.close : Icons.tune_rounded),
                  color: AppColors.accent2,
                  size: 20,
                ),
              ),
            ),
          ),

          // Atmosphere Sidebar (Desktop only)
          if (!isSmall)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOutCubic,
              left: _isExpanded ? 24 : -300,
              top: 100,
              child: Container(
                width: 220,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.bg2,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.border),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ATMOSPHERE',
                      style: TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: AppColors.accent2,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildControlContent(),
                  ],
                ),
              ),
            ),

          // Social Sidebar
          if (MediaQuery.of(context).size.width > 900)
            const Positioned(
              right: 32,
              top: 0,
              bottom: 0,
              child: _SocialSidebar(),
            ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        runSpacing: 15,
        children: [
          _StatItem(
              icon: Icons.code_rounded,
              value: '7+',
              label: 'Full Stack Projects Built'),
          _StatItem(
              icon: Icons.bolt_rounded,
              value: '1000+',
              label: 'Problems Solved'),
          _StatItem(
              icon: Icons.auto_awesome_rounded,
              value: 'Level 4 Kyu',
              label: 'CodeWars Rank'),
          _StatItem(
              icon: Icons.terminal_rounded,
              value: 'Active',
              label: 'Always Learning'),
        ],
      ),
    ).animate().fadeIn(delay: 800.ms);
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const _StatItem(
      {required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.bg2,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border),
            ),
            child: Icon(icon, size: 20, color: AppColors.textPrimary),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'SpaceGrotesk',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ).animate().fadeIn(delay: 1800.ms, duration: 800.ms),
        ],
      ),
    );
  }
}

class _SocialSidebar extends StatelessWidget {
  const _SocialSidebar();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialIcon(
          Icons.code_rounded,
          label: 'GitHub',
          delay: 200.ms,
          url: 'https://github.com/YousefAbuHzian',
        ),
        const SizedBox(height: 16),
        _SocialIcon(
          Icons.diversity_3_rounded,
          label: 'LinkedIn',
          delay: 400.ms,
          url: 'https://linkedin.com/in/yousefabuhzian',
        ),
        const SizedBox(height: 16),
        _SocialIcon(
          Icons.alternate_email_rounded,
          label: 'Email',
          delay: 600.ms,
          url: 'mailto:yousefabuhzian@gmail.com',
        ),
        const SizedBox(height: 16),
        _SocialIcon(
          Icons.link_rounded,
          label: 'Copy Website Link',
          delay: 800.ms,
          url: 'copy',
        ),
        const SizedBox(height: 20),
        Container(
          width: 1,
          height: 80,
          color: AppColors.border.withValues(alpha: 0.5),
        ).animate().scaleY(
            begin: 0, duration: 800.ms, curve: Curves.easeOut, delay: 400.ms),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String label;
  final Duration delay;
  final String url;
  const _SocialIcon(this.icon,
      {required this.label, required this.delay, required this.url});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.label,
      verticalOffset: 30,
      preferBelow: false,
      decoration: BoxDecoration(
        color: AppColors.bg3,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 10,
        fontFamily: 'Inter',
      ),
      child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: () async {
              if (widget.url == 'copy') {
                String url = '';
                if (kIsWeb) {
                  url = html.window.location.href;
                } else {
                  url = 'https://yousefabuhzian.com'; // Fallback
                }
                await Clipboard.setData(ClipboardData(text: url));
                if (!mounted || !context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Link copied to clipboard!',
                        style: TextStyle(color: Colors.white)),
                    backgroundColor: AppColors.bg3,
                    behavior: SnackBarBehavior.floating,
                    width: 250,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                );
                return;
              }

              String finalUrl = widget.url;

              if (widget.url.startsWith('mailto:')) {
                final email = widget.url.replaceFirst('mailto:', '');

                bool isMobile = false;
                if (kIsWeb) {
                  final userAgent =
                      html.window.navigator.userAgent.toLowerCase();
                  isMobile = userAgent.contains('android') ||
                      userAgent.contains('iphone') ||
                      userAgent.contains('ipad') ||
                      userAgent.contains('mobile');
                } else {
                  isMobile = Theme.of(context).platform == TargetPlatform.iOS ||
                      Theme.of(context).platform == TargetPlatform.android;
                }

                if (!isMobile) {
                  finalUrl =
                      'https://mail.google.com/mail/?view=cm&fs=1&to=$email';
                }
              }

              final uri = Uri.parse(finalUrl);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: _hovered
                    ? AppColors.accent2.withValues(alpha: 0.1)
                    : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: _hovered ? AppColors.accent2 : AppColors.border,
                  width: _hovered ? 1.5 : 1,
                ),
                boxShadow: _hovered
                    ? [
                        BoxShadow(
                          color: AppColors.accent2.withValues(alpha: 0.2),
                          blurRadius: 10,
                          spreadRadius: 1,
                        )
                      ]
                    : [],
              ),
              child: Icon(
                widget.icon,
                size: 18,
                color: _hovered ? AppColors.accent2 : AppColors.textSecondary,
              ),
            ),
          )
              .animate()
              .fadeIn(delay: widget.delay, duration: 800.ms)
              .slideX(begin: 0.5)),
    );
  }
}

double _responsiveFontSize(BuildContext ctx, double base) {
  final w = MediaQuery.of(ctx).size.width;
  if (w < 600) return base * 0.6;
  if (w < 900) return base * 0.8;
  return base;
}

class _AvailableBadge extends StatelessWidget {
  final AnimationController pulseCtrl;
  const _AvailableBadge({required this.pulseCtrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0x1A7C6FF7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x4D7C6FF7)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: pulseCtrl,
            builder: (_, __) => Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.green.withValues(
                  alpha: 0.3 + 0.7 * pulseCtrl.value,
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            'Available for work',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              color: AppColors.accent2,
            ),
          ),
        ],
      ),
    );
  }
}

class _BlinkingCursor extends StatefulWidget {
  const _BlinkingCursor({super.key});
  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Opacity(
        opacity: _ctrl.value,
        child: Container(
          width: 2,
          height: 16,
          margin: const EdgeInsets.only(left: 1),
          color: AppColors.accent2,
        ),
      ),
    );
  }
}

class _TypingTagline extends StatefulWidget {
  const _TypingTagline();

  @override
  State<_TypingTagline> createState() => _TypingTaglineState();
}

class _TypingTaglineState extends State<_TypingTagline> {
  final List<String> _tags = [
    'Crafting clean REST APIs',
    'Solving hard problems',
    'Building beautiful mobile UIs',
    'Turning ideas into apps',
  ];
  int _tagIndex = 0;
  int _charIndex = 0;
  bool _deleting = false;
  String _typed = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    _timer = Timer.periodic(
      Duration(milliseconds: _deleting ? 28 : 55),
      (_) {
        if (!mounted) return;
        final tag = _tags[_tagIndex];
        setState(() {
          if (!_deleting) {
            _charIndex++;
            _typed = tag.substring(0, _charIndex);
            if (_charIndex == tag.length) {
              _deleting = true;
              _timer?.cancel();
              Future.delayed(const Duration(milliseconds: 1800), _startTyping);
            }
          } else {
            _charIndex--;
            _typed = tag.substring(0, _charIndex);
            if (_charIndex == 0) {
              _deleting = false;
              _tagIndex = (_tagIndex + 1) % _tags.length;
              _timer?.cancel();
              Future.delayed(const Duration(milliseconds: 400), _startTyping);
            }
          }
        });
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _typed,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 15,
            color: AppColors.textTertiary,
          ),
        ),
        const _BlinkingCursor(),
      ],
    );
  }
}

class _SidebarSlider extends StatelessWidget {
  final String label;
  final IconData icon;
  final double value;
  final double min;
  final double max;
  final String displayValue;
  final ValueChanged<double> onChanged;

  const _SidebarSlider({
    required this.label,
    required this.icon,
    required this.value,
    required this.min,
    required this.max,
    required this.displayValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: Colors.white38),
            const SizedBox(width: 8),
            Text(label,
                style: const TextStyle(color: Colors.white70, fontSize: 11)),
            const Spacer(),
            Text(displayValue,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 2,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
            activeTrackColor: AppColors.accent2,
            inactiveTrackColor: AppColors.border,
            thumbColor: Colors.white,
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
