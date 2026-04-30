import 'dart:math';

import 'package:flutter/material.dart';

import '../../state/app_state.dart';
import '../../widgets/activity_kit.dart';

class NumbersScreen extends StatelessWidget {
  const NumbersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: 'Numbers Learning',
      titleColor: const Color(0xFF22C55E),
      backgroundColors: const [Color(0xFFE0F2FE), Color(0xFFE7FBE7)],
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          GameModeCard(
            title: 'Count Objects',
            subtitle: 'How many do you see?',
            icon: const Text('🔢', style: TextStyle(fontSize: 32)),
            gradient: const LinearGradient(
              colors: [Color(0xFF60A5FA), Color(0xFF22D3EE)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const _CountObjectsGame(),
            )),
          ),
          const SizedBox(height: 14),
          GameModeCard(
            title: 'Number Matching',
            subtitle: 'Match numbers to groups!',
            icon: const Text('🎯', style: TextStyle(fontSize: 32)),
            gradient: const LinearGradient(
              colors: [Color(0xFF22C55E), Color(0xFF14B8A6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const _NumberMatchingGame(),
            )),
          ),
          const SizedBox(height: 14),
          GameModeCard(
            title: 'Trace Number',
            subtitle: 'Draw with your finger!',
            icon: const Text('✏️', style: TextStyle(fontSize: 32)),
            gradient: const LinearGradient(
              colors: [Color(0xFF38BDF8), Color(0xFF60A5FA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const _TraceNumberGame(),
            )),
          ),
        ],
      ),
    );
  }
}

class _CountObjectsGame extends StatefulWidget {
  const _CountObjectsGame();

  @override
  State<_CountObjectsGame> createState() => _CountObjectsGameState();
}

class _CountObjectsGameState extends State<_CountObjectsGame> {
  int _count = 2;
  late List<int> _options;
  bool _celebrate = false;
  final _rng = Random();

  static const _emojis = ['🍎', '🍌', '🍓', '⭐', '🐱', '🎈', '🌸', '🦋'];
  late String _emoji;

  @override
  void initState() {
    super.initState();
    _next();
  }

  void _next() {
    _count = 1 + _rng.nextInt(5);
    _emoji = _emojis[_rng.nextInt(_emojis.length)];
    final wrong1 = _count + 1;
    final wrong2 = max(1, _count - 1);
    _options = [_count, wrong1, wrong2]..shuffle(_rng);
    _celebrate = false;
  }

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: 'Numbers Learning',
      titleColor: const Color(0xFF22C55E),
      backgroundColors: const [Color(0xFFE0F2FE), Color(0xFFE7FBE7)],
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
            child: Column(
              children: [
                const Text(
                  'How many?',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 30),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: List.generate(
                    _count,
                    (_) =>
                        Text(_emoji, style: const TextStyle(fontSize: 56)),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (final v in _options)
                      _NumberOption(
                        value: v,
                        onTap: () {
                          if (v == _count) {
                            AppStateScope.of(context).addStars(1);
                            setState(() => _celebrate = true);
                            Future.delayed(
                                const Duration(milliseconds: 900), () {
                              if (mounted) setState(_next);
                            });
                          }
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
          CelebrationOverlay(show: _celebrate),
        ],
      ),
    );
  }
}

class _NumberOption extends StatelessWidget {
  final int value;
  final VoidCallback onTap;
  const _NumberOption({required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          '$value',
          style: const TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.w900,
            color: Color(0xFF2563EB),
          ),
        ),
      ),
    );
  }
}

class _NumberMatchingGame extends StatefulWidget {
  const _NumberMatchingGame();

  @override
  State<_NumberMatchingGame> createState() => _NumberMatchingGameState();
}

class _NumberMatchingGameState extends State<_NumberMatchingGame> {
  int _target = 2;
  late List<int> _options;
  bool _celebrate = false;
  final _rng = Random();

  @override
  void initState() {
    super.initState();
    _next();
  }

  void _next() {
    _target = 1 + _rng.nextInt(5);
    final pool = <int>{_target, _target + 1, max(1, _target - 1), _target + 2}
        .toList()
      ..shuffle(_rng);
    _options = pool.take(3).toList();
    _celebrate = false;
  }

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: 'Numbers Learning',
      titleColor: const Color(0xFF22C55E),
      backgroundColors: const [Color(0xFFE0F2FE), Color(0xFFE7FBE7)],
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              children: [
                Text(
                  'Find the group with $_target\nobjects!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 90,
                  height: 90,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF60A5FA), Color(0xFF22C55E)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$_target',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: ListView.separated(
                    itemCount: _options.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) {
                      final n = _options[i];
                      return GestureDetector(
                        onTap: () {
                          if (n == _target) {
                            AppStateScope.of(context).addStars(1);
                            setState(() => _celebrate = true);
                            Future.delayed(
                                const Duration(milliseconds: 800), () {
                              if (mounted) setState(_next);
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Wrap(
                            spacing: 6,
                            children: List.generate(
                              n,
                              (_) => const Text('🍎',
                                  style: TextStyle(fontSize: 30)),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          CelebrationOverlay(show: _celebrate),
        ],
      ),
    );
  }
}

class _TraceNumberGame extends StatefulWidget {
  const _TraceNumberGame();

  @override
  State<_TraceNumberGame> createState() => _TraceNumberGameState();
}

class _TraceNumberGameState extends State<_TraceNumberGame> {
  int _digit = 5;
  final List<List<Offset>> _strokes = [];
  List<Offset> _current = [];

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: 'Numbers Learning',
      titleColor: const Color(0xFF22C55E),
      backgroundColors: const [Color(0xFFE0F2FE), Color(0xFFE7FBE7)],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          children: [
            const Text(
              'Trace the number',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1F2937),
              ),
            ),
            const Text(
              'Draw with your finger!',
              style: TextStyle(color: Color(0xFF6B7280)),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            '$_digit',
                            style: TextStyle(
                              fontSize: 220,
                              fontWeight: FontWeight.w900,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 4
                                ..color = const Color(0xFF60A5FA)
                                    .withOpacity(0.6),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onPanStart: (d) {
                            setState(() => _current = [d.localPosition]);
                          },
                          onPanUpdate: (d) {
                            setState(() => _current = [
                                  ..._current,
                                  d.localPosition,
                                ]);
                          },
                          onPanEnd: (_) {
                            setState(() {
                              _strokes.add(_current);
                              _current = [];
                            });
                          },
                          child: CustomPaint(
                            painter: _TracePainter([..._strokes, _current]),
                            size: Size.infinite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() {
                    _strokes.clear();
                    _current = [];
                  }),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF1F2937),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 12),
                  ),
                  child: const Text('Clear'),
                ),
                ElevatedButton(
                  onPressed: () {
                    AppStateScope.of(context).addStars(1);
                    setState(() {
                      _digit = (_digit % 9) + 1;
                      _strokes.clear();
                      _current = [];
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 26, vertical: 12),
                  ).copyWith(
                    backgroundColor:
                        WidgetStateProperty.all(const Color(0xFF22C55E)),
                  ),
                  child: const Text(
                    'Done!',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TracePainter extends CustomPainter {
  final List<List<Offset>> strokes;
  _TracePainter(this.strokes);

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = const Color(0xFFEC4899)
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    for (final stroke in strokes) {
      for (int i = 1; i < stroke.length; i++) {
        canvas.drawLine(stroke[i - 1], stroke[i], p);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _TracePainter old) =>
      old.strokes != strokes;
}
