import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/common_widgets.dart';

class ProblemSolvingSection extends StatelessWidget {
  const ProblemSolvingSection({super.key});

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

              // --- Case Studies List ---
              _buildCaseStudy(
                index: '01',
                title: 'Eliminating Race Conditions in State Management',
                problem: 'Intermittent crashes caused by unhandled asynchronous events during Cubit state transitions, specifically during rapid UI interactions.',
                solution: 'Implemented a custom EventTransformer in BLoC to debounce rapid inputs and added strict type-guards to the state deserialization layer.',
                result: '100% crash reduction in production metrics and improved UI responsiveness by 30% through optimized event handling.',
                color: AppColors.accent2,
              ),
              const SizedBox(height: 40),
               _buildCaseStudy(
                index: '02',
                title: 'Optimizing Startup Latency for Web Portfolios',
                problem: 'Initial load times exceeded 4 seconds due to synchronous font loading and un-optimized heavy particle rendering.',
                solution: 'Lazy-loaded non-critical assets, converted fonts to local WOFF2, and isolated particle rendering logic within a RepaintBoundary.',
                result: 'First Contentful Paint (FCP) dropped to under 1.2s, achieving a 98/100 Lighthouse performance score.',
                color: AppColors.green,
              ),
              const SizedBox(height: 40),
               _buildCaseStudy(
                index: '03',
                title: 'Scaling Push Notifications sans Database Overhead',
                problem: 'Legacy notification system required individual token storage which became complex to sync across multiple user devices.',
                solution: 'Migrated to Firebase Topic-based FCM using unique user-ID topics, decoupling device tokens from the primary user database.',
                result: 'Simplified backend logic by 60% and achieved near-instant delivery across an unlimited number of devices per user.',
                color: AppColors.amber,
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
              Container(width: 40, height: 2, color: AppColors.amber),
              const SizedBox(width: 12),
              const Text(
                'DEEP DIVES',
                style: TextStyle(
                  fontFamily: 'SpaceGrotesk',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                  color: AppColors.amber,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Solving Complex \nArchitectural Puzzles',
            style: TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 44,
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

  Widget _buildCaseStudy({
    required String index,
    required String title,
    required String problem,
    required String solution,
    required String result,
    required Color color,
  }) {
    return LayoutBuilder(builder: (context, constraints) {
      final bool isWide = constraints.maxWidth > 800;
      return ScrollReveal(
        child: Container(
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: AppColors.bg2,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isWide) ...[
                Text(
                  index,
                  style: TextStyle(
                    fontFamily: 'SpaceGrotesk',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color.withValues(alpha: 0.5),
                  ),
                ),
                const SizedBox(width: 40),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 32),
                    if (isWide)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _infoBlock('THE PROBLEM', problem, Colors.redAccent.withValues(alpha: 0.2), Colors.redAccent)),
                          const SizedBox(width: 24),
                          Expanded(child: _infoBlock('THE FIX', solution, AppColors.accent2.withValues(alpha: 0.1), AppColors.accent2)),
                          const SizedBox(width: 24),
                          Expanded(child: _infoBlock('THE IMPACT', result, AppColors.green.withValues(alpha: 0.1), AppColors.green)),
                        ],
                      )
                    else
                      Column(
                        children: [
                          _infoBlock('THE PROBLEM', problem, Colors.redAccent.withValues(alpha: 0.2), Colors.redAccent),
                          const SizedBox(height: 16),
                          _infoBlock('THE FIX', solution, AppColors.accent2.withValues(alpha: 0.1), AppColors.accent2),
                          const SizedBox(height: 16),
                          _infoBlock('THE IMPACT', result, AppColors.green.withValues(alpha: 0.1), AppColors.green),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _infoBlock(String label, String text, Color bg, Color accent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: accent,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          text,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 14,
            height: 1.6,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }
}
