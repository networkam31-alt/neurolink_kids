import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../app_theme.dart';
import '../models/report.dart';
import '../state/app_state.dart';
import '../widgets/primary_button.dart';

class AddReportScreen extends StatefulWidget {
  const AddReportScreen({super.key});

  @override
  State<AddReportScreen> createState() => _AddReportScreenState();
}

class _AddReportScreenState extends State<AddReportScreen> {
  final _strange = TextEditingController();
  final _notes = TextEditingController();

  static const _emotions = ['😄', '🙂', '😐', '😨', '😢'];
  static const _behaviors = [
    'Focused',
    'Distracted',
    'Social',
    'Isolated',
    'Hyperactive',
    'Calm',
  ];
  static const _learning = [
    'Reading',
    'Writing',
    'Math',
    'Drawing',
    'Group Activity',
  ];
  static const _performance = ['Excellent', 'Good', 'Average', 'Poor'];

  String _emotion = '😐';
  final Set<String> _selBehaviors = {};
  bool _strangeOn = false;
  String _perf = 'Good';
  final Set<String> _selLearning = {};

  @override
  void dispose() {
    _strange.dispose();
    _notes.dispose();
    super.dispose();
  }

  Color _perfColor(String p) {
    switch (p) {
      case 'Excellent':
        return AppColors.accentGreen;
      case 'Good':
        return AppColors.primary;
      case 'Average':
        return AppColors.accentTeal;
      case 'Poor':
        return AppColors.accentRed;
    }
    return AppColors.textMuted;
  }

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final now = DateTime.now();
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7ED),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Add Report'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date: ${DateFormat('dd/MM/y').format(now)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark)),
                  const SizedBox(height: 4),
                  Text('Time: ${DateFormat('HH:mm:ss').format(now)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark)),
                ],
              ),
            ),
            const SizedBox(height: 18),
            _Label('Emotion *'),
            Row(
              children: _emotions.map((e) {
                final s = _emotion == e;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _emotion = e),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      margin:
                          const EdgeInsets.symmetric(horizontal: 4),
                      height: 64,
                      decoration: BoxDecoration(
                        gradient: s ? AppColors.tealGradient : null,
                        color: s ? null : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: s
                              ? Colors.transparent
                              : AppColors.border,
                        ),
                      ),
                      child: Center(
                          child: Text(e,
                              style: const TextStyle(fontSize: 28))),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 18),
            _Label('Behavior (Multi-select)'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _behaviors
                  .map((b) => _Chip(
                        label: b,
                        selected: _selBehaviors.contains(b),
                        color: AppColors.primary,
                        onTap: () => setState(() {
                          if (!_selBehaviors.add(b)) {
                            _selBehaviors.remove(b);
                          }
                        }),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                _Label('Strange Behavior'),
                const Spacer(),
                Switch(
                  value: _strangeOn,
                  onChanged: (v) => setState(() => _strangeOn = v),
                  activeColor: Colors.white,
                  activeTrackColor: AppColors.accentRed,
                ),
              ],
            ),
            if (_strangeOn)
              TextField(
                controller: _strange,
                maxLines: 3,
                decoration: const InputDecoration(
                    hintText: 'Describe the unusual behavior...'),
              ),
            const SizedBox(height: 18),
            _Label('Performance'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _performance
                  .map((p) => _Chip(
                        label: p,
                        selected: _perf == p,
                        color: _perfColor(p),
                        onTap: () => setState(() => _perf = p),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 18),
            _Label('Learning Activities (Multi-select)'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _learning
                  .map((l) => _Chip(
                        label: l,
                        selected: _selLearning.contains(l),
                        color: AppColors.accentPurple,
                        onTap: () => setState(() {
                          if (!_selLearning.add(l)) {
                            _selLearning.remove(l);
                          }
                        }),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 18),
            _Label('Notes (Optional)'),
            TextField(
              controller: _notes,
              maxLines: 4,
              decoration: const InputDecoration(
                  hintText: 'Add any additional notes...'),
            ),
            const SizedBox(height: 22),
            PrimaryButton(
              label: 'Save Report',
              icon: Icons.save_outlined,
              gradient: AppColors.orangeGradient,
              onPressed: () {
                state.addReport(DailyReport(
                  childName: state.activeChild.name,
                  date: DateTime.now(),
                  authorRole: state.role == UserRole.teacher
                      ? 'Teacher'
                      : state.role == UserRole.doctor
                          ? 'Doctor'
                          : 'Parent',
                  emotion: _emotion,
                  behaviors: _selBehaviors.toList(),
                  strangeBehavior: _strangeOn,
                  strangeBehaviorNote: _strange.text,
                  performance: _perf,
                  learningActivities: _selLearning.toList(),
                  notes: _notes.text,
                ));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Rapport enregistré')),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  // ignore: unused_element_parameter
  const _Label(this.text, {super.key});
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text,
            style: const TextStyle(
                fontWeight: FontWeight.w800, color: AppColors.textDark)),
      );
}

class _Chip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color color;
  const _Chip({
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
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? color : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: selected ? color : AppColors.border),
        ),
        child: Text(label,
            style: TextStyle(
                color: selected ? Colors.white : AppColors.textDark,
                fontWeight: FontWeight.w800)),
      ),
    );
  }
}
