class DailyReport {
  final String childName;
  final DateTime date;
  final String authorRole; // Parent, Teacher, Doctor
  final String emotion; // emoji
  final List<String> behaviors;
  final bool strangeBehavior;
  final String strangeBehaviorNote;
  final String performance; // Excellent / Good / Average / Poor
  final List<String> learningActivities;
  final String notes;

  DailyReport({
    required this.childName,
    required this.date,
    required this.authorRole,
    required this.emotion,
    required this.behaviors,
    required this.strangeBehavior,
    required this.strangeBehaviorNote,
    required this.performance,
    required this.learningActivities,
    required this.notes,
  });
}

class MedicalReport {
  final String patientName;
  final DateTime date;
  final String observation;
  final String medicalNotes;
  final String diagnosisUpdate;
  final String recommendations;

  MedicalReport({
    required this.patientName,
    required this.date,
    required this.observation,
    required this.medicalNotes,
    required this.diagnosisUpdate,
    required this.recommendations,
  });
}
