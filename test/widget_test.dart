import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:neurolink_kids/screens/welcome_screen.dart';
import 'package:neurolink_kids/state/app_state.dart';

void main() {
  testWidgets('Welcome screen shows tagline and buttons', (tester) async {
    final state = AppState();
    await tester.pumpWidget(
      AppStateScope(
        state: state,
        child: const MaterialApp(home: WelcomeScreen()),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('NeuroLink Kids'), findsOneWidget);
    expect(find.text("S'inscrire"), findsOneWidget);
    expect(find.text('Se connecter'), findsOneWidget);
  });
}
