import 'dart:math';

import 'package:flutter/material.dart';

import '../../state/app_state.dart';
import '../../widgets/activity_kit.dart';

class _Animal {
  final String name;
  final String emoji;
  final String sound;
  final String habitat;
  final String description;
  const _Animal(this.name, this.emoji, this.sound, this.habitat, this.description);
}

const _animals = <_Animal>[
  _Animal('Dog', '🐶', 'Woof Woof!', 'Home', 'A friendly pet that loves to play'),
  _Animal('Cat', '🐱', 'Meow!', 'Home', 'A playful pet that purrs'),
  _Animal('Lion', '🦁', 'Roar!', 'Savanna', 'King of the jungle'),
  _Animal('Elephant', '🐘', 'Trumpet!', 'Savanna', 'A huge gentle animal'),
  _Animal('Fish', '🐟', 'Bubble!', 'Ocean', 'Lives in water'),
  _Animal('Bird', '🐦', 'Tweet!', 'Forest', 'Flies in the sky'),
];

class AnimalsScreen extends StatefulWidget {
  const AnimalsScreen({super.key});

  @override
  State<AnimalsScreen> createState() => _AnimalsScreenState();
}

class _AnimalsScreenState extends State<AnimalsScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final a = _animals[_index];
    return ActivityShell(
      title: 'Animals Learning',
      titleColor: const Color(0xFF1F2937),
      backgroundColors: const [Color(0xFFFFF8EC), Color(0xFFEEF2FF)],
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFB7185), Color(0xFFFB923C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              children: [
                Text(a.emoji, style: const TextStyle(fontSize: 100)),
                Text(
                  a.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  a.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 14),
                _InfoChip(label: 'Sound:', value: a.sound),
                const SizedBox(height: 8),
                _InfoChip(label: 'Habitat:', value: a.habitat),
                const SizedBox(height: 12),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.volume_up_rounded,
                      color: Color(0xFF1F2937)),
                ),
              ],
            ),
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
            title: 'Guess the Sound',
            icon: Icons.music_note_rounded,
            gradient: const LinearGradient(colors: [
              Color(0xFFFB7185),
              Color(0xFFFB923C),
            ]),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const _GuessSoundGame(),
            )),
          ),
          const SizedBox(height: 10),
          GameModeListTile(
            title: 'Habitat Matching',
            icon: Icons.map_rounded,
            gradient: const LinearGradient(colors: [
              Color(0xFF60A5FA),
              Color(0xFF22C55E),
            ]),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const _HabitatMatchingGame(),
            )),
          ),
          const SizedBox(height: 10),
          GameModeListTile(
            title: 'Animal Puzzle',
            icon: Icons.extension_rounded,
            gradient: const LinearGradient(colors: [
              Color(0xFFFBBF24),
              Color(0xFFF97316),
            ]),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const _AnimalPuzzleGame(),
            )),
          ),
          const SizedBox(height: 18),
          const Text(
            'All Animals',
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
            itemCount: _animals.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.9,
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
                        ? Border.all(color: const Color(0xFF60A5FA), width: 2)
                        : null,
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_animals[i].emoji,
                          style: const TextStyle(fontSize: 32)),
                      const SizedBox(height: 4),
                      Text(
                        _animals[i].name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                    ],
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

class _InfoChip extends StatelessWidget {
  final String label;
  final String value;
  const _InfoChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              )),
          Text(value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              )),
        ],
      ),
    );
  }
}

class _GuessSoundGame extends StatefulWidget {
  const _GuessSoundGame();

  @override
  State<_GuessSoundGame> createState() => _GuessSoundGameState();
}

class _GuessSoundGameState extends State<_GuessSoundGame> {
  late _Animal _target;
  late List<_Animal> _options;
  bool _celebrate = false;
  final _rng = Random();

  @override
  void initState() {
    super.initState();
    _next();
  }

