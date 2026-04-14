import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Animate extends StatefulWidget {
  const Animate({super.key});

  @override
  State<Animate> createState() => _AnimateState();
}

class _AnimateState extends State<Animate> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(),
                const Text('Yousef  Abu Hzian')
                    .animate()
                    .fadeIn(duration: 800.ms)
                    .slideY(begin: 0.3),
                const SizedBox(
                  height: 100,
                ),
                const Text('Flutter Developer')
                    .animate()
                    .fadeIn(duration: 300.ms, delay: 200.ms)
                    .slideY(begin: 0.3, delay: 200.ms),
                const SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  children: [
                    Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.blueGrey,
                        )).animate().fadeIn(duration: 800.ms).slideY(begin: 0.5),
                    Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.rocket_launch,
                          color: Colors.blueGrey,
                        )).animate().fadeIn(duration: 800.ms, delay: 100.ms).slideY(begin: 0.5, delay: 100.ms),
                    Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.screenshot_monitor,
                          color: Colors.blueGrey,
                        )).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideY(begin: 0.5, delay: 100.ms),
                  ],
                ).animate().fadeIn(duration: 800.ms).slideX(begin: 0.5)
              ],
            ),
            Positioned(
                top: 20,
                right: 20,
                child: Column(
                  spacing: 20,
                  children: [
                    Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.blueGrey,
                        )),
                    Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.rocket_launch,
                          color: Colors.blueGrey,
                        )),
                    Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.screenshot_monitor,
                          color: Colors.blueGrey,
                        )),
                  ],
                ).animate().fadeIn(duration: 800.ms).slideX(begin: 0.5))
          ],
        ),
      ),
    );
  }
}
