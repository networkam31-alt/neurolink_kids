import 'dart:math';

import 'package:flutter/material.dart';

import '../../widgets/activity_kit.dart';

class RelaxationScreen extends StatelessWidget {
  const RelaxationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: 'Relaxation',
      titleColor: const Color(0xFF14B8A6),
      backgroundColors: const [Color(0xFFE7FBE7), Color(0xFFE0F2FE)],
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          GameModeListTile(
            title: 'Breathing Exercise',
            icon: Icons.air_rounded,
            gradient: const LinearGradient(colors: [
              Color(0xFF60A5FA),
              Color(0xFF22D3EE),
            ]),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const _BreathingScreen(),
            )),
          ),
          const SizedBox(height: 10),
          GameModeListTile(
            title: 'Pop the Bubbles',
            icon: Icons.bubble_chart_rounded,
            gradient: const LinearGradient(colors: [
              Color(0xFFEC4899),
              Color(0xFFA855F7),
            ]),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const _BubbleScreen(),
            )),
          ),
          const SizedBox(height: 10),
          GameModeListTile(
            title: 'Nature Sounds',
            icon: Icons.forest_rounded,
            gradient: const LinearGradient(colors: [
              Color(0xFF22C55E),
              Color(0xFF14B8A6),
            ]),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const _NatureSoundsScreen(),
            )),
          ),
          const SizedBox(height: 10),
          GameModeListTile(
            title: 'Color Flow',
            icon: Icons.palette_rounded,
            gradient: const LinearGradient(colors: [
              Color(0xFFFBBF24),
              Color(0xFFF97316),
            ]),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const _ColorFlowScreen(),
            )),
          ),
        ],
      ),
    );
  }
}

class _BreathingScreen extends StatefulWidget {
  const _BreathingScreen();

  @override
  State<_BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<_BreathingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: const Duration(seconds: 4))
        ..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: 'Relaxation',
      backgroundColors: const [Color(0xFFE0F2FE), Color(0xFFE7FBE7)],
      child: AnimatedBuilder(
        animation: _c,
        builder: (_, __) {
          final t = _c.value;
          final size = 140 + 160 * t;
          final label = t < 0.45
              ? 'Breathe in'
              : t < 0.55
                  ? 'Hold'
                  : 'Breathe out';
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(colors: [
                      Color(0xFF60A5FA),
                      Color(0xFF22D3EE),
                    ]),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF60A5FA).withOpacity(0.4),
                        blurRadius: 30,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Text('🌬️',
                      style: TextStyle(fontSize: 60)),
                ),
                const SizedBox(height: 30),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _BubbleScreen extends StatefulWidget {
  const _BubbleScreen();

  @override
  State<_BubbleScreen> createState() => _BubbleScreenState();
}

class _BubbleScreenState extends State<_BubbleScreen> {
  final List<_Bubble> _bubbles = [];
  final _rng = Random();
  int _popped = 0;

  @override
  void initState() {
    super.initState();
    _bubbles.addAll(List.generate(12, (_) => _spawn()));
  }

  _Bubble _spawn() {
    return _Bubble(
      x: _rng.nextDouble(),
      y: _rng.nextDouble(),
      size: 50 + _rng.nextDouble() * 50,
      color: HSLColor.fromAHSL(
        1,
        _rng.nextDouble() * 360,
        0.7,
        0.7,
      ).toColor(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: 'Relaxation',
      backgroundColors: const [Color(0xFFEAF2FF), Color(0xFFFCE7F3)],
      child: Stack(children: [
        for (final b in _bubbles)
          Positioned(
            left: b.x * (MediaQuery.of(context).size.width - b.size - 16) + 8,
            top: b.y * 500,
            child: GestureDetector(
              onTap: () => setState(() {
                _bubbles.remove(b);
                _bubbles.add(_spawn());
                _popped++;
              }),
              child: Container(
                width: b.size,
                height: b.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    Colors.white,
                    b.color.withOpacity(0.7),
                  ]),
                ),
              ),
            ),
          ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Popped: $_popped 🫧',
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class _Bubble {
  final double x, y, size;
  final Color color;
  _Bubble({
    required this.x,
    required this.y,
    required this.size,
    required this.color,
  });
}

class _NatureSoundsScreen extends StatefulWidget {
  const _NatureSoundsScreen();

  @override
  State<_NatureSoundsScreen> createState() => _NatureSoundsScreenState();
}

class _NatureSoundsScreenState extends State<_NatureSoundsScreen> {
  static const _sounds = [
    ('🌧️', 'Rain'),
    ('🌊', 'Ocean Waves'),
    ('🌳', 'Forest'),
    ('🐦', 'Birds'),
    ('🔥', 'Fireplace'),
  ];
  int _i = 0;

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: 'Relaxation',
      backgroundColors: const [Color(0xFFE7FBE7), Color(0xFFE0F2FE)],
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                Color(0xFF22C55E),
                Color(0xFF14B8A6),
              ]),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Center(
              child: Column(
                children: [
                  Text(_sounds[_i].$1,
                      style: const TextStyle(fontSize: 96)),
                  Text(
                    _sounds[_i].$2,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Icon(Icons.play_circle_fill_rounded,
                      color: Colors.white, size: 60),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          for (int i = 0; i < _sounds.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                onTap: () => setState(() => _i = i),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    color: i == _i
                        ? const Color(0xFF14B8A6)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Text(_sounds[i].$1,
                          style: const TextStyle(fontSize: 28)),
                      const SizedBox(width: 10),
                      Text(
                        _sounds[i].$2,
                        style: TextStyle(
                          color: i == _i
                              ? Colors.white
                              : const Color(0xFF1F2937),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ColorFlowScreen extends StatefulWidget {
  const _ColorFlowScreen();

  @override
  State<_ColorFlowScreen> createState() => _ColorFlowScreenState();
}

class _ColorFlowScreenState extends State<_ColorFlowScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
      vsync: this, duration: const Duration(seconds: 8))
    ..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  Color _hue(double t) =>
      HSLColor.fromAHSL(1, (t * 360) % 360, 0.6, 0.7).toColor();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, __) {
        return ActivityShell(
          title: 'Relaxation',
          backgroundColors: [
            _hue(_c.value),
            _hue(_c.value + 0.5),
          ],
          child: const Center(
            child: Text(
              'Just relax 🌈',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w900,
                shadows: [
                  Shadow(
                    color: Colors.black26,
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