  void _next() {
    final pool = [..._animals]..shuffle(_rng);
    _options = pool.take(3).toList();
    _target = _options[_rng.nextInt(_options.length)];
    _celebrate = false;
  }

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: 'Animals Learning',
      backgroundColors: const [Color(0xFFFFF8EC), Color(0xFFEEF2FF)],
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: Column(
            children: [
              const Text('Which animal makes this sound?',
                  style: TextStyle(color: Color(0xFF6B7280))),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.volume_up_rounded,
                        size: 32, color: Color(0xFFEC4899)),
                    const SizedBox(width: 12),
                    Text(
                      _target.sound,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  for (final o in _options)
                    GestureDetector(
                      onTap: () {
                        if (o.name == _target.name) {
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Text(o.emoji,
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

class _HabitatMatchingGame extends StatefulWidget {
  const _HabitatMatchingGame();

  @override
  State<_HabitatMatchingGame> createState() => _HabitatMatchingGameState();
}

class _HabitatMatchingGameState extends State<_HabitatMatchingGame> {
  late _Animal _target;
  late List<String> _habitats;
  bool _celebrate = false;
  final _rng = Random();

  @override
  void initState() {
    super.initState();
    _next();
  }

  void _next() {
    _target = _animals[_rng.nextInt(_animals.length)];
    final pool = _animals.map((a) => a.habitat).toSet().toList()
      ..shuffle(_rng);
    _habitats = pool.take(3).toList();
    if (!_habitats.contains(_target.habitat)) {
      _habitats[0] = _target.habitat;
    }
    _habitats.shuffle(_rng);
    _celebrate = false;
  }

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: 'Animals Learning',
      backgroundColors: const [Color(0xFFFFF8EC), Color(0xFFEEF2FF)],
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            children: [
              const Text('Where does this animal live?',
                  style: TextStyle(color: Color(0xFF6B7280))),
              Text(_target.emoji, style: const TextStyle(fontSize: 110)),
              Text(_target.name,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1F2937),
                  )),
              const SizedBox(height: 22),
              for (final h in _habitats) ...[
                GestureDetector(
                  onTap: () {
                    if (h == _target.habitat) {
                      AppStateScope.of(context).addStars(1);
                      setState(() => _celebrate = true);
                      Future.delayed(const Duration(milliseconds: 800), () {
                        if (mounted) setState(_next);
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    margin: const EdgeInsets.only(bottom: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Text(
                      h,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        CelebrationOverlay(show: _celebrate),
      ]),
    );
  }
}

class _AnimalPuzzleGame extends StatefulWidget {
  const _AnimalPuzzleGame();

  @override
  State<_AnimalPuzzleGame> createState() => _AnimalPuzzleGameState();
}

class _AnimalPuzzleGameState extends State<_AnimalPuzzleGame> {
  late _Animal _target;
  late List<String> _shuffled;
  bool _celebrate = false;
  final _rng = Random();

  @override
  void initState() {
    super.initState();
    _next();
  }

  void _next() {
    _target = _animals[_rng.nextInt(_animals.length)];
    _shuffled = _target.name.split('')..shuffle(_rng);
    _celebrate = false;
  }

  final List<String> _arranged = [];

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: 'Animals Learning',
      backgroundColors: const [Color(0xFFFFF8EC), Color(0xFFEEF2FF)],
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            children: [
              const Text('Spell the animal name',
                  style: TextStyle(color: Color(0xFF6B7280))),
              Text(_target.emoji, style: const TextStyle(fontSize: 100)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < _target.name.length; i++)
                      Container(
                        width: 40,
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFFE5E7EB), width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          i < _arranged.length ? _arranged[i] : '',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  for (int i = 0; i < _shuffled.length; i++)
                    GestureDetector(
                      onTap: () {
                        if (_arranged.length >= _target.name.length) return;
                        setState(() {
                          _arranged.add(_shuffled[i]);
                          _shuffled[i] = '';
                        });
                        if (_arranged.join() == _target.name) {
                          AppStateScope.of(context).addStars(2);
                          setState(() => _celebrate = true);
                          Future.delayed(
                              const Duration(milliseconds: 1000), () {
                            if (!mounted) return;
                            setState(() {
                              _arranged.clear();
                              _next();
                            });
                          });
                        }
                      },
                      child: _shuffled[i].isEmpty
                          ? const SizedBox(width: 40, height: 50)
                          : Container(
                              width: 40,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  Color(0xFFFBBF24),
                                  Color(0xFFF97316),
                                ]),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                _shuffled[i],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => setState(() {
                  _arranged.clear();
                  _shuffled = _target.name.split('')..shuffle(_rng);
                }),
                child: const Text('Reset'),
              ),
            ],
          ),
        ),
        CelebrationOverlay(show: _celebrate),
      ]),
    );
  }
}
