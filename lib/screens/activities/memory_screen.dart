import 'dart:async';

import 'package:flutter/material.dart';

import '../../state/app_state.dart';
import '../../widgets/activity_kit.dart';

enum _Theme { animals, letters, objects }

class MemoryScreen extends StatefulWidget {
  const MemoryScreen({super.key});

  @override
  State<MemoryScreen> createState() => _MemoryScreenState();
}

class _MemoryScreenState extends State<MemoryScreen> {
  int _grid = 4; // 4 = 2x2, 9 = 3x3 (we'll use 8 to make 4 pairs), 16 = 4x4
  _Theme _theme = _Theme.animals;
  late List<String> _cards;
  late List<bool> _flipped;
  late List<bool> _matched;
  int? _firstIndex;
  int _moves = 0;
  int _matches = 0;
  int _seconds = 0;
  Timer? _timer;
  bool _busy = false;

  static const _animalSet = ['🐶', '🐱', '🐰', '🦊', '🐻', '🐼', '🐨', '🐯'];
  static const _letterSet = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
  static const _objectSet = ['🍎', '⭐', '🎈', '🌸', '🚗', '⚽', '🌈', '🎁'];

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _start() {
    final pairs = (_grid / 2).floor();
    final source = switch (_theme) {
      _Theme.animals => _animalSet,
      _Theme.letters => _letterSet,
      _Theme.objects => _objectSet,
    };
    final picks = source.take(pairs).toList();
    _cards = [...picks, ...picks]..shuffle();
    _flipped = List.filled(_cards.length, false);
    _matched = List.filled(_cards.length, false);
    _firstIndex = null;
    _moves = 0;
    _matches = 0;
    _seconds = 0;
    _busy = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _seconds++);
    });
  }

  void _tap(int i) {
    if (_busy || _flipped[i] || _matched[i]) return;
    setState(() => _flipped[i] = true);
    if (_firstIndex == null) {
      _firstIndex = i;
    } else {
      _moves++;
      final a = _firstIndex!;
      _firstIndex = null;
      if (_cards[a] == _cards[i]) {
        setState(() {
          _matched[a] = true;
          _matched[i] = true;
          _matches++;
        });
        if (_matches == _cards.length / 2) {
          _timer?.cancel();
          AppStateScope.of(context).addStars(3);
        }
      } else {
        _busy = true;
        Future.delayed(const Duration(milliseconds: 700), () {
          if (!mounted) return;
          setState(() {
            _flipped[a] = false;
            _flipped[i] = false;
            _busy = false;
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cols = _grid <= 4 ? 2 : (_grid <= 9 ? 3 : 4);
    return ActivityShell(
      title: 'Memory Cards',
      titleColor: const Color(0xFF7C3AED),
      backgroundColors: const [Color(0xFFF5E9FF), Color(0xFFEAF2FF)],
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          Row(
            children: [
              for (final s in [
                ('Easy', 4),
                ('Medium', 8),
                ('Hard', 16),
              ]) ...[
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() {
                      _grid = s.$2;
                      _start();
                    }),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _grid == s.$2
                            ? const Color(0xFF7C3AED)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        s.$1,
                        style: TextStyle(
                          color: _grid == s.$2
                              ? Colors.white
                              : const Color(0xFF1F2937),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              for (final t in _Theme.values) ...[
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() {
                      _theme = t;
                      _start();
                    }),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _theme == t
                            ? const Color(0xFFFBBF24)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        t.name[0].toUpperCase() + t.name.substring(1),
                        style: TextStyle(
                          color: _theme == t
                              ? Colors.white
                              : const Color(0xFF1F2937),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StatChip(label: 'Matches', value: '$_matches'),
              _StatChip(label: 'Moves', value: '$_moves'),
              _StatChip(label: 'Time', value: '${_seconds}s'),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _cards.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemBuilder: (_, i) {
              final shown = _flipped[i] || _matched[i];
              return GestureDetector(
                onTap: () => _tap(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    gradient: shown
                        ? const LinearGradient(colors: [
                            Color(0xFFFBBF24),
                            Color(0xFFF97316),
                          ])
                        : const LinearGradient(colors: [
                            Color(0xFF7C3AED),
                            Color(0xFFA855F7),
                          ]),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: shown
                      ? Text(
                          _cards[i],
                          style: const TextStyle(
                            fontSize: 38,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        )
                      : const Icon(Icons.help_rounded,
                          color: Colors.white, size: 36),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          if (_matches == _cards.length / 2)
            Center(
              child: ElevatedButton(
                onPressed: () => setState(_start),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF22C55E),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 14),
                ),
                child: const Text('You won! Play again',
                    style: TextStyle(fontWeight: FontWeight.w900)),
              ),
            ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(label,
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 12,
              )),
          Text(value,
              style: const TextStyle(
                color: Color(0xFF1F2937),
                fontSize: 18,
                fontWeight: FontWeight.w900,
              )),
        ],
      ),
    );
  }
}
