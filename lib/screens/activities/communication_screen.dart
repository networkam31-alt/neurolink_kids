import 'package:flutter/material.dart';

import '../../state/app_state.dart';
import '../../widgets/activity_kit.dart';

class CommunicationScreen extends StatelessWidget {
  const CommunicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: 'Communication',
      titleColor: const Color(0xFFEC4899),
      backgroundColors: const [Color(0xFFFCE7F3), Color(0xFFFFF7ED)],
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          GameModeListTile(
            title: 'Tap to Speak',
            icon: Icons.record_voice_over_rounded,
            gradient: const LinearGradient(colors: [
              Color(0xFFEC4899),
              Color(0xFFA855F7),
            ]),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const _PhraseBoardScreen(),
            )),
          ),
          const SizedBox(height: 10),
          GameModeListTile(
            title: 'Build a Sentence',
            icon: Icons.auto_awesome_motion_rounded,
            gradient: const LinearGradient(colors: [
              Color(0xFFFBBF24),
              Color(0xFFF97316),
            ]),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const _SentenceBuilderScreen(),
            )),
          ),
        ],
      ),
    );
  }
}

class _PhraseBoardScreen extends StatefulWidget {
  const _PhraseBoardScreen();

  @override
  State<_PhraseBoardScreen> createState() => _PhraseBoardScreenState();
}

class _PhraseBoardScreenState extends State<_PhraseBoardScreen> {
  static const _phrases = <(String, String, List<Color>)>[
    ('👋', 'Hello', [Color(0xFF60A5FA), Color(0xFF22D3EE)]),
    ('🤚', 'Stop please', [Color(0xFFEF4444), Color(0xFFF97316)]),
    ('🍽️', 'I\'m hungry', [Color(0xFFFBBF24), Color(0xFFF97316)]),
    ('💧', 'I\'m thirsty', [Color(0xFF38BDF8), Color(0xFF60A5FA)]),
    ('🚻', 'Bathroom please', [Color(0xFFA855F7), Color(0xFF7C3AED)]),
    ('🤝', 'Thank you', [Color(0xFF22C55E), Color(0xFF14B8A6)]),
    ('🤗', 'I need a hug', [Color(0xFFEC4899), Color(0xFFFB7185)]),
    ('😴', 'I\'m tired', [Color(0xFF818CF8), Color(0xFFA855F7)]),
    ('▶️', 'Play with me', [Color(0xFFFBBF24), Color(0xFFF59E0B)]),
    ('❌', 'No', [Color(0xFFEF4444), Color(0xFFEC4899)]),
    ('✅', 'Yes', [Color(0xFF22C55E), Color(0xFF14B8A6)]),
    ('🙋', 'Help me please', [Color(0xFF60A5FA), Color(0xFF818CF8)]),
  ];

  String? _spoken;

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: 'Communication',
      backgroundColors: const [Color(0xFFFCE7F3), Color(0xFFFFF7ED)],
      child: Column(
        children: [
          if (_spoken != null)
            Container(
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              padding: const EdgeInsets.symmetric(
                  horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.volume_up_rounded,
                      color: Color(0xFFEC4899)),
                  const SizedBox(width: 8),
                  Text(
                    _spoken!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              itemCount: _phrases.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (_, i) {
                final p = _phrases[i];
                return GestureDetector(
                  onTap: () {
                    setState(() => _spoken = p.$2);
                    AppStateScope.of(context).addStars(1);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: p.$3),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(p.$1, style: const TextStyle(fontSize: 38)),
                        const SizedBox(height: 4),
                        Text(
                          p.$2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SentenceBuilderScreen extends StatefulWidget {
  const _SentenceBuilderScreen();

  @override
  State<_SentenceBuilderScreen> createState() =>
      _SentenceBuilderScreenState();
}

class _SentenceBuilderScreenState extends State<_SentenceBuilderScreen> {
  static const _subjects = ['I', 'You', 'Mom', 'Dad'];
  static const _actions = ['want', 'see', 'love', 'eat'];
  static const _objects = ['apple 🍎', 'cat 🐱', 'water 💧', 'book 📖'];

  String? _s, _a, _o;
  String? _spoken;

  @override
  Widget build(BuildContext context) {
    final canSpeak = _s != null && _a != null && _o != null;
    return ActivityShell(
      title: 'Communication',
      backgroundColors: const [Color(0xFFFCE7F3), Color(0xFFFFF7ED)],
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const Icon(Icons.chat_bubble_rounded,
                    color: Color(0xFFEC4899)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _spoken ??
                        '${_s ?? '___'} ${_a ?? '___'} ${_o ?? '___'}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _ChipRow(
            label: 'Subject',
            options: _subjects,
            selected: _s,
            color: const Color(0xFFEC4899),
            onTap: (v) => setState(() => _s = v),
          ),
          const SizedBox(height: 12),
          _ChipRow(
            label: 'Action',
            options: _actions,
            selected: _a,
            color: const Color(0xFF60A5FA),
            onTap: (v) => setState(() => _a = v),
          ),
          const SizedBox(height: 12),
          _ChipRow(
            label: 'Object',
            options: _objects,
            selected: _o,
            color: const Color(0xFFFBBF24),
            onTap: (v) => setState(() => _o = v),
          ),
          const SizedBox(height: 18),
          GestureDetector(
            onTap: canSpeak
                ? () {
                    setState(() => _spoken = '$_s $_a $_o');
                    AppStateScope.of(context).addStars(2);
                  }
                : null,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                gradient: canSpeak
                    ? const LinearGradient(colors: [
                        Color(0xFF22C55E),
                        Color(0xFF14B8A6),
                      ])
                    : null,
                color: canSpeak ? null : const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.record_voice_over_rounded,
                        color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      canSpeak ? 'Speak!' : 'Build your sentence',
                      style: TextStyle(
                        color: canSpeak ? Colors.white : Colors.white70,
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

class _ChipRow extends StatelessWidget {
  final String label;
  final List<String> options;
  final String? selected;
  final Color color;
  final ValueChanged<String> onTap;
  const _ChipRow({
    required this.label,
    required this.options,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final o in options)
                GestureDetector(
                  onTap: () => onTap(o),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected == o ? color : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: color, width: 2),
                    ),
                    child: Text(
                      o,
                      style: TextStyle(
                        color: selected == o ? Colors.white : color,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
