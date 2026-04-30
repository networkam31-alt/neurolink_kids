import 'dart:math';

import 'package:flutter/material.dart';

import '../../state/app_state.dart';
import '../../widgets/activity_kit.dart';

class _Emotion {
  final String name;
  final String emoji;
  final List<Color> gradient;
  const _Emotion(this.name, this.emoji, this.gradient);
}

const _emotions = <_Emotion>[
  _Emotion('Happy', '😊', [Color(0xFFFBBF24), Color(0xFFF59E0B)]),
  _Emotion('Sad', '😢', [Color(0xFF60A5FA), Color(0xFF38BDF8)]),
  _Emotion('Angry', '😡', [Color(0xFFEF4444), Color(0xFFF97316)]),
  _Emotion('Scared', '😨', [Color(0xFFA855F7), Color(0xFF7C3AED)]),
  _Emotion('Excited', '🤩', [Color(0xFFEC4899), Color(0xFFFBBF24)]),
  _Emotion('Calm', '😌', [Color(0xFF34D399), Color(0xFF14B8A6)]),
];

class EmotionsScreen extends StatelessWidget {
  const EmotionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: 'Émotions',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          GameModeListTile(
            title: 'How do you feel today?',
            icon: Icons.mood_rounded,
            gradient: const LinearGradient(colors: [
              Color(0xFFEC4899),
              Color(0xFFA855F7),
            ]),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const _MoodGame(),
            )),
          ),
          const SizedBox(height: 10),
          GameModeListTile(
            title: 'Match the Emotion',
            icon: Icons.face_rounded,
            gradient: const LinearGradient(colors: [
              Color(0xFFFB7185),
              Color(0xFFFB923C),
            ]),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const _MatchEmotionGame(),
            )),
          ),
          const SizedBox(height: 10),
          GameModeListTile(
            title: 'Scenario Emotion',
            icon: Icons.menu_book_rounded,
            gradient: const LinearGradient(colors: [
              Color(0xFFFBBF24),
              Color(0xFFF97316),
            ]),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const _ScenarioEmotionGame(),
            )),
          ),
          const SizedBox(height: 10),
          GameModeListTile(
            title: 'Emotion Intensity',
            icon: Icons.speed_rounded,
            gradient: const LinearGradient(colors: [
              Color(0xFF60A5FA),
              Color(0xFF22C55E),
            ]),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const _IntensityGame(),
            )),
          ),
          const SizedBox(height: 18),
          const Text('All Emotions',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Color(0xFF1F2937),
              )),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _emotions.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (_, i) {
              final e = _emotions[i];
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: e.gradient),
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(e.emoji, style: const TextStyle(fontSize: 36)),
                    const SizedBox(height: 4),
                    Text(e.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        )),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MoodGame extends StatefulWidget {
  const _MoodGame();

  @override
  State<_MoodGame> createState() => _MoodGameState();
}

class _MoodGameState extends State<_MoodGame> {
  _Emotion? _picked;

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: 'Émotions',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        child: Column(
          children: [
            const Text(
              'How do you feel today?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: GridView.builder(
                itemCount: _emotions.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 1,
                ),
                itemBuilder: (_, i) {
                  final e = _emotions[i];
                  final selected = _picked?.name == e.name;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _picked = e);
                      AppStateScope.of(context).addStars(1);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: e.gradient),
                        borderRadius: BorderRadius.circular(20),
                        border: selected
                            ? Border.all(color: Colors.white, width: 5)
                            : null,
                        boxShadow: [
                          BoxShadow(
                            color: e.gradient.first.withOpacity(0.3),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(e.emoji,
                              style: const TextStyle(fontSize: 60)),
                          Text(e.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                              )),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_picked != null)
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Text(
                  'You feel ${_picked!.name.toLowerCase()} today ${_picked!.emoji}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MatchEmotionGame extends StatefulWidget {
  const _MatchEmotionGame();

  @override
  State<_MatchEmotionGame> createState() => _MatchEmotionGameState();
}

class _MatchEmotionGameState extends State<_MatchEmotionGame> {
  late _Emotion _target;
  late List<_Emotion> _options;
  bool _celebrate = false;
  final _rng = Random();

  @override
  void initState() {
    super.initState();
    _next();
  }

  void _next() {
    final pool = [..._emotions]..shuffle(_rng);
    _options = pool.take(3).toList();
    _target = _options[_rng.nextInt(_options.length)];
    _celebrate = false;
  }

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: 'Émotions',
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: Column(
            children: [
              const Text('Find the emotion:',
                  style: TextStyle(color: Color(0xFF6B7280))),
              Text(_target.name,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFEC4899),
                  )),
              const SizedBox(height: 22),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  for (final e in _options)
                    GestureDetector(
                      onTap: () {
                        if (e.name == _target.name) {
                          AppStateScope.of(context).addStars(1);
                          setState(() => _celebrate = true);
                          Future.delayed(
                              const Duration(milliseconds: 800), () {
                            if (mounted) setState(_next);
                          });
                        }
                      },
                      child: Container(
                        width: 110,
                        height: 110,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: e.gradient),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(e.emoji,
                            style: const TextStyle(fontSize: 56)),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        CelebrationOverlay(show: _celebrate),
      ]),
    );
  }
}

