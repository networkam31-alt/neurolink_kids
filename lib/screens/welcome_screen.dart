import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../widgets/kids_background.dart';
import '../widgets/language_switcher.dart';
import '../widgets/primary_button.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KidsBackground(
        overlayOpacity: 0.85,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: const LanguageSwitcher(),
                ),
                const Spacer(),
                Image.asset('assets/images/logo.png',
                    width: 180, height: 180),
                const SizedBox(height: 12),
                const Text(
                  'NeuroLink Kids',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Apprendre • Pratiquer • Grandir',
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Soutenir les enfants autistes',
                    style: TextStyle(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Spacer(),
                PrimaryButton(
                  label: "S'inscrire",
                  icon: Icons.person_add_alt_1,
                  gradient: AppColors.orangeGradient,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const SignupScreen()));
                  },
                ),
                const SizedBox(height: 12),
                OutlineButtonRound(
                  label: 'Se connecter',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const LoginScreen()));
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
