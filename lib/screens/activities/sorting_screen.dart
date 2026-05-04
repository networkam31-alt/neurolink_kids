import 'package:flutter/material.dart';

import '../../state/app_state.dart';
import '../../widgets/activity_kit.dart';

class SortingScreen extends StatelessWidget {
  const SortingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: 'Sorting Game',
      titleColor: const Color(0xFF14B8A6),
      backgroundColors: const [Color(0xFFE7FBE7), Color(0xFFE0F2FE)],
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          GameModeCard(
            title: 'Sort by Colors',
            subtitle: 'Drag items to color buckets',
            icon: const Text('🎨', style: TextStyle(fontSize: 32)),
            gradient: const LinearGradient(colors: [
              Color(0xFFEC4899),
              Color(0xFFA855F7),
            ]),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const _SortByColorGame(),
            )),
          ),
          const SizedBox(height: 14),
          GameModeCard(
            title: 'Food vs Animals',
            subtitle: 'Sort food and animals',
            icon: const Text('🍎', style: TextStyle(fontSize: 32)),
            gradient: const LinearGradient(colors: [
              Color(0xFFFBBF24),
              Color(0xFFF97316),
            ]),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const _FoodAnimalsGame(),
            )),
          ),
          const SizedBox(height: 14),
          GameModeCard(
            title: 'Sort Shapes',
            subtitle: 'Match shapes to bins',
            icon: const Text('▲', style: TextStyle(fontSize: 32)),
            gradient: const LinearGradient(colors: [
              Color(0xFF60A5FA),
              Color(0xFF22C55E),
            ]),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const _ShapesSortGame(),
            )),
          ),
        ],
      ),
    );
  }
}

class _Item {
  final String id;
  final String emoji;
  final String category;
  _Item(this.id, this.emoji, this.category);
}

class _SortGameBase extends StatefulWidget {
  final String title;
  final List<_Item> items;
  final Map<String, _Bucket> buckets;
  const _SortGameBase({
    required this.title,
    required this.items,
    required this.buckets,
  });

  @override
  State<_SortGameBase> createState() => _SortGameBaseState();
}

class _Bucket {
  final String label;
  final Color color;
  final String emoji;
  _Bucket(this.label, this.color, this.emoji);
}

class _SortGameBaseState extends State<_SortGameBase> {
  late List<_Item> _remaining;
  final Map<String, List<_Item>> _placed = {};
  bool _celebrate = false;

