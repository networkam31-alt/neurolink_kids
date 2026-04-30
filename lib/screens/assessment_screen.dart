import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../widgets/kids_background.dart';
import 'assessment_results_screen.dart';

class AssessmentCategory {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> questions;
  const AssessmentCategory({
    required this.title,
    required this.icon,
    required this.color,
    required this.questions,
  });
}

const assessmentCategories = <AssessmentCategory>[
  AssessmentCategory(
    title: 'Communication sociale',
    icon: Icons.groups_2_rounded,
    color: Color(0xFF22C55E),
    questions: [
      'A-t-il/elle des difficultés à maintenir un contact visuel ?',
      'Répond-il/elle à son prénom quand on l\'appelle ?',
      "A-t-il/elle du mal à exprimer ses besoins verbalement ?",
      "Initie-t-il/elle des conversations spontanément ?",
      "Comprend-il/elle les consignes simples ?",
      "Imite-t-il/elle les gestes ou expressions des autres ?",
      "Partage-t-il/elle ses centres d'intérêt avec d'autres ?",
      "Utilise-t-il/elle des phrases complètes adaptées à son âge ?",
      "Comprend-il/elle le second degré ou l'humour ?",
      "Joue-t-il/elle de manière coopérative avec d'autres enfants ?",
    ],
  ),
  AssessmentCategory(
    title: 'Comportements et routines',
    icon: Icons.chat_bubble_rounded,
    color: Color(0xFF3B82F6),
    questions: [
      "Insiste-t-il/elle sur des routines précises ?",
      "Réagit-il/elle fortement aux changements ?",
      "Présente-t-il/elle des mouvements répétitifs (balancement, battement des mains) ?",
      "Aligne-t-il/elle ses jouets de manière obsessionnelle ?",
      "A-t-il/elle des intérêts très restreints ou intenses ?",
      "Refuse-t-il/elle d'essayer de nouvelles activités ?",
      "Devient-il/elle anxieux/se face à l'imprévu ?",
      "Répète-t-il/elle les mêmes phrases ou questions ?",
      "Fixe-t-il/elle longuement des objets en mouvement ?",
      "Réagit-il/elle violemment aux interruptions ?",
    ],
  ),
  AssessmentCategory(
    title: 'Sensibilité sensorielle',
    icon: Icons.headphones,
    color: Color(0xFF334155),
    questions: [
      "Couvre-t-il/elle ses oreilles aux sons forts ?",
      "Refuse-t-il/elle certains vêtements à cause de leur texture ?",
      "Évite-t-il/elle certaines lumières ou couleurs ?",
      "Recherche-t-il/elle activement la pression ou le toucher ?",
      "Est-il/elle dérangé(e) par certains aliments (texture, odeur) ?",
      "Tolère-t-il/elle mal les environnements bruyants ?",
      "Sent/lèche-t-il/elle des objets non comestibles ?",
      "Tourne-t-il/elle sur lui/elle-même sans étourdissement ?",
      "Évite-t-il/elle le contact physique inattendu ?",
      "Semble-t-il/elle peu sensible à la douleur ou à la chaleur ?",
    ],
  ),
  AssessmentCategory(
    title: 'Régulation émotionnelle',
    icon: Icons.favorite_rounded,
    color: Color(0xFFEC4899),
    questions: [
      "Exprime-t-il/elle clairement ses émotions ?",
      "Identifie-t-il/elle les émotions des autres ?",
      "Se calme-t-il/elle facilement après une crise ?",
      "Cherche-t-il/elle du réconfort auprès des proches ?",
      "Manifeste-t-il/elle de l'empathie ?",
      "Réagit-il/elle de façon adaptée à la frustration ?",
      "Tolère-t-il/elle le fait de perdre ?",
      "Joue-t-il/elle à des jeux d'imagination ?",
      "Comprend-il/elle les règles sociales de base ?",
      "Préfère-t-il/elle jouer seul(e) ?",
    ],
  ),
  AssessmentCategory(
    title: 'Vie quotidienne et développement',
    icon: Icons.auto_awesome,
    color: Color(0xFF22C55E),
    questions: [
      "Mange-t-il/elle de manière autonome ?",
      "S'habille-t-il/elle seul(e) ?",
      "Dort-il/elle de façon stable ?",
      "A-t-il/elle du mal à se concentrer ?",
      "Apprend-il/elle facilement de nouvelles compétences ?",
      "Termine-t-il/elle les tâches commencées ?",
      "Suit-il/elle des consignes en plusieurs étapes ?",
      "Gère-t-il/elle les transitions entre activités ?",
      "Présente-t-il/elle un retard de motricité fine ?",
      "Présente-t-il/elle un retard de motricité globale ?",
    ],
  ),
];

