import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../state/app_state.dart';
import '../widgets/kids_background.dart';
import '../widgets/language_switcher.dart';
import 'add_report_screen.dart';
import 'reports_screen.dart';

class TeacherHomeScreen extends StatelessWidget {
  const TeacherHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    return Scaffold(
      body: KidsBackground(
        overlayOpacity: 0.93,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  Image.asset('assets/images/logo.png',
                      width: 44, height: 44),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text('NeuroLink Kids',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 16)),
                  ),
                  const LanguageSwitcher(),
                  const SizedBox(width: 8),
                  const CircleAvatar(
                    backgroundColor: AppColors.accentOrange,
                    child: Text('T',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900)),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Text('Hello, 👋  Teacher',
                  style: TextStyle(
                      fontSize: 26, fontWeight: FontWeight.w900)),
              const Text("Manage your students' progress",
                  style: TextStyle(color: AppColors.textMuted)),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: AppColors.blueGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(children: [
                      Icon(Icons.bar_chart, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Class Overview',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w900)),
                    ]),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _Mini(label: 'Avg Task', value: '78%'),
                        _Mini(label: 'Avg Score', value: '82%'),
                        _Mini(
                            label: 'Students',
                            value: '${state.children.length}'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              const Text('Student Performance',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w900)),
              const SizedBox(height: 10),
              ...state.children.map((c) => _StudentCard(name: c.name, color: c.color)),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const AddReportScreen())),
                child: Container(
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: AppColors.orangeGradient,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const Center(
                    child: Text('+ Add Report',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800)),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text('Recent Reports',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              const ReportsList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Mini extends StatelessWidget {
  final String label;
  final String value;
  const _Mini({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900)),
          Text(label,
              style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }
}

class _StudentCard extends StatelessWidget {
  final String name;
  final Color color;
  const _StudentCard({required this.name, required this.color});

  Widget _bar(String label, double v, Color c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 64,
            child: Text(label, style: const TextStyle(fontSize: 12)),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: v,
                minHeight: 8,
                backgroundColor: AppColors.border,
                valueColor: AlwaysStoppedAnimation(c),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text('${(v * 100).round()}%',
              style: const TextStyle(
                  fontWeight: FontWeight.w800, fontSize: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: color,
                child: Text(name[0],
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w800)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accentGreen.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('Level 2',
                    style: TextStyle(
                        color: AppColors.accentGreen,
                        fontWeight: FontWeight.w800,
                        fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _bar('Reading', 0.78, AppColors.accentGreen),
          _bar('Writing', 0.65, AppColors.primary),
          _bar('Math', 0.72, AppColors.accentPurple),
          _bar('Social', 0.84, AppColors.accentOrange),
        ],
      ),
    );
  }
}
