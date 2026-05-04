import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../state/app_state.dart';
import '../widgets/kids_background.dart';
import '../widgets/language_switcher.dart';
import '../widgets/primary_button.dart';
import 'home_shell.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _showPassword = false;
  UserRole _role = UserRole.parent;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    return Scaffold(
      body: KidsBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const LanguageSwitcher(),
                  ],
                ),
                const SizedBox(height: 8),
                Image.asset('assets/images/logo.png',
                    width: 110, height: 110),
                const SizedBox(height: 8),
                const Text(
                  'Bienvenue',
                  style:
                      TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Connectez-vous pour continuer',
                  style: TextStyle(color: AppColors.textMuted),
                ),
                const SizedBox(height: 24),
                _RolePicker(
                  selected: _role,
                  onChanged: (r) => setState(() => _role = r),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _password,
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () =>
                          setState(() => _showPassword = !_showPassword),
                      icon: Icon(_showPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Mot de passe oublié ?'),
                  ),
                ),
                const SizedBox(height: 8),
                PrimaryButton(
                  label: 'Se connecter',
                  icon: Icons.login,
                  gradient: AppColors.orangeGradient,
                  onPressed: () {
                    state.setRole(_role);
                    state.userName = _email.text.split('@').first.isEmpty
                        ? 'Parent'
                        : _email.text.split('@').first;
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const HomeShell()),
                      (route) => false,
                    );
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Vous n'avez pas de compte ?  "),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (_) => const SignupScreen()),
                      ),
                      child: const Text("S'inscrire",
                          style: TextStyle(fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RolePicker extends StatelessWidget {
  final UserRole selected;
  final ValueChanged<UserRole> onChanged;
  const _RolePicker({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    Widget tile(UserRole r, IconData icon, String label) {
      final s = r == selected;
      return Expanded(
        child: GestureDetector(
          onTap: () => onChanged(r),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              gradient: s ? AppColors.blueGradient : null,
              color: s ? null : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: s ? Colors.transparent : AppColors.border,
              ),
            ),
            child: Column(
              children: [
                Icon(icon, color: s ? Colors.white : AppColors.primary),
                const SizedBox(height: 4),
                Text(label,
                    style: TextStyle(
                      color: s ? Colors.white : AppColors.textDark,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    )),
              ],
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        tile(UserRole.parent, Icons.family_restroom, 'Parent'),
        tile(UserRole.teacher, Icons.school_outlined, 'Enseignant'),
        tile(UserRole.doctor, Icons.medical_services_outlined, 'Médecin'),
      ],
    );
  }
}