class _Scenario {
  final String text;
  final String emotion;
  const _Scenario(this.text, this.emotion);
}

class _ScenarioEmotionGame extends StatefulWidget {
  const _ScenarioEmotionGame();

  @override
  State<_ScenarioEmotionGame> createState() =>
      _ScenarioEmotionGameState();
}

class _ScenarioEmotionGameState extends State<_ScenarioEmotionGame> {
  static const _scenarios = <_Scenario>[
    _Scenario('Your friend gives you a present 🎁', 'Happy'),
    _Scenario('Your favorite toy is broken 😞', 'Sad'),
    _Scenario('You hear a loud thunder ⛈️', 'Scared'),
    _Scenario('Someone takes your snack', 'Angry'),
    _Scenario('You finished a hard puzzle!', 'Excited'),
    _Scenario('You take a deep breath in a quiet room', 'Calm'),
  ];

  int _i = 0;
  bool _celebrate = false;

  @override
  Widget build(BuildContext context) {
    final s = _scenarios[_i];
    final pool = [..._emotions]..shuffle();
    final opts = [
      _emotions.firstWhere((e) => e.name == s.emotion),
      ...pool.where((e) => e.name != s.emotion).take(2),
    ]..shuffle();
    return ActivityShell(
      title: 'Émotions',
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  s.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text('How would you feel?',
                  style: TextStyle(color: Color(0xFF6B7280))),
              const SizedBox(height: 12),
              Wrap(
                spacing: 14,
                runSpacing: 14,
                alignment: WrapAlignment.center,
                children: [
                  for (final e in opts)
                    GestureDetector(
                      onTap: () {
                        if (e.name == s.emotion) {
                          AppStateScope.of(context).addStars(1);
                          setState(() => _celebrate = true);
                          Future.delayed(
                              const Duration(milliseconds: 900), () {
                            if (mounted) {
                              setState(() {
                                _i = (_i + 1) % _scenarios.length;
                                _celebrate = false;
                              });
                            }
                          });
                        }
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: e.gradient),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(e.emoji,
                                style: const TextStyle(fontSize: 38)),
                            Text(e.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                )),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        CelebrationOverlay(show: _celebrate),
      ]),
    );
  }
}

class _IntensityGame extends StatefulWidget {
  const _IntensityGame();

  @override
  State<_IntensityGame> createState() => _IntensityGameState();
}

class _IntensityGameState extends State<_IntensityGame> {
  double _v = 0.5;
  _Emotion _e = _emotions[0];

  String get _label {
    if (_v < 0.34) return 'A little';
    if (_v < 0.67) return 'Medium';
    return 'A lot';
  }

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: 'Émotions',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          children: [
            const Text('Pick an emotion',
                style: TextStyle(color: Color(0xFF6B7280))),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                for (final e in _emotions)
                  GestureDetector(
                    onTap: () => setState(() => _e = e),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: e.gradient),
                        borderRadius: BorderRadius.circular(14),
                        border: _e.name == e.name
                            ? Border.all(color: Colors.white, width: 3)
                            : null,
                      ),
                      child: Text('${e.emoji} ${e.name}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          )),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            Text(_e.emoji, style: const TextStyle(fontSize: 90)),
            Text(
              'I feel $_label ${_e.name.toLowerCase()}',
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 14),
            Slider(
              value: _v,
              onChanged: (v) => setState(() => _v = v),
              activeColor: _e.gradient.first,
            ),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: () => AppStateScope.of(context).addStars(1),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF22C55E),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28)),
                padding: const EdgeInsets.symmetric(
                    horizontal: 28, vertical: 12),
              ),
              child: const Text('Save my feeling',
                  style: TextStyle(fontWeight: FontWeight.w900)),
            ),
          ],
        ),
      ),
    );
  }
}
