import 'dart:math';

import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../data/activities.dart';

class ActivityDetailScreen extends StatefulWidget {
  final ActivityItem item;
  const ActivityDetailScreen({super.key, required this.item});

  @override
  State<ActivityDetailScreen> createState() => _ActivityDetailScreenState();
}

class _ActivityDetailScreenState extends State<ActivityDetailScreen> {
  int _index = 0;
  int _score = 0;
  String? _feedback;

  late final List<_Question> _questions = _buildQuestions(widget.item.kind);

  static List<_Question> _buildQuestions(ActivityKind k) {
    switch (k) {
      case ActivityKind.colors:
        return [
          _Question('Trouve la couleur ROUGE',
              [_Opt('Rouge', Colors.red, true), _Opt('Bleu', Colors.blue, false), _Opt('Jaune', Colors.yellow, false)]),
          _Question('Trouve la couleur VERTE',
              [_Opt('Orange', Colors.orange, false), _Opt('Vert', Colors.green, true), _Opt('Violet', Colors.purple, false)]),
          _Question('Trouve la couleur BLEUE',
              [_Opt('Bleu', Colors.blue, true), _Opt('Rose', Colors.pink, false), _Opt('Marron', Colors.brown, false)]),
        ];
      case ActivityKind.shapes:
        return [
          _Question('Quelle est la forme ronde ?',
              [_Opt('●', Colors.blue, true), _Opt('■', Colors.orange, false), _Opt('▲', Colors.green, false)]),
          _Question('Quelle est la forme carrée ?',
              [_Opt('▲', Colors.green, false), _Opt('■', Colors.orange, true), _Opt('●', Colors.blue, false)]),
          _Question('Quelle est la forme triangle ?',
              [_Opt('●', Colors.blue, false), _Opt('▲', Colors.green, true), _Opt('■', Colors.orange, false)]),
        ];
      case ActivityKind.numbers:
        return [
          _Question('Combien y a-t-il d\'étoiles ? ⭐⭐⭐',
              [_Opt('2', Colors.blue, false), _Opt('3', Colors.green, true), _Opt('4', Colors.orange, false)]),
          _Question('Quel nombre vient après 5 ?',
              [_Opt('4', Colors.orange, false), _Opt('6', Colors.green, true), _Opt('7', Colors.purple, false)]),
          _Question('Combien font 2 + 1 ?',
              [_Opt('1', Colors.blue, false), _Opt('3', Colors.orange, true), _Opt('4', Colors.green, false)]),
        ];
      case ActivityKind.words:
        return [
          _Question('Quel mot signifie "soleil" ?',
              [_Opt('🌞 Soleil', Colors.orange, true), _Opt('🌧️ Pluie', Colors.blue, false), _Opt('🌳 Arbre', Colors.green, false)]),
          _Question('Quel mot signifie "chien" ?',
              [_Opt('🐱 Chat', Colors.orange, false), _Opt('🐶 Chien', Colors.brown, true), _Opt('🐰 Lapin', Colors.pink, false)]),
          _Question('Quel mot signifie "maison" ?',
              [_Opt('🏠 Maison', Colors.blue, true), _Opt('🚗 Voiture', Colors.red, false), _Opt('📚 Livre', Colors.purple, false)]),
        ];
      case ActivityKind.emotions:
        return [
          _Question('Quelle émotion est la JOIE ?',
              [_Opt('😄 Joie', Colors.green, true), _Opt('😢 Triste', Colors.blue, false), _Opt('😠 Colère', Colors.red, false)]),
          _Question('Quelle émotion est la TRISTESSE ?',
              [_Opt('😄 Joie', Colors.green, false), _Opt('😢 Tristesse', Colors.blue, true), _Opt('😱 Peur', Colors.purple, false)]),
          _Question('Quelle émotion est la PEUR ?',
              [_Opt('😱 Peur', Colors.purple, true), _Opt('😄 Joie', Colors.green, false), _Opt('😴 Sommeil', Colors.indigo, false)]),
        ];
      case ActivityKind.animals:
        return [
          _Question('Quel animal aboie ?',
              [_Opt('🐶 Chien', Colors.brown, true), _Opt('🐱 Chat', Colors.orange, false), _Opt('🐦 Oiseau', Colors.blue, false)]),
          _Question('Quel animal vit dans l\'eau ?',
              [_Opt('🐘 Éléphant', Colors.grey, false), _Opt('🐠 Poisson', Colors.blue, true), _Opt('🦁 Lion', Colors.orange, false)]),
          _Question('Quel animal donne du lait ?',
              [_Opt('🐄 Vache', Colors.brown, true), _Opt('🐍 Serpent', Colors.green, false), _Opt('🦅 Aigle', Colors.indigo, false)]),
        ];
    }
  }

  void _select(_Opt opt) {
    if (_feedback != null) return;
    setState(() {
      if (opt.isCorrect) {
        _score++;
        _feedback = 'Bravo ! 🎉';
      } else {
        _feedback = 'Essaie encore 💪';
      }
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() {
        _feedback = null;
        if (_index < _questions.length - 1) {
          _index++;
        } else {
          _showResult();
        }
      });
    });
  }

  void _showResult() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: const Text('Activité terminée'),
        content: Text(
            'Score : $_score / ${_questions.length}\n\nContinue à pratiquer pour grandir !'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Retour'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[min(_index, _questions.length - 1)];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: widget.item.gradient),
        ),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              widget.item.gradient.colors.first.withOpacity(0.08),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text('Question ${_index + 1} / ${_questions.length}',
                    style: const TextStyle(color: AppColors.textMuted)),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: Text(q.prompt,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w900)),
                ),
                const SizedBox(height: 28),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: q.options.length == 4 ? 2 : 1,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio:
                        q.options.length == 4 ? 1.4 : 3.6,
                    children: q.options
                        .map((o) => GestureDetector(
                              onTap: () => _select(o),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: o.color,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: o.color.withOpacity(0.4),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Text(o.label,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900)),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                if (_feedback != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(_feedback!,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: AppColors.primary)),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Opt {
  final String label;
  final Color color;
  final bool isCorrect;
  const _Opt(this.label, this.color, this.isCorrect);
}

class _Question {
  final String prompt;
  final List<_Opt> options;
  const _Question(this.prompt, this.options);
}
