import 'dart:math';

import 'package:flutter/material.dart';

import '../../state/app_state.dart';
import '../../widgets/activity_kit.dart';

class _Letter {
  final String letter;
  final String word;
  final String emoji;
  final List<Color> gradient;
  const _Letter(this.letter, this.word, this.emoji, this.gradient);
}

const _letters = <_Letter>[
  _Letter('A', 'Apple', '🍎', [Color(0xFFFB7185), Color(0xFFFB923C)]),
  _Letter('B', 'Ball', '⚽', [Color(0xFF60A5FA), Color(0xFF818CF8)]),
  _Letter('C', 'Cat', '🐱', [Color(0xFFFBBF24), Color(0xFFF59E0B)]),
  _Letter('D', 'Dog', '🐶', [Color(0xFF34D399), Color(0xFF14B8A6)]),
  _Letter('E', 'Elephant', '🐘', [Color(0xFFA855F7), Color(0xFFEC4899)]),
  _Letter('F', 'Fish', '🐟', [Color(0xFF38BDF8), Color(0xFF60A5FA)]),
  _Letter('G', 'Grapes', '🍇', [Color(0xFF7C3AED), Color(0xFFA855F7)]),
  _Letter('H', 'Hat', '🎩', [Color(0xFFEF4444), Color(0xFFF97316)]),
];

class AlphabetScreen extends StatefulWidget {
  const AlphabetScreen({super.key});

  @override
  State<AlphabetScreen> createState() => _AlphabetScreenState();
}

class _AlphabetScreenState extends State<AlphabetScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final l = _letters[_index];
    return ActivityShell(
      title: 'Alphabet Learning',
      titleColor: const Color(0xFF1F2937),
      backgroundColors: const [Color(0xFFFFF8EC), Color(0xFFEEF2FF)],
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: l.gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: l.gradient.first.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  l.letter,
                  style: const TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    height: 0.9,
                  ),
                ),
                Text(l.emoji, style: const TextStyle(fontSize: 80)),
                const SizedBox(height: 8),
                Text(
                  l.word,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.volume_up_rounded,
                      color: Color(0xFF1F2937)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _CircleNav(
                icon: Icons.chevron_left_rounded,
                onTap: () => setState(
                    () => _index = (_index - 1 + _letters.length) % _letters.length),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  '${_index + 1} / ${_letters.length}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ),
              _CircleNav(
                icon: Icons.chevron_right_rounded,
                onTap: () =>
                    setState(() => _index = (_index + 1) % _letters.length),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'Activities',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 10),
          GameModeListTile(
            title: 'Letter Tracing',
            icon: Icons.edit_rounded,
            gradient: const LinearGradient(colors: [
              Color(0xFFFB7185),
              Color(0xFFFB923C),
            ]),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => _LetterTracingGame(letter: l),
            )),
          ),
          const SizedBox(height: 10),
          GameModeListTile(
            title: 'Letter Sound Game',
            icon: Icons.music_note_rounded,
            gradient: const LinearGradient(colors: [
              Color(0xFF60A5FA),
              Color(0xFF22C55E),
            ]),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const _LetterSoundGame(),
            )),
          ),
          const SizedBox(height: 10),
          GameModeListTile(
            title: 'Find the Letter',
            icon: Icons.search_rounded,
            gradient: const LinearGradient(colors: [
              Color(0xFFFBBF24),
              Color(0xFFF97316),
            ]),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const _FindTheLetterGame(),
            )),
          ),
          const SizedBox(height: 18),
          const Text(
            'All Letters',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _letters.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemBuilder: (_, i) {
              final isActive = i == _index;
              return GestureDetector(
                onTap: () => setState(() => _index = i),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: isActive
                        ? Border.all(
                            color: const Color(0xFF60A5FA), width: 2)
                        : null,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _letters[i].letter,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CircleNav extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleNav({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.08),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(icon, color: const Color(0xFF1F2937)),
        ),
      ),
    );
  }
}

class _LetterTracingGame extends StatefulWidget {
  final _Letter letter;
  const _LetterTracingGame({required this.letter});

  @override
  State<_LetterTracingGame> createState() => _LetterTracingGameState();
}