  @override
  void initState() {
    super.initState();
    _remaining = [...widget.items]..shuffle();
    for (final k in widget.buckets.keys) {
      _placed[k] = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: widget.title,
      titleColor: const Color(0xFF14B8A6),
      backgroundColors: const [Color(0xFFE7FBE7), Color(0xFFE0F2FE)],
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            children: [
              const Text('Drag each item to the correct bucket',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF6B7280))),
              const SizedBox(height: 12),
              SizedBox(
                height: 120,
                child: Center(
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      for (final item in _remaining)
                        Draggable<_Item>(
                          data: item,
                          feedback: _ItemTile(item: item, dragging: true),
                          childWhenDragging: const SizedBox(
                              width: 70, height: 70),
                          child: _ItemTile(item: item),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: GridView(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.85,
                  ),
                  children: [
                    for (final entry in widget.buckets.entries)
                      DragTarget<_Item>(
                        onAcceptWithDetails: (details) {
                          final it = details.data;
                          if (it.category == entry.key) {
                            setState(() {
                              _placed[entry.key]!.add(it);
                              _remaining.remove(it);
                              if (_remaining.isEmpty) {
                                _celebrate = true;
                                AppStateScope.of(context).addStars(3);
                              }
                            });
                            if (_remaining.isEmpty) {
                              Future.delayed(
                                  const Duration(milliseconds: 1200),
                                  () {
                                if (mounted) {
                                  setState(() {
                                    _remaining = [...widget.items]..shuffle();
                                    for (final k in widget.buckets.keys) {
                                      _placed[k]!.clear();
                                    }
                                    _celebrate = false;
                                  });
                                }
                              });
                            }
                          }
                        },
                        builder: (context, candidate, _) {
                          final hover = candidate.isNotEmpty;
                          final b = entry.value;
                          return Container(
                            decoration: BoxDecoration(
                              color: hover
                                  ? b.color
                                  : b.color.withOpacity(0.85),
                              borderRadius: BorderRadius.circular(20),
                              border: hover
                                  ? Border.all(
                                      color: Colors.white, width: 4)
                                  : null,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.center,
                              children: [
                                Text(b.emoji,
                                    style: const TextStyle(fontSize: 32)),
                                Text(
                                  b.label,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const Spacer(),
                                Wrap(
                                  spacing: 4,
                                  children: [
                                    for (final p in _placed[entry.key]!)
                                      Text(p.emoji,
                                          style:
                                              const TextStyle(fontSize: 22)),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        CelebrationOverlay(show: _celebrate),
      ]),
    );
  }
}

class _ItemTile extends StatelessWidget {
  final _Item item;
  final bool dragging;
  const _ItemTile({required this.item, this.dragging = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 70,
        height: 70,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(dragging ? 0.18 : 0.08),
              blurRadius: dragging ? 16 : 6,
              offset: Offset(0, dragging ? 8 : 3),
            ),
          ],
        ),
        child: Text(item.emoji, style: const TextStyle(fontSize: 36)),
      ),
    );
  }
}

class _SortByColorGame extends StatelessWidget {
  const _SortByColorGame();

  @override
  Widget build(BuildContext context) {
    return _SortGameBase(
      title: 'Sorting Game',
      items: [
        _Item('a', '🍎', 'red'),
        _Item('b', '🍓', 'red'),
        _Item('c', '🍌', 'yellow'),
        _Item('d', '⭐', 'yellow'),
        _Item('e', '🫐', 'blue'),
        _Item('f', '🐳', 'blue'),
      ],
      buckets: {
        'red': _Bucket('Red', const Color(0xFFEF4444), '🔴'),
        'yellow': _Bucket('Yellow', const Color(0xFFEAB308), '🟡'),
        'blue': _Bucket('Blue', const Color(0xFF2563EB), '🔵'),
      },
    );
  }
}

class _FoodAnimalsGame extends StatelessWidget {
  const _FoodAnimalsGame();

  @override
  Widget build(BuildContext context) {
    return _SortGameBase(
      title: 'Sorting Game',
      items: [
        _Item('a', '🍎', 'food'),
        _Item('b', '🍕', 'food'),
        _Item('c', '🍌', 'food'),
        _Item('d', '🐶', 'animal'),
        _Item('e', '🐱', 'animal'),
        _Item('f', '🦁', 'animal'),
      ],
      buckets: {
        'food': _Bucket('Food', const Color(0xFFF97316), '🍽️'),
        'animal': _Bucket('Animals', const Color(0xFF22C55E), '🐾'),
      },
    );
  }
}

class _ShapesSortGame extends StatelessWidget {
  const _ShapesSortGame();

  @override
  Widget build(BuildContext context) {
    return _SortGameBase(
      title: 'Sorting Game',
      items: [
        _Item('a', '⭕', 'circle'),
        _Item('b', '🔵', 'circle'),
        _Item('c', '🟦', 'square'),
        _Item('d', '⬛', 'square'),
        _Item('e', '🔺', 'triangle'),
        _Item('f', '▲', 'triangle'),
      ],
      buckets: {
        'circle': _Bucket('Circle', const Color(0xFF60A5FA), '⭕'),
        'square': _Bucket('Square', const Color(0xFFEC4899), '⬛'),
        'triangle': _Bucket('Triangle', const Color(0xFFFBBF24), '▲'),
      },
    );
  }
}
