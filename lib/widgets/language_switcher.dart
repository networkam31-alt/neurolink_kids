import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../state/app_state.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    Widget chip(AppLanguage lang, String label) {
      final selected = state.language == lang;
      return GestureDetector(
        onTap: () => state.setLanguage(lang),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : AppColors.textMuted,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        chip(AppLanguage.en, 'GB'),
        chip(AppLanguage.fr, 'FR'),
        chip(AppLanguage.ar, 'SA'),
      ],
    );
  }
}
