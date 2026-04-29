import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../state/app_state.dart';
import '../widgets/kids_background.dart';
import '../widgets/language_switcher.dart';
import '../widgets/primary_button.dart';
import 'add_child_screen.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _showPwd = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
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
                const SizedBox(height: 4),
                Image.asset('assets/images/logo.png',
                    width: 90, height: 90),
                const SizedBox(height: 4),
                const Text(
                  'Créer un compte',
                  style:
                      TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Rejoignez la communauté NeuroLink Kids",
                  style: TextStyle(color: AppColors.textMuted),
                ),
                const SizedBox(height: 22),
                TextField(
                  controller: _name,
                  decoration: const InputDecoration(
                    labelText: 'Nom du parent',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _password,
                  obscureText: !_showPwd,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => _showPwd = !_showPwd),
                      icon: Icon(
                        _showPwd ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _confirm,
                  obscureText: !_showPwd,
                  decoration: const InputDecoration(
                    labelText: 'Confirmer le mot de passe',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),
                const SizedBox(height: 22),
                PrimaryButton(
                  label: "Créer un compte",
                  icon: Icons.arrow_forward,
                  gradient: AppColors.orangeGradient,
                  onPressed: () {
                    state.userName =
                        _name.text.isEmpty ? 'Parent' : _name.text;
                    state.setRole(UserRole.parent);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const AddChildScreen(),
                    ));
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Vous avez déjà un compte ?  "),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (_) => const LoginScreen()),
                      ),
                      child: const Text('Se connecter',
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
