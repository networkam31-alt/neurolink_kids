import 'dart:math';

import 'package:flutter/material.dart';

import '../../state/app_state.dart';
import '../../widgets/activity_kit.dart';

class _Family {
  final String name;
  final String role;
  final String emoji;
  final String description;
  const _Family(this.name, this.role, this.emoji, this.description);
}

const _family = <_Family>[
  _Family('Mom', 'Mother', '👱‍♀️', 'Takes care of you'),
  _Family('Dad', 'Father', '👨', 'Plays and protects'),
  _Family('Sister', 'Sibling', '👧', 'Your best friend'),
  _Family('Brother', 'Sibling', '👦', 'Your buddy'),
  _Family('Grandma', 'Grandmother', '👵', 'Loves to cuddle'),
  _Family('Grandpa', 'Grandfather', '👴', 'Tells great stories'),
];

class FamilyScreen extends StatefulWidget {
  const FamilyScreen({super.key});

  @override
  State<FamilyScreen> createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final f = _family[_index];
    return ActivityShell(
      title: 'Family Learning',
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
                Text(f.emoji, style: const TextStyle(fontSize: 110)),
                Text(f.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                    )),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      const Text('Relation:',
                          style: TextStyle(color: Colors.white)),
                      Text(f.role,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(f.description,
                    style: const TextStyle(color: Colors.white)),
                const SizedBox(height: 12),
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.volume_up_rounded,
                      color: Color(0xFF1F2937)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text('Activities',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Color(0xFF1F2937),
              )),
          const SizedBox(height: 10),
          GameModeListTile(
            title: 'Match Family Member',
            icon: Icons.group_rounded,
            gradient: const LinearGradient(colors: [
              Color(0xFFFB7185),
              Color(0xFFFB923C),
            ]),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const _MatchFamilyGame(),
            )),
          ),
          const SizedBox(height: 10),
          GameModeListTile(
            title: 'Family Order',
            icon: Icons.list_alt_rounded,
            gradient: const LinearGradient(colors: [
              Color(0xFFFBBF24),
              Color(0xFFF97316),
            ]),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const _FamilyOrderGame(),
            )),
          ),
          const SizedBox(height: 18),
          const Text('Family Members',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Color(0xFF1F2937),
              )),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _family.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.05,
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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_family[i].emoji,
                          style: const TextStyle(fontSize: 44)),
                      const SizedBox(height: 4),
                      Text(_family[i].name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1F2937),
                          )),
                      Text(_family[i].role,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6B7280),
                          )),
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

class _MatchFamilyGame extends StatefulWidget {
  const _MatchFamilyGame();

  @override
  State<_MatchFamilyGame> createState() => _MatchFamilyGameState();
}

class _MatchFamilyGameState extends State<_MatchFamilyGame> {
  late _Family _target;
  late List<_Family> _options;
  bool _celebrate = false;
  final _rng = Random();

  @override
  void initState() {
    super.initState();
    _next();
  }

  void _next() {
    final pool = [..._family]..shuffle(_rng);
    _options = pool.take(3).toList();
    _target = _options[_rng.nextInt(_options.length)];
    _celebrate = false;
  }

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: 'Family Learning',
      backgroundColors: const [Color(0xFFFFF8EC), Color(0xFFEEF2FF)],
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: Column(
            children: [
              const Text('Who is the',
                  style:
                      TextStyle(fontSize: 18, color: Color(0xFF6B7280))),
              Text(
                _target.role,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFEC4899),
                ),
              ),
              const Text('?',
                  style: TextStyle(fontSize: 18, color: Color(0xFF6B7280))),
              const SizedBox(height: 22),
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
                        height: 130,
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(o.emoji,
                                style: const TextStyle(fontSize: 48)),
                            const SizedBox(height: 4),
                            Text(o.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF1F2937),
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

class _FamilyOrderGame extends StatefulWidget {
  const _FamilyOrderGame();

  @override
  State<_FamilyOrderGame> createState() => _FamilyOrderGameState();
}

class _FamilyOrderGameState extends State<_FamilyOrderGame> {
  static const _orderLabels = [
    'Grandparents',
    'Parents',
    'You',
    'Siblings',
  ];

  late List<String> _shuffled;
  final List<String> _placed = [];
  bool _celebrate = false;

  @override
  void initState() {
    super.initState();
    _shuffled = [..._orderLabels]..shuffle();
  }

  void _pick(String s) {
    setState(() {
      _placed.add(s);
      _shuffled.remove(s);
    });
    if (_placed.length == _orderLabels.length) {
      bool ok = true;
      for (int i = 0; i < _orderLabels.length; i++) {
        if (_placed[i] != _orderLabels[i]) {
          ok = false;
          break;
        }
      }
      if (ok) {
        AppStateScope.of(context).addStars(2);
        setState(() => _celebrate = true);
        Future.delayed(const Duration(milliseconds: 1200), () {
          if (mounted) {
            setState(() {
              _placed.clear();
              _shuffled = [..._orderLabels]..shuffle();
              _celebrate = false;
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: 'Family Learning',
      backgroundColors: const [Color(0xFFFFF8EC), Color(0xFFEEF2FF)],
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            children: [
              const Text('Tap them in order from oldest to youngest',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF6B7280))),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    for (int i = 0; i < _orderLabels.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  const Color(0xFFEC4899).withOpacity(0.1),
                              child: Text('${i + 1}',
                                  style: const TextStyle(
                                    color: Color(0xFFEC4899),
                                    fontWeight: FontWeight.w900,
                                  )),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              i < _placed.length ? _placed[i] : '',
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  for (final s in _shuffled)
                    GestureDetector(
                      onTap: () => _pick(s),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Color(0xFFFBBF24),
                            Color(0xFFF97316),
                          ]),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          s,
                          style: const TextStyle(
                            color: Colors.white,
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
      ]),
    );
  }
}
