import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../state/app_state.dart';
import '../widgets/kids_background.dart';
import '../widgets/language_switcher.dart';
import 'add_medical_report_screen.dart';
import 'reports_screen.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final patient = state.activeChild;
    return Scaffold(
      body: KidsBackground(
        overlayOpacity: 0.94,
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
                    backgroundColor: AppColors.accentTeal,
                    child: Text('D',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900)),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Text('Hello, 👋  Doctor',
                  style: TextStyle(
                      fontSize: 26, fontWeight: FontWeight.w900)),
              const Text('Track patient progress and assessments',
                  style: TextStyle(color: AppColors.textMuted)),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: state.activeChildIndex,
                    isExpanded: true,
                    items: [
                      for (int i = 0; i < state.children.length; i++)
                        DropdownMenuItem(
                            value: i,
                            child: Text(state.children[i].name)),
                    ],
                    onChanged: (i) {
                      if (i != null) state.setActiveChild(i);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.accentTeal.withOpacity(0.15),
                      AppColors.primary.withOpacity(0.10),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: AppColors.accentTeal.withOpacity(0.4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(children: [
                      Icon(Icons.person, color: AppColors.primary),
                      SizedBox(width: 6),
                      Text('Patient Profile',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w900))
                    ]),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: patient.color,
                          child: Text(patient.initial,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 22)),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(patient.name,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900)),
                              Text('Age: ${patient.age} years'),
                              Text('Diagnosis: ${patient.diagnosis}',
                                  style: const TextStyle(
                                      color: AppColors.textMuted)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(Icons.medical_services_outlined,
                          color: AppColors.accentTeal),
                      SizedBox(width: 6),
                      Text('Medical Condition',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w900))
                    ]),
                    SizedBox(height: 8),
                    Text('Diagnosis Details:',
                        style: TextStyle(color: AppColors.textMuted)),
                    SizedBox(height: 4),
                    Text(
                        'Minimal support needs with mild communication challenges. Shows good progress in social settings.'),
                    SizedBox(height: 8),
                    Text('Observations:',
                        style: TextStyle(color: AppColors.textMuted)),
                    SizedBox(height: 4),
                    Text(
                        'Responds well to structured learning environments and visual aids. Improved eye contact noted.'),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const AddMedicalReportScreen())),
                child: Container(
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: AppColors.tealGradient,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const Center(
                    child: Text('+ Add Medical Report',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800)),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Row(children: [
                Icon(Icons.insights, color: AppColors.primary),
                SizedBox(width: 6),
                Text('Performance Overview',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w900)),
              ]),
              const SizedBox(height: 4),
              const Text('Recent reports from teacher:',
                  style: TextStyle(color: AppColors.textMuted)),
              const SizedBox(height: 8),
              const ReportsList(),
            ],
          ),
        ),
      ),
    );
  }
}
