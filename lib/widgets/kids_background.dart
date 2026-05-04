import 'package:flutter/material.dart';

class KidsBackground extends StatelessWidget {
  final Widget child;
  final double overlayOpacity;
  final List<Color>? gradientColors;

  const KidsBackground({
    super.key,
    required this.child,
    this.overlayOpacity = 0.85,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/kids_bg.jpg',
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors ??
                  [
                    Colors.white.withOpacity(overlayOpacity),
                    const Color(0xFFEFF6FF).withOpacity(overlayOpacity),
                    const Color(0xFFFFF7ED).withOpacity(overlayOpacity),
                  ],
            ),
          ),
        ),
        child,
      ],
    );
  }
}
