import 'dart:math';
import 'package:flutter/material.dart';
import 'package:portfolio/theme/colors.dart';

class ParticlesPainter extends CustomPainter {
  final Animation<double> animation;
  final List<_Particle> particles;
  final ValueNotifier<Offset?> mousePosNotifier;
  final Color hoverColor;
  final double speed;

  ParticlesPainter({
    required this.animation,
    required this.particles,
    required this.mousePosNotifier,
    required this.hoverColor,
    required this.speed,
  }) : super(repaint: Listenable.merge([animation, mousePosNotifier]));

  @override
  void paint(Canvas canvas, Size size) {
    final animValue = animation.value;
    final mousePos = mousePosNotifier.value;

    for (final p in particles) {
      final driftX = sin(animValue * speed * 2 * pi + p.phase * 10) * 15;
      final driftY = cos(animValue * speed * 2 * pi + p.phase * 5) * 15;

      double x = p.x * size.width + driftX;
      double verticalProgress = (animValue * speed + p.phase) % 1.0;
      double y =
          (p.baseY * size.height - verticalProgress * 250) % size.height +
              driftY;

      if (mousePos != null) {
        final dx = x - mousePos.dx;
        final dy = y - mousePos.dy;
        final distSq = dx * dx + dy * dy;
        const radius = 40.0;
        if (distSq < radius * radius) {
          p.color = hoverColor;
        }
      }

      final t = (animValue * speed + p.phase) % 1.0;
      final opacity = (t < 0.2
              ? t / 0.2
              : t > 0.8
                  ? (1.0 - t) / 0.2
                  : 1.0) *
          p.baseOpacity;

      final paint = Paint()
        ..color = p.color.withValues(alpha: opacity.clamp(0, 1))
        ..style = PaintingStyle.fill;

      if (p.color == hoverColor) {
        canvas.drawCircle(
            Offset(x, y),
            p.size * 2.5,
            Paint()
              ..color = hoverColor.withValues(alpha: opacity.clamp(0, 1) * 0.3)
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6));
      }

      canvas.drawCircle(Offset(x, y), p.size, paint);
    }
  }

  @override
  bool shouldRepaint(ParticlesPainter old) => true;
}

class _Particle {
  final double x, baseY, phase, size, baseOpacity;
  Color color;

  _Particle({
    required this.x,
    required this.baseY,
    required this.phase,
    required this.size,
    required this.color,
    required this.baseOpacity,
  });
}

class ParticlesWidget extends StatefulWidget {
  final ValueNotifier<int> particleCount;
  final ValueNotifier<double> speed;
  final ValueNotifier<Color> hoverColor;
  const ParticlesWidget({
    super.key,
    required this.particleCount,
    required this.speed,
    required this.hoverColor,
  });

  @override
  State<ParticlesWidget> createState() => _ParticlesWidgetState();
}

class _ParticlesWidgetState extends State<ParticlesWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  Size _currentSize = Size.zero;
  List<_Particle> _particles = [];
  final ValueNotifier<Offset?> _mousePosNotifier = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    _ctrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 15))
          ..repeat();
    widget.particleCount.addListener(_onCountChanged);
  }

  void _onCountChanged() {
    if (_currentSize != Size.zero) {
      _initParticles(_currentSize, force: true);
    }
  }

  @override
  void didUpdateWidget(ParticlesWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.particleCount != widget.particleCount) {
      oldWidget.particleCount.removeListener(_onCountChanged);
      widget.particleCount.addListener(_onCountChanged);
      _onCountChanged();
    }
  }

  void _initParticles(Size size, {bool force = false}) {
    _currentSize = size;
    final count = widget.particleCount.value;
    if (!force && _particles.length == count) return;
    final rnd = Random(42);
    _particles = List.generate(
      count,
      (_) {
        final colorRnd = rnd.nextDouble();
        Color pColor;
        if (colorRnd < 0.4) {
          pColor = AppColors.accent;
        } else if (colorRnd < 0.7) {
          pColor = AppColors.accent2;
        } else if (colorRnd < 0.9) {
          pColor = const Color(0xFF64B5F6);
        } else {
          pColor = Colors.white;
        }
        return _Particle(
          x: rnd.nextDouble(),
          baseY: rnd.nextDouble(),
          phase: rnd.nextDouble(),
          size: rnd.nextDouble() * 4 + 0.5,
          color: pColor,
          baseOpacity: rnd.nextDouble() * 0.4 + 0.2,
        );
      },
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _mousePosNotifier.dispose();
    widget.particleCount.removeListener(_onCountChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _initParticles(constraints.biggest);
        return AnimatedBuilder(
          animation: Listenable.merge([
            _ctrl,
            widget.particleCount,
            widget.speed,
            widget.hoverColor,
          ]),
          builder: (context, _) => Listener(
            onPointerHover: (e) => _mousePosNotifier.value = e.localPosition,
            onPointerMove: (e) => _mousePosNotifier.value = e.localPosition,
            onPointerDown: (e) => _mousePosNotifier.value = e.localPosition,
            onPointerUp: (_) => _mousePosNotifier.value = null,
            onPointerCancel: (_) => _mousePosNotifier.value = null,
            child: RepaintBoundary(
              child: CustomPaint(
                painter: ParticlesPainter(
                  animation: _ctrl,
                  particles: _particles,
                  mousePosNotifier: _mousePosNotifier,
                  hoverColor: widget.hoverColor.value,
                  speed: widget.speed.value,
                ),
                child: const SizedBox.expand(),
              ),
            ),
          ),
        );
      },
    );
  }
}
