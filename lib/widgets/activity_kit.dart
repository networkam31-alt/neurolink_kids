import 'package:flutter/material.dart';

import '../state/app_state.dart';

/// Shared shell for an activity detail page. Provides:
///   - Coloured magenta/blue/etc. screen title in app bar
///   - White circular back button
///   - Star pill on the right showing the current child's star total
///   - Soft pastel background
class ActivityShell extends StatelessWidget {
  final String title;
  final Color titleColor;
  final List<Color> backgroundColors;
  final List<Widget>? extraAppBarActions;
  final Widget child;
  const ActivityShell({
    super.key,
    required this.title,
    this.titleColor = const Color(0xFFEC4899),
    this.backgroundColors = const [Color(0xFFF5E9FF), Color(0xFFEAF2FF)],
    this.extraAppBarActions,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final stars = AppStateScope.of(context).stars;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 64,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Center(
            child: _CircleIconButton(
              icon: Icons.arrow_back_ios_new_rounded,
              onTap: () => Navigator.of(context).maybePop(),
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          ...?extraAppBarActions,
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(child: StarPill(value: stars)),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: backgroundColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: child,
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.08),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, size: 16, color: Colors.black87),
        ),
      ),
    );
  }
}

class StarPill extends StatelessWidget {
  final int value;
  const StarPill({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, color: Color(0xFFFBBF24), size: 18),
          const SizedBox(width: 6),
          Text(
            '$value',
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF1F2937),
            ),
          ),
        ],
      ),
    );
  }
}

/// Big rounded gradient sub-game card (like the "Tap the Color" / "Match Colors" tiles).
class GameModeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget icon;
  final Gradient gradient;
  final VoidCallback onTap;
  final double? height;
  const GameModeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.onTap,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Compact list-style gradient tile (like "Letter Tracing", "Letter Sound Game" rows).
class GameModeListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Gradient gradient;
  final VoidCallback onTap;
  const GameModeListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 16, 12),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.black87),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pill row used to switch between numbered levels (1 / 2 / 3).
class LevelSelector extends StatelessWidget {
  final int current;
  final int max;
  final ValueChanged<int> onChanged;
  const LevelSelector({
    super.key,
    required this.current,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Level: ',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF1F2937),
            ),
          ),
          for (int i = 1; i <= max; i++) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => onChanged(i),
              child: Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: i == current
                      ? const LinearGradient(
                          colors: [Color(0xFFEC4899), Color(0xFFA855F7)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: i == current ? null : const Color(0xFFE5E7EB),
                ),
                child: Text(
                  '$i',
                  style: TextStyle(
                    color: i == current ? Colors.white : const Color(0xFF6B7280),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Big tappable choice tile (e.g. the colored squares in "Tap the Color" / objects in matching).
class ChoiceTile extends StatelessWidget {
  final Color color;
  final String? label;
  final Widget? customChild;
  final VoidCallback onTap;
  final bool highlight;
  final bool checked;
  final double size;
  const ChoiceTile({
    super.key,
    required this.color,
    this.label,
    this.customChild,
    required this.onTap,
    this.highlight = false,
    this.checked = false,
    this.size = 140,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
          border: highlight
              ? Border.all(color: const Color(0xFFFBBF24), width: 6)
              : null,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.35),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (customChild != null) Center(child: customChild),
            if (label != null)
              Text(
                label!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
            if (checked)
              const Positioned(
                bottom: 14,
                child: Icon(Icons.check_rounded,
                    color: Colors.white, size: 26),
              ),
          ],
        ),
      ),
    );
  }
}

/// Small confetti / sparkle overlay shown after a correct answer.
class CelebrationOverlay extends StatelessWidget {
  final bool show;
  const CelebrationOverlay({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    if (!show) return const SizedBox.shrink();
    return IgnorePointer(
      child: Stack(
        children: List.generate(20, (i) {
          final dx = (i * 37) % 360;
          final dy = (i * 53) % 600 + 40;
          final hue = (i * 30) % 360;
          return Positioned(
            left: dx.toDouble(),
            top: dy.toDouble(),
            child: Text(
              i.isEven ? '🎉' : '✨',
              style: TextStyle(fontSize: 18 + (hue % 14).toDouble()),
            ),
          );
        }),
      ),
    );
  }
}
