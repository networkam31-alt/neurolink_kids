import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../app_theme.dart';
import '../models/report.dart';
import '../state/app_state.dart';

class ReportsList extends StatelessWidget {
  final String? filterChild;
  const ReportsList({super.key, this.filterChild});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final reports = state.reports
        .where((r) =>
            filterChild == null || r.childName == filterChild)
        .toList();
    if (reports.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 40),
        alignment: Alignment.center,
        child: const Column(
          children: [
            Icon(Icons.event_note, size: 56, color: AppColors.textMuted),
            SizedBox(height: 8),
            Text('Aucun rapport pour le moment',
                style: TextStyle(color: AppColors.textMuted)),
          ],
        ),
      );
    }
    return Column(
      children: reports.map((r) => ReportCard(report: r)).toList(),
    );
  }
}

class ReportCard extends StatelessWidget {
  final DailyReport report;
  const ReportCard({super.key, required this.report});

  Color _perfColor() {
    switch (report.performance) {
      case 'Excellent':
        return AppColors.accentGreen;
      case 'Good':
        return AppColors.primary;
      case 'Average':
        return AppColors.accentOrange;
      case 'Poor':
        return AppColors.accentRed;
    }
    return AppColors.textMuted;
  }

  Color _roleColor() {
    switch (report.authorRole) {
      case 'Teacher':
        return AppColors.accentOrange;
      case 'Doctor':
        return AppColors.accentTeal;
    }
    return AppColors.primary;
  }

  @override
  Widget build(BuildContext context) {
    final df = DateFormat('MMMM d, y');
    final tf = DateFormat('HH:mm');
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(report.childName,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 4),
                    Row(children: [
                      const Icon(Icons.calendar_today_outlined,
                          size: 12, color: AppColors.textMuted),
                      const SizedBox(width: 4),
                      Text(df.format(report.date),
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textMuted)),
                      const SizedBox(width: 10),
                      const Icon(Icons.access_time,
                          size: 12, color: AppColors.textMuted),
                      const SizedBox(width: 4),
                      Text(tf.format(report.date),
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textMuted)),
                    ]),
                  ],
                ),
              ),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.accentGreen.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                    child: Text(report.emotion,
                        style: const TextStyle(fontSize: 28))),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(children: [
            const Icon(Icons.person_outline,
                size: 14, color: AppColors.textMuted),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: _roleColor().withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(report.authorRole,
                  style: TextStyle(
                      color: _roleColor(),
                      fontWeight: FontWeight.w800,
                      fontSize: 12)),
            ),
          ]),
          const SizedBox(height: 10),
          if (report.behaviors.isNotEmpty) ...[
            const Text('Behavior:',
                style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
            const SizedBox(height: 4),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: report.behaviors
                  .map((b) => _Tag(label: b, color: AppColors.primary))
                  .toList(),
            ),
            const SizedBox(height: 8),
          ],
          if (report.learningActivities.isNotEmpty) ...[
            const Text('Learning Activities:',
                style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
            const SizedBox(height: 4),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: report.learningActivities
                  .map((b) =>
                      _Tag(label: b, color: AppColors.accentPurple))
                  .toList(),
            ),
            const SizedBox(height: 8),
          ],
          const Text('Performance:',
              style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: _perfColor(),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(report.performance,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w800)),
          ),
          if (report.strangeBehavior &&
              report.strangeBehaviorNote.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.accentRed.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                    color: AppColors.accentRed.withOpacity(0.4)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.error_outline,
                      color: AppColors.accentRed, size: 16),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Unusual Behavior',
                            style: TextStyle(
                                color: AppColors.accentRed,
                                fontWeight: FontWeight.w900)),
                        const SizedBox(height: 2),
                        Text(report.strangeBehaviorNote,
                            style: const TextStyle(
                                color: AppColors.textDark, fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (report.notes.isNotEmpty) ...[
            const Divider(height: 22),
            const Text('Notes:',
                style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
            const SizedBox(height: 2),
            Text(report.notes),
          ],
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final Color color;
  const _Tag({required this.label, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(label,
          style: TextStyle(
              color: color, fontWeight: FontWeight.w800, fontSize: 12)),
    );
  }
}