const _answers = [
  ('0 - Jamais', AppColors.accentGreen),
  ('1 - Rarement', Color(0xFF60A5FA)),
  ('2 - Parfois', Color(0xFFFBBF24)),
  ('3 - Souvent', Color(0xFFFB923C)),
  ('4 - Toujours', AppColors.accentRed),
];

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  int _index = 0;
  final Map<int, int> _responses = {};

  int get _total =>
      assessmentCategories.fold(0, (sum, c) => sum + c.questions.length);

  ({AssessmentCategory cat, int qInCat}) _locate(int globalIndex) {
    int remaining = globalIndex;
    for (final c in assessmentCategories) {
      if (remaining < c.questions.length) {
        return (cat: c, qInCat: remaining);
      }
      remaining -= c.questions.length;
    }
    return (cat: assessmentCategories.last, qInCat: assessmentCategories.last.questions.length - 1);
  }

  void _select(int answerIdx) {
    setState(() {
      _responses[_index] = answerIdx;
    });
    Future.delayed(const Duration(milliseconds: 220), () {
      if (!mounted) return;
      if (_index < _total - 1) {
        setState(() => _index++);
      } else {
        _finish();
      }
    });
  }

  void _finish() {
    final perCategory = <AssessmentCategory, int>{};
    int globalIndex = 0;
    for (final c in assessmentCategories) {
      int s = 0;
      for (int i = 0; i < c.questions.length; i++) {
        s += _responses[globalIndex] ?? 0;
        globalIndex++;
      }
      perCategory[c] = s;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => AssessmentResultsScreen(scores: perCategory),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = _locate(_index);
    final cat = loc.cat;
    final selected = _responses[_index];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () {
            if (_index > 0) {
              setState(() => _index--);
            } else {
              Navigator.of(context).maybePop();
            }
          },
        ),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('📋 ',
                    style: TextStyle(fontSize: 18)),
                const Text('Test d\'évaluation',
                    style: TextStyle(fontWeight: FontWeight.w800)),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              'Question ${_index + 1} / $_total',
              style:
                  const TextStyle(fontSize: 13, color: AppColors.textMuted),
            ),
          ],
        ),
        toolbarHeight: 64,
      ),
      body: KidsBackground(
        overlayOpacity: 0.95,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: (_index + 1) / _total,
                minHeight: 6,
                backgroundColor: AppColors.border,
                valueColor: const AlwaysStoppedAnimation(AppColors.accentTeal),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
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
                          Icon(cat.icon,
                              size: 18, color: AppColors.primary),
                          const SizedBox(width: 8),
                          Text(cat.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Question ${loc.qInCat + 1} / ${cat.questions.length}',
                      style: const TextStyle(color: AppColors.textMuted),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Text(
                        cat.questions[loc.qInCat],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          height: 1.35,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Mode de réponse :',
                        style: TextStyle(color: AppColors.textMuted)),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        _Legend('0 =', 'Jamais'),
                        _Legend('1 =', 'Rarement'),
                        _Legend('2 =', 'Parfois'),
                        _Legend('3 =', 'Souvent'),
                        _Legend('4 =', 'Toujours'),
                      ],
                    ),
                    const SizedBox(height: 14),
                    ...List.generate(_answers.length, (i) {
                      final (label, color) = _answers[i];
                      final isSel = selected == i;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          decoration: BoxDecoration(
                            gradient: isSel
                                ? LinearGradient(colors: [
                                    color.withOpacity(0.85),
                                    color,
                                  ])
                                : null,
                            color: isSel ? null : Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: isSel ? color : AppColors.border,
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(18),
                              onTap: () => _select(i),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 18),
                                child: Center(
                                  child: Text(
                                    label,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: isSel
                                          ? Colors.white
                                          : AppColors.textDark,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 6,
                runSpacing: 6,
                children: List.generate(_total, (i) {
                  final answered = _responses.containsKey(i);
                  final current = i == _index;
                  return Container(
                    width: current ? 14 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: current
                          ? AppColors.primary
                          : answered
                              ? AppColors.accentTeal
                              : AppColors.border,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final String num;
  final String text;
  const _Legend(this.num, this.text);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(num,
            style: const TextStyle(
                fontWeight: FontWeight.w800, fontSize: 12)),
        Text(text,
            style:
                const TextStyle(color: AppColors.textMuted, fontSize: 11)),
      ],
    );
  }
}
