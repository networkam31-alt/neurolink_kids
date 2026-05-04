import 'package:flutter/material.dart';

import '../widgets/kids_background.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _fade;
  late final Animation<double> _rotate;
  late final AnimationController _bobController;
  late final Animation<double> _bob;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _scale = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _rotate = Tween<double>(begin: -0.15, end: 0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();

    _bobController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _bob = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(parent: _bobController, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (_, __, ___) => const WelcomeScreen(),
          transitionsBuilder: (_, anim, __, child) =>
              FadeTransition(opacity: anim, child: child),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _bobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KidsBackground(
        overlayOpacity: 0.92,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: Listenable.merge([_controller, _bobController]),
                builder: (context, _) {
                  return Transform.translate(
                    offset: Offset(0, _bob.value),
                    child: Transform.rotate(
                      angle: _rotate.value,
                      child: Transform.scale(
                        scale: 0.4 + 0.6 * _scale.value,
                        child: Opacity(
                          opacity: _fade.value,
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 220,
                            height: 220,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              FadeTransition(
                opacity: _fade,
                child: const Column(
                  children: [
                    Text(
                      'NeuroLink Kids',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Apprendre • Pratiquer • Grandir',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              const SizedBox(
                width: 38,
                height: 38,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
