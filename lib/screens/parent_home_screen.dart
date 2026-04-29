import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../data/activities.dart';
import '../state/app_state.dart';
import '../widgets/kids_background.dart';
import '../widgets/language_switcher.dart';
import 'activity_detail_screen.dart';
import 'add_report_screen.dart';
import 'reports_screen.dart';

class ParentHomeScreen extends StatefulWidget {
  const ParentHomeScreen({super.key});

  @override
  State<ParentHomeScreen> createState() => _ParentHomeScreenState();
}

class _ParentHomeScreenState extends State<ParentHomeScreen> {
  int _topTab = 0; // 0 Activities, 1 Reports

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final child = state.activeChild;
    return Scaffold(
      body: KidsBackground(
        overlayOpacity: 0.92,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              _Header(),
              const SizedBox(height: 12),
              _Greeting(name: child.name),
              const SizedBox(height: 12),
              _SearchBar(),
              const SizedBox(height: 18),
              _TopTabs(
                index: _topTab,
                onChanged: (i) => setState(() => _topTab = i),
              ),
              const SizedBox(height: 14),
              if (_topTab == 0) ..._activitiesContent(context) else ..._reportsContent(context),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _activitiesContent(BuildContext context) {
    return [
      _SectionHeader(title: 'Vidéos', onSeeAll: () {}),
      const SizedBox(height: 8),
      SizedBox(
        height: 200,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: videos.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (_, i) {
            final v = videos[i];
            return _VideoCard(item: v);
          },
        ),
      ),
      const SizedBox(height: 18),
      _SectionHeader(title: 'Activités', onSeeAll: () {}),
      const SizedBox(height: 8),
      GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: activities.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.95,
        ),
        itemBuilder: (_, i) {
          final a = activities[i];
          return _ActivityCard(
            item: a,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ActivityDetailScreen(item: a),
              ));
            },
          );
        },
      ),
    ];
  }

  List<Widget> _reportsContent(BuildContext context) {
    return [
      const ReportsList(),
      const SizedBox(height: 12),
      _AddReportButton(onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => const AddReportScreen(),
        ));
      }),
    ];
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    return Row(
      children: [
        Image.asset('assets/images/logo.png', width: 46, height: 46),
        const SizedBox(width: 6),
        const Text('NeuroLink\nKids',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                height: 1.05)),
        const SizedBox(width: 8),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (int i = 0; i < state.children.length; i++)
                  GestureDetector(
                    onTap: () => state.setActiveChild(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      margin: const EdgeInsets.only(right: 6),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            state.children[i].color,
                            state.children[i].color.withOpacity(0.7),
                          ],
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: state.activeChildIndex == i
                              ? AppColors.primary
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          state.children[i].initial,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const LanguageSwitcher(),
      ],
    );
  }
}

class _Greeting extends StatelessWidget {
  final String name;
  const _Greeting({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7ED),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Hello,  👋',
              style: TextStyle(color: AppColors.textMuted)),
          const SizedBox(height: 4),
          Text(name,
              style: const TextStyle(
                  fontSize: 28, fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          const Text("Let's learn something new today!",
              style: TextStyle(color: AppColors.textMuted)),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Rechercher...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: const Icon(Icons.mic_none_rounded),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: AppColors.border),
        ),
      ),
    );
  }
}

class _TopTabs extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;
  const _TopTabs({required this.index, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    Widget tab(int i, String label) {
      final s = index == i;
      return Expanded(
        child: GestureDetector(
          onTap: () => onChanged(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(vertical: 14),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              gradient: s ? AppColors.blueGradient : null,
              color: s ? null : Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: s ? Colors.transparent : AppColors.border,
              ),
              boxShadow: s
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: s ? Colors.white : AppColors.textDark,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Row(children: [tab(0, 'Activities'), tab(1, 'Reports')]);
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;
  const _SectionHeader({required this.title, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.w900)),
        const Spacer(),
        TextButton(
            onPressed: onSeeAll,
            child: const Text('See All  →',
                style: TextStyle(fontWeight: FontWeight.w800))),
      ],
    );
  }
}

class _VideoCard extends StatelessWidget {
  final VideoItem item;
  const _VideoCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 130,
            decoration: BoxDecoration(
              gradient: item.gradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(item.icon,
                        color: AppColors.primary, size: 28),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(item.duration,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(item.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(item.tag,
                style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 11)),
          ),
        ],
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final ActivityItem item;
  final VoidCallback onTap;
  const _ActivityCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: item.gradient,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(item.icon, color: Colors.white, size: 28),
            ),
            const Spacer(),
            Text(item.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w900)),
            const SizedBox(height: 6),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(item.tag,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w800)),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddReportButton extends StatelessWidget {
  final VoidCallback onTap;
  const _AddReportButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          gradient: AppColors.orangeGradient,
          borderRadius: BorderRadius.circular(28),
        ),
        child: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: Colors.white),
              SizedBox(width: 6),
              Text('Ajouter un rapport',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800)),
            ],
          ),
        ),
      ),
    );
  }
}
