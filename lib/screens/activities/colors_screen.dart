import 'dart:math';

import 'package:flutter/material.dart';

import '../../state/app_state.dart';
import '../../widgets/activity_kit.dart';

class ColorsScreen extends StatefulWidget {
  const ColorsScreen({super.key});

  @override
  State<ColorsScreen> createState() => _ColorsScreenState();
}

class _ColorsScreenState extends State<ColorsScreen> {
  int _level = 1;

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: 'Colors Learning',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          GameModeCard(
            title: 'Tap the Color',
            subtitle: 'Find the right color!',
            icon: const Text('🎨', style: TextStyle(fontSize: 32)),
            gradient: const LinearGradient(
              colors: [Color(0xFFEC4899), Color(0xFFA855F7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => TapTheColorGame(level: _level),
            )),
          ),
          const SizedBox(height: 14),
          GameModeCard(
            title: 'Match Colors',
            subtitle: 'Drag objects to colors!',
            icon: const Text('🎯', style: TextStyle(fontSize: 32)),
            gradient: const LinearGradient(
              colors: [Color(0xFF60A5FA), Color(0xFF22C55E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const MatchColorsGame(),
            )),
          ),
          const SizedBox(height: 18),
          Center(
            child: LevelSelector(
              current: _level,
              max: 3,
              onChanged: (v) => setState(() => _level = v),
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorChoice {
  final String name;
  final Color color;
  const _ColorChoice(this.name, this.color);
}

const _allColors = <_ColorChoice>[
  _ColorChoice('RED', Color(0xFFEF4444)),
  _ColorChoice('BLUE', Color(0xFF2563EB)),
  _ColorChoice('GREEN', Color(0xFF16A34A)),
  _ColorChoice('YELLOW', Color(0xFFEAB308)),
  _ColorChoice('PURPLE', Color(0xFF7C3AED)),
  _ColorChoice('ORANGE', Color(0xFFF97316)),
];

class TapTheColorGame extends StatefulWidget {
  final int level;
  const TapTheColorGame({super.key, required this.level});

  @override
  State<TapTheColorGame> createState() => _TapTheColorGameState();
}

class _TapTheColorGameState extends State<TapTheColorGame> {
  late _ColorChoice _target;
  late List<_ColorChoice> _options;
  bool _celebrate = false;
  int _streak = 0;
  final _rng = Random();

  @override
  void initState() {
    super.initState();
    _next();
  }

  void _next() {
    final n = widget.level == 1 ? 2 : (widget.level == 2 ? 3 : 4);
    final pool = [..._allColors]..shuffle(_rng);
    final opts = pool.take(n).toList();
    _options = opts;
    _target = opts[_rng.nextInt(opts.length)];
    _celebrate = false;
  }

  void _pick(_ColorChoice c) {
    if (c.name == _target.name) {
      setState(() {
        _celebrate = true;
        _streak++;
      });
      AppStateScope.of(context).addStars(1);
      Future.delayed(const Duration(milliseconds: 900), () {
        if (!mounted) return;
        setState(_next);
      });
    } else {
      setState(() => _streak = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: 'Colors Learning',
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
            child: Column(
              children: [
                const Text(
                  'Tap the',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1F2937),
                  ),
                ),
                ShaderMask(
                  shaderCallback: (r) => const LinearGradient(
                    colors: [Color(0xFFEC4899), Color(0xFFA855F7)],
                  ).createShader(r),
                  child: Text(
                    _target.name,
                    style: const TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const Text(
                  'color',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      for (final c in _options)
                        ChoiceTile(
                          color: c.color,
                          onTap: () => _pick(c),
                        ),
                    ],
                  ),
                ),
                if (_streak >= 2)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Streak: $_streak 🔥',
                      style: const TextStyle(
                        color: Color(0xFFEF4444),
                        fontWeight: FontWeight.w900,
                      ),
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

class _MatchPair {
  final String emoji;
  final Color color;
  final String label;
  const _MatchPair(this.emoji, this.color, this.label);
}

class MatchColorsGame extends StatefulWidget {
  const MatchColorsGame({super.key});

  @override
  State<MatchColorsGame> createState() => _MatchColorsGameState();
}

class _MatchColorsGameState extends State<MatchColorsGame> {
  static const _pairs = <_MatchPair>[
    _MatchPair('🍎', Color(0xFFEF4444), 'RED'),
    _MatchPair('🍌', Color(0xFFEAB308), 'YELLOW'),
    _MatchPair('🫐', Color(0xFF2563EB), 'BLUE'),
    _MatchPair('🥝', Color(0xFF16A34A), 'GREEN'),
    _MatchPair('🍇', Color(0xFF7C3AED), 'PURPLE'),
    _MatchPair('🥕', Color(0xFFF97316), 'ORANGE'),
  ];

  late List<_MatchPair> _round;
  final Set<String> _matched = {};
  bool _celebrate = false;

  @override
  void initState() {
    super.initState();
    _round = ([..._pairs]..shuffle()).take(3).toList();
  }

  String? _pendingObject;

  @override
  Widget build(BuildContext context) {
    final colorsLeft =
        _round.where((p) => !_matched.contains(p.label)).toList();
    return ActivityShell(
      title: 'Colors Learning',
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              children: [
                const Text(
                  'Match the objects to\ntheir colors!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
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
                    for (final p in _round)
                      ChoiceTile(
                        color: p.color,
                        label: p.label,
                        size: 110,
                        checked: _matched.contains(p.label),
                        highlight: _pendingObject == p.label,
                        onTap: () {
                          if (_pendingObject == null ||
                              _matched.contains(p.label)) return;
                          setState(() {
                            if (_pendingObject == p.label) {
                              _matched.add(p.label);
                              _pendingObject = null;
                              _celebrate = true;
                              AppStateScope.of(context).addStars(1);
                            } else {
                              _pendingObject = null;
                            }
                          });
                          if (_celebrate) {
                            Future.delayed(
                                const Duration(milliseconds: 800), () {
                              if (mounted) setState(() => _celebrate = false);
                            });
                          }
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 26),
                Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  alignment: WrapAlignment.center,
                  children: [
                    for (final p in colorsLeft)
                      GestureDetector(
                        onTap: () =>
                            setState(() => _pendingObject = p.label),
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
                            border: _pendingObject == p.label
                                ? Border.all(
                                    color: const Color(0xFFFBBF24),
                                    width: 4)
                                : null,
                          ),
                          child: Text(
                            p.emoji,
                            style: const TextStyle(fontSize: 40),
                          ),
                        ),
                      ),
                  ],
                ),
                const Spacer(),
                if (_matched.length == _round.length)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _matched.clear();
                        _round = ([..._pairs]..shuffle()).take(3).toList();
                        _pendingObject = null;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF22C55E),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 14),
                    ),
                    child: const Text(
                      'Play again',
                      style: TextStyle(fontWeight: FontWeight.w900),
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
