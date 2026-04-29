import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../app_theme.dart';
import '../models/report.dart';
import '../state/app_state.dart';
import '../widgets/primary_button.dart';

class AddMedicalReportScreen extends StatefulWidget {
  const AddMedicalReportScreen({super.key});

  @override
  State<AddMedicalReportScreen> createState() =>
      _AddMedicalReportScreenState();
}

class _AddMedicalReportScreenState extends State<AddMedicalReportScreen> {
  final _observation = TextEditingController();
  final _notes = TextEditingController();
  final _diagnosis = TextEditingController();
  final _recommendations = TextEditingController();
  int _patient = 0;

  @override
  void dispose() {
    _observation.dispose();
    _notes.dispose();
    _diagnosis.dispose();
    _recommendations.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final now = DateTime.now();
    return Scaffold(
      backgroundColor: const Color(0xFFEFF6FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Add Medical Report'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Label('Select Patient *'),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: _patient,
                  isExpanded: true,
                  hint: const Text('Choose a patient...'),
                  items: [
                    for (int i = 0; i < state.children.length; i++)
                      DropdownMenuItem(
                          value: i, child: Text(state.children[i].name)),
                  ],
                  onChanged: (i) {
                    if (i != null) setState(() => _patient = i);
                  },
                ),
              ),
            ),
            const SizedBox(height: 14),
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
                      style: const TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  Text('Time: ${DateFormat('HH:mm:ss').format(now)}',
                      style: const TextStyle(fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const _Label('Medical Observation'),
            TextField(
              controller: _observation,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Describe clinical observations during the session...',
              ),
            ),
            const SizedBox(height: 18),
            const _Label('Medical Notes'),
            TextField(
              controller: _notes,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Add detailed medical notes, test results, assessments...',
              ),
            ),
            const SizedBox(height: 18),
            const _Label('Diagnosis Update'),
            TextField(
              controller: _diagnosis,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Update diagnosis or assessment results...',
              ),
            ),
            const SizedBox(height: 18),
            const _Label('Recommendations'),
            TextField(
              controller: _recommendations,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText:
                    'Treatment recommendations, therapy suggestions, follow-up actions...',
              ),
            ),
            const SizedBox(height: 22),
            PrimaryButton(
              label: 'Save Medical Report',
              icon: Icons.save_outlined,
              gradient: AppColors.tealGradient,
              onPressed: () {
                state.addMedicalReport(MedicalReport(
                  patientName: state.children[_patient].name,
                  date: DateTime.now(),
                  observation: _observation.text,
                  medicalNotes: _notes.text,
                  diagnosisUpdate: _diagnosis.text,
                  recommendations: _recommendations.text,
                ));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Rapport médical enregistré')),
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
