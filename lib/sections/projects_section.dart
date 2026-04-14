import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/colors.dart';
import '../widgets/common_widgets.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.bg,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Header ---
              _buildHeader(),
              const SizedBox(height: 60),

              // --- Featured Projects Grid ---
              LayoutBuilder(
                builder: (context, constraints) {
                  final bool isWide = constraints.maxWidth > 900;
                  return isWide ? _buildDesktopGrid() : _buildMobileGrid();
                },
              ),

              const SizedBox(height: 60),
              Center(
                child: GlowButton(
                  label: 'VIEW ALL PROJECTS',
                  outline: true,
                  onTap: () async {
                    final uri = Uri.parse(
                        'https://github.com/YousefAbuHzian?tab=repositories');
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  },
                ),
              ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 40, height: 2, color: AppColors.accent3),
            const SizedBox(width: 12),
            const Text(
              'EXPERIENCES',
              style: TextStyle(
                fontFamily: 'SpaceGrotesk',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
                color: AppColors.accent3,
              ),
            ),
          ],
        ).animate().fadeIn().slideX(begin: -0.2),
        const SizedBox(height: 16),
        const Text(
          'Crafting Functional \nDigital Narratives',
          style: TextStyle(
            fontFamily: 'SpaceGrotesk',
            fontSize: 44,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            height: 1.1,
            letterSpacing: -1.5,
          ),
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
      ],
    );
  }

  static const List<_ProjectModel> _projects = [
    _ProjectModel(
      title: 'ShopX E-commerce',
      category: 'Full Stack Mobile App',
      description:
          'A premium bilingual shopping experience with ASP.NET Core backend and Flutter frontend.',
      tags: ['Flutter', 'ASP.NET', 'PostgreSQL'],
      color: Color(0xFF7C6FF7),
      url: 'https://github.com/YousefAbuHzian/Ecommerce-App',
    ),
    _ProjectModel(
      title: 'E-commerce Admin Panel',
      category: 'Admin Panel',
      description:
          'A sophisticated dashboard for tracking assets, crypto, and traditional finance with live charts.',
      tags: ['Flutter', 'Rest APIs', 'Charts', 'ADO.NET'],
      color: Color(0xFFF87171),
      url: 'https://github.com/YousefAbuHzian/Ecommerce-Admin-Panel',
    ),
    _ProjectModel(
        title: 'DVLD- Driver & Vehicle Licensing Department',
        category: 'Desktop App',
        description:
            'A desktop app for managing driver and vehicle records, applicants, and test results end-to-end.',
        tags: ['C#', 'WinForms', 'ADO.NET', 'SQL Server'],
        color: Color(0xFFFBBF24),
        url: 'https://github.com/YousefAbuHzian/DVLD_System'),
    _ProjectModel(
        title: 'Student Notification System',
        category: 'College Adminestration',
        description:
            'A smart desktop app that automates sending personalized notifications to students based on their grades.',
        tags: ['C#', 'WinForms', 'ADO.NET', 'SQL Server'],
        color: Color(0xFF34D399),
        url: 'https://github.com/YousefAbuHzian/Student-Notification-System'),
  ];

  Widget _buildDesktopGrid() {
    return Column(
      children: [
        for (int i = 0; i < _projects.length; i += 2) ...[
          Row(
            children: [
              Expanded(child: _buildProjectCard(_projects[i])),
              const SizedBox(width: 24),
              if (i + 1 < _projects.length)
                Expanded(child: _buildProjectCard(_projects[i + 1]))
              else
                const Expanded(child: SizedBox()),
            ],
          ),
          if (i + 2 < _projects.length) const SizedBox(height: 24),
        ],
      ],
    );
  }

  Widget _buildMobileGrid() {
    return Column(
      children: [
        for (int i = 0; i < _projects.length; i++) ...[
          _buildProjectCard(_projects[i]),
          if (i != _projects.length - 1) const SizedBox(height: 20),
        ],
      ],
    );
  }

  Widget _buildProjectCard(_ProjectModel project) {
    return _ProjectCard(
      title: project.title,
      category: project.category,
      description: project.description,
      tags: project.tags,
      color: project.color,
      url: project.url,
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final String title;
  final String category;
  final String description;
  final String? url;
  final List<String> tags;
  final Color color;

  const _ProjectCard({
    required this.title,
    required this.category,
    required this.description,
    required this.tags,
    required this.color,
    this.url,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return ScrollReveal(
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          height: 320,
          decoration: BoxDecoration(
            color: AppColors.bg2,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color:
                  _isHovered ? widget.color.withValues(alpha: 0.5) : AppColors.border,
              width: 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.color.withValues(alpha: 0.15),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    )
                  ]
                : [],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Abstract Background Graphic
              Positioned(
                right: -50,
                top: -50,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  width: _isHovered ? 240 : 200,
                  height: _isHovered ? 240 : 200,
                  decoration: BoxDecoration(
                    color: widget.color.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
  
              // Content
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.category.toUpperCase(),
                      style: TextStyle(
                        color: widget.color,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SpaceGrotesk',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.description,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 14,
                        height: 1.5,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        ...widget.tags.map((tag) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.05),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.white.withValues(alpha: 0.1)),
                                ),
                                child: Text(tag,
                                    style: const TextStyle(
                                        color: Colors.white70, fontSize: 10)),
                              ),
                            )),
                        const Spacer(),
                        GestureDetector(
                          onTap: () async {
                            if (widget.url != null) {
                              final uri = Uri.parse(widget.url!);
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri);
                              }
                            }
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: _isHovered
                                    ? widget.color
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _isHovered
                                      ? Colors.transparent
                                      : Colors.white24,
                                ),
                              ),
                              child: Icon(
                                Icons.arrow_outward_rounded,
                                size: 16,
                                color: _isHovered ? Colors.black : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
}}

class _ProjectModel {
  final String title;
  final String category;
  final String description;
  final List<String> tags;
  final Color color;
  final String? url;

  const _ProjectModel({
    required this.title,
    required this.category,
    required this.description,
    required this.tags,
    required this.color,
    this.url,
  });
}
