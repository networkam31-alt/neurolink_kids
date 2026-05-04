import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../models/child.dart';
import '../state/app_state.dart';
import '../widgets/kids_background.dart';
import '../widgets/primary_button.dart';
import 'assessment_screen.dart';

class AddChildScreen extends StatefulWidget {
  const AddChildScreen({super.key});

  @override
  State<AddChildScreen> createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  final _name = TextEditingController();
  final _age = TextEditingController();
  final _school = TextEditingController();
  String _gender = 'Boy';
  String _diagnosis = 'Not diagnosed';
  bool _startedSchool = true;

  static const _diagnoses = [
    'Autism',
    'ADHD',
    'Speech delay',
    'Learning difficulty',
    'Not diagnosed',
  ];

  @override
  void dispose() {
    _name.dispose();
    _age.dispose();
    _school.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un enfant'),
      ),
      body: KidsBackground(
        overlayOpacity: 0.92,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Label('Nom de l\'enfant'),
              TextField(
                controller: _name,
                decoration: const InputDecoration(
                  hintText: 'Ex: Emma',
                  prefixIcon: Icon(Icons.child_care),
                ),
              ),
              const SizedBox(height: 14),
              const _Label('Âge'),
              TextField(
                controller: _age,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Ex: 7',
                  prefixIcon: Icon(Icons.cake_outlined),
                ),
              ),
              const SizedBox(height: 14),
              const _Label('Genre'),
              Row(
                children: [
                  _Pill(
                    label: 'Garçon',
                    selected: _gender == 'Boy',
                    onTap: () => setState(() => _gender = 'Boy'),
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 10),
                  _Pill(
                    label: 'Fille',
                    selected: _gender == 'Girl',
                    onTap: () => setState(() => _gender = 'Girl'),
                    color: AppColors.accentPink,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const _Label('Nom de l\'école'),
              TextField(
                controller: _school,
                decoration: const InputDecoration(
                  hintText: "Nom de l'école",
                  prefixIcon: Icon(Icons.school_outlined),
                ),
              ),
              const SizedBox(height: 14),
              const _Label('Type de diagnostic'),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _diagnoses
                    .map((d) => _Pill(
                          label: d,
                          selected: _diagnosis == d,
                          onTap: () => setState(() => _diagnosis = d),
                          color: AppColors.accentPurple,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 14),
              const _Label("Votre enfant a-t-il commencé l'école ?"),
              Row(
                children: [
                  _Pill(
                    label: 'Oui',
                    selected: _startedSchool,
                    onTap: () => setState(() => _startedSchool = true),
                    color: AppColors.accentGreen,
                  ),
                  const SizedBox(width: 10),
                  _Pill(
                    label: 'Non',
                    selected: !_startedSchool,
                    onTap: () => setState(() => _startedSchool = false),
                    color: AppColors.accentRed,
                  ),
                ],
              ),
              const SizedBox(height: 26),
              PrimaryButton(
                label: "Continuer vers l'évaluation",
                icon: Icons.arrow_forward,
                gradient: AppColors.blueGradient,
                onPressed: _save,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  void _save() {
    if (_name.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez saisir le nom de l'enfant")),
      );
      return;
    }
    final state = AppStateScope.of(context);
    state.addChild(ChildProfile(
      name: _name.text.trim(),
      age: int.tryParse(_age.text) ?? 6,
      gender: _gender,
      school: _school.text,
      diagnosis: _diagnosis,
      startedSchool: _startedSchool,
      color: _gender == 'Girl' ? AppColors.accentPink : AppColors.primary,
    ));
    state.setActiveChild(state.children.length - 1);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => const AssessmentScreen(),
    ));
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 6, top: 4),
        child: Text(text,
            style: const TextStyle(
                fontWeight: FontWeight.w800, color: AppColors.textDark)),
      );
}

class _Pill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color color;
  const _Pill({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? color : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? color : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.textDark,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