class _LetterTracingGameState extends State<_LetterTracingGame> {
  final List<List<Offset>> _strokes = [];
  List<Offset> _current = [];

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: 'Alphabet Learning',
      backgroundColors: const [Color(0xFFFFF8EC), Color(0xFFEEF2FF)],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          children: [
            Text(
              'Trace the letter ${widget.letter.letter}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            widget.letter.letter,
                            style: TextStyle(
                              fontSize: 240,
                              fontWeight: FontWeight.w900,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 4
                                ..color = const Color(0xFFFB7185)
                                    .withOpacity(0.5),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onPanStart: (d) =>
                              setState(() => _current = [d.localPosition]),
                          onPanUpdate: (d) => setState(
                              () => _current = [..._current, d.localPosition]),
                          onPanEnd: (_) => setState(() {
                            _strokes.add(_current);
                            _current = [];
                          }),
                          child: CustomPaint(
                            painter: _LetterTracePainter([..._strokes, _current]),
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
                TextButton(
                  onPressed: () => setState(() {
                    _strokes.clear();
                    _current = [];
                  }),
                  child: const Text('Clear'),
                ),
                ElevatedButton(
                  onPressed: () {
                    AppStateScope.of(context).addStars(1);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF22C55E),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 26, vertical: 12),
                  ),
                  child: const Text('Done!',
                      style: TextStyle(fontWeight: FontWeight.w900)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LetterTracePainter extends CustomPainter {
  final List<List<Offset>> strokes;
  _LetterTracePainter(this.strokes);

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = const Color(0xFFFB7185)
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    for (final s in strokes) {
      for (int i = 1; i < s.length; i++) {
        canvas.drawLine(s[i - 1], s[i], p);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _LetterTracePainter old) =>
      old.strokes != strokes;
}

class _LetterSoundGame extends StatefulWidget {
  const _LetterSoundGame();

  @override
  State<_LetterSoundGame> createState() => _LetterSoundGameState();
}

class _LetterSoundGameState extends State<_LetterSoundGame> {
  late _Letter _target;
  late List<_Letter> _options;
  bool _celebrate = false;
  final _rng = Random();

  @override
  void initState() {
    super.initState();
    _next();
  }

  void _next() {
    final pool = [..._letters]..shuffle(_rng);
    _options = pool.take(3).toList();
    _target = _options[_rng.nextInt(_options.length)];
    _celebrate = false;
  }

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: 'Alphabet Learning',
      backgroundColors: const [Color(0xFFFFF8EC), Color(0xFFEEF2FF)],
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
            child: Column(
              children: [
                const Text(
                  'Which letter starts with',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF6B7280),
                  ),
                ),
                Text(
                  _target.emoji,
                  style: const TextStyle(fontSize: 90),
                ),
                Text(
                  _target.word,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 22),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    for (final o in _options)
                      GestureDetector(
                        onTap: () {
                          if (o.letter == _target.letter) {
                            AppStateScope.of(context).addStars(1);
                            setState(() => _celebrate = true);
                            Future.delayed(
                                const Duration(milliseconds: 800), () {
                              if (mounted) setState(_next);
                            });
                          }
                        },
                        child: Container(
                          width: 90,
                          height: 90,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: o.gradient),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            o.letter,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 44,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
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

class _FindTheLetterGame extends StatefulWidget {
  const _FindTheLetterGame();

  @override
  State<_FindTheLetterGame> createState() => _FindTheLetterGameState();
}

class _FindTheLetterGameState extends State<_FindTheLetterGame> {
  late _Letter _target;
  late List<_Letter> _grid;
  bool _celebrate = false;
  final _rng = Random();

  @override
  void initState() {
    super.initState();
    _next();
  }

  void _next() {
    final pool = [..._letters]..shuffle(_rng);
    _grid = pool.take(8).toList();
    _target = _grid[_rng.nextInt(_grid.length)];
    _celebrate = false;
  }

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: 'Alphabet Learning',
      backgroundColors: const [Color(0xFFFFF8EC), Color(0xFFEEF2FF)],
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              children: [
                const Text(
                  'Find the letter:',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF6B7280),
                  ),
                ),
                Text(
                  _target.letter,
                  style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFEC4899),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: GridView.builder(
                    itemCount: _grid.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (_, i) {
                      final l = _grid[i];
                      return GestureDetector(
                        onTap: () {
                          if (l.letter == _target.letter) {
                            AppStateScope.of(context).addStars(1);
                            setState(() => _celebrate = true);
                            Future.delayed(
                                const Duration(milliseconds: 800), () {
                              if (mounted) setState(_next);
                            });
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Text(
                            l.letter,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF1F2937),
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
