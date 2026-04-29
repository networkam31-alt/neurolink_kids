# NeuroLink Kids

A Flutter mobile app supporting children with autism, ADHD, and learning differences. Designed for **parents**, **teachers**, and **doctors** with role-aware home screens, daily reports, learning activities, and a 50-question evaluation test.

> *Apprendre • Pratiquer • Grandir*

## Features

- **Splash screen** with 5-second animated NeuroLink Kids logo intro.
- **Welcome / Sign up / Login** flow with kids-gathering background and language switcher (GB / FR / SA).
- **Add Child** profile (name, age, gender, school, diagnosis).
- **Test d'évaluation** — 50 questions across 5 categories (Communication, Comportements, Sensibilité, Vie quotidienne, Émotions).
- **Parent home** with child avatar switcher, search bar, and tabs for Activities (Vidéos + Activités) and Reports.
- **Activities mini-games**: colors, shapes, numbers, words, emotions, animals.
- **Reports**: emotion picker, behavior multi-select, performance, learning activities, notes, unusual-behavior toggle.
- **Teacher dashboard** with class overview, student performance bars, Add Report.
- **Doctor dashboard** with patient profile, medical condition card, Add Medical Report.
- **Bottom navigation**: Accueil, Activités, Progrès, Profil.

## Run

```bash
flutter pub get
flutter run                # any connected device / emulator
flutter build apk          # release APK for Android
```

Tested with Flutter 3.24.5 / Dart 3.5.4. Targets Android (and iOS).

## Project layout

```
lib/
  main.dart
  app_theme.dart
  data/activities.dart
  models/
  screens/
  state/app_state.dart
  widgets/
assets/images/
  logo.png
  kids_bg.jpg
```
