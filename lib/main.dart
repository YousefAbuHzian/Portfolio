import 'package:flutter/material.dart';
import 'theme/colors.dart';
import 'widgets/nav_bar.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/projects_section.dart';
import 'sections/contact_section.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized()
    ..deferFirstFrame()
    ..allowFirstFrame();

  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yousef Abu Hzian',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          surface: AppColors.bg,
          primary: AppColors.accent,
        ),
        scaffoldBackgroundColor: AppColors.bg,
        fontFamily: 'Inter',
        textTheme: ThemeData.dark().textTheme.apply(
              fontFamily: 'Inter',
              bodyColor: AppColors.textPrimary,
              displayColor: AppColors.textPrimary,
            ),
        useMaterial3: true,
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scrollCtrl = ScrollController();

  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _contactKey = GlobalKey();

  void _scrollToKey(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SelectionArea(
        child: Stack(
          children: [
            CustomScrollView(
              controller: _scrollCtrl,
              physics: const ClampingScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 80)),
                SliverToBoxAdapter(
                  key: _heroKey,
                  child: RepaintBoundary(
                    child: HeroSection(
                      onContact: () => _scrollToKey(_contactKey),
                      onExplore: () => _scrollToKey(_projectsKey),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: _Divider()),
                SliverToBoxAdapter(
                  child: RepaintBoundary(
                      child: SizedBox(
                          key: _aboutKey, child: const AboutSection())),
                ),
                const SliverToBoxAdapter(child: _Divider()),
                SliverToBoxAdapter(
                  child: RepaintBoundary(
                      child: SizedBox(
                          key: _projectsKey, child: const ProjectsSection())),
                ),
                // SliverToBoxAdapter(child: _Divider()),
                // SliverToBoxAdapter(
                //   child: RepaintBoundary(
                //       child: SizedBox(
                //           key: _psKey, child: const ProblemSolvingSection())),
                // ),
                const SliverToBoxAdapter(child: _Divider()),
                SliverToBoxAdapter(
                  child: RepaintBoundary(
                      child: SizedBox(
                          key: _contactKey, child: const ContactSection())),
                ),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: RepaintBoundary(
                child: LayoutBuilder(builder: (context, constraints) {
                  final isNarrow = constraints.maxWidth < 900;
                  if (isNarrow) {
                    return PortfolioMobileNav(
                      onHome: () => _scrollToKey(_heroKey),
                      onAbout: () => _scrollToKey(_aboutKey),
                      onProjects: () => _scrollToKey(_projectsKey),
                      onContact: () => _scrollToKey(_contactKey),
                    );
                  }
                  return PortfolioDesktopNav(
                    onHome: () => _scrollToKey(_heroKey),
                    onAbout: () => _scrollToKey(_aboutKey),
                    onProjects: () => _scrollToKey(_projectsKey),
                    onContact: () => _scrollToKey(_contactKey),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(height: 1, color: AppColors.border);
  }
}
