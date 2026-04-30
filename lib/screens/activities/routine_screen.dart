import 'package:flutter/material.dart';

import '../../state/app_state.dart';
import '../../widgets/activity_kit.dart';

class _Step {
  final String emoji;
  final String label;
  const _Step(this.emoji, this.label);
}

class _Routine {
  final String name;
  final String emoji;
  final List<Color> gradient;
  final List<_Step> steps;
  const _Routine(this.name, this.emoji, this.gradient, this.steps);
}

const _routines = <_Routine>[
  _Routine(
    'Morning',
    '🌅',
    [Color(0xFFFBBF24), Color(0xFFF97316)],
    [
      _Step('☀️', 'Wake up'),
      _Step('🪥', 'Brush teeth'),
      _Step('🧴', 'Wash face'),
      _Step('👕', 'Get dressed'),
      _Step('🥣', 'Eat breakfast'),
    ],
  ),
  _Routine(
    'School',
    '🏫',
    [Color(0xFF60A5FA), Color(0xFF818CF8)],
    [
      _Step('🎒', 'Pack bag'),
      _Step('🚌', 'Go to school'),
      _Step('📚', 'Listen in class'),
      _Step('🍱', 'Eat lunch'),
      _Step('🤝', 'Play with friends'),
    ],
  ),
  _Routine(
    'Night',
    '🌙',
    [Color(0xFF7C3AED), Color(0xFFEC4899)],
    [
      _Step('🍽️', 'Eat dinner'),
      _Step('🛁', 'Take bath'),
      _Step('👕', 'Pajamas on'),
      _Step('📖', 'Read a story'),
      _Step('😴', 'Sleep tight'),
    ],
  ),
];

class RoutineScreen extends StatefulWidget {
  const RoutineScreen({super.key});

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  int _index = 0;
  final Map<int, Set<int>> _checked = {0: {}, 1: {}, 2: {}};

  @override
  Widget build(BuildContext context) {
    final r = _routines[_index];
    final done = _checked[_index]!.length;
    return ActivityShell(
      title: 'Routine',
      titleColor: const Color(0xFF60A5FA),
      backgroundColors: const [Color(0xFFE0F2FE), Color(0xFFEDE9FE)],
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          Row(
            children: [
              for (int i = 0; i < _routines.length; i++) ...[
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _index = i),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        gradient: _index == i
                            ? LinearGradient(colors: _routines[i].gradient)
                            : null,
                        color: _index == i ? null : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Text(_routines[i].emoji,
                              style: const TextStyle(fontSize: 22)),
                          Text(
                            _routines[i].name,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: _index == i
                                  ? Colors.white
                                  : const Color(0xFF1F2937),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(r.emoji, style: const TextStyle(fontSize: 28)),
                    const SizedBox(width: 8),
                    Text('${r.name} routine',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1F2937),
                        )),
                  ],
                ),
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: done / r.steps.length,
                  backgroundColor: const Color(0xFFE5E7EB),
                  color: r.gradient.first,
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(10),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text('$done / ${r.steps.length} done',
                      style: const TextStyle(
                          color: Color(0xFF6B7280), fontSize: 12)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          for (int i = 0; i < r.steps.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (_checked[_index]!.contains(i)) {
                      _checked[_index]!.remove(i);
                    } else {
                      _checked[_index]!.add(i);
                      AppStateScope.of(context).addStars(1);
                    }
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: _checked[_index]!.contains(i)
                        ? Border.all(
                            color: const Color(0xFF22C55E), width: 2)
                        : null,
                  ),
                  child: Row(
                    children: [
                      Text(r.steps[i].emoji,
                          style: const TextStyle(fontSize: 28)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          r.steps[i].label,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: _checked[_index]!.contains(i)
                                ? const Color(0xFF22C55E)
                                : const Color(0xFF1F2937),
                            decoration: _checked[_index]!.contains(i)
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                      ),
                      Icon(
                        _checked[_index]!.contains(i)
                            ? Icons.check_circle_rounded
                            : Icons.radio_button_unchecked_rounded,
                        color: _checked[_index]!.contains(i)
                            ? const Color(0xFF22C55E)
                            : const Color(0xFF9CA3AF),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (done == r.steps.length)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: r.gradient),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                children: [
                  Text('🎉', style: TextStyle(fontSize: 32)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'You finished your routine! Great job!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
