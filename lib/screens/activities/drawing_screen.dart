import 'package:flutter/material.dart';

import '../../state/app_state.dart';
import '../../widgets/activity_kit.dart';

enum _Tool { brush, eraser, stamp }

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({super.key});

  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  _Tool _tool = _Tool.brush;
  Color _color = const Color(0xFFEC4899);
  double _size = 6;
  String _stamp = '⭐';
  final List<_DrawAction> _actions = [];
  List<Offset> _current = [];

  static const _palette = <Color>[
    Color(0xFFEC4899),
    Color(0xFF60A5FA),
    Color(0xFFFBBF24),
    Color(0xFF22C55E),
    Color(0xFFA855F7),
    Color(0xFFEF4444),
    Color(0xFF111827),
    Color(0xFFFFFFFF),
  ];

  static const _stamps = ['⭐', '❤️', '🌸', '🌟', '🎈', '🐶', '🍎', '🦋'];

  @override
  Widget build(BuildContext context) {
    return ActivityShell(
      title: 'Drawing Activity',
      titleColor: const Color(0xFF1F2937),
      backgroundColors: const [Color(0xFFFFF8EC), Color(0xFFEEF2FF)],
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          AspectRatio(
            aspectRatio: 1.05,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFE5E7EB),
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: GestureDetector(
                  onPanStart: (d) {
                    if (_tool == _Tool.stamp) {
                      setState(() => _actions.add(_DrawAction.stamp(
                          d.localPosition, _stamp, _size * 5)));
                    } else {
                      setState(() => _current = [d.localPosition]);
                    }
                  },
                  onPanUpdate: (d) {
                    if (_tool == _Tool.stamp) return;
                    setState(() => _current = [..._current, d.localPosition]);
                  },
                  onPanEnd: (_) {
                    if (_tool == _Tool.stamp) return;
                    setState(() {
                      _actions.add(_DrawAction.path(
                        _current,
                        _tool == _Tool.eraser ? Colors.white : _color,
                        _size,
                      ));
                      _current = [];
                    });
                  },
                  child: CustomPaint(
                    painter: _DrawingPainter(
                      actions: [
                        ..._actions,
                        if (_current.isNotEmpty)
                          _DrawAction.path(
                            _current,
                            _tool == _Tool.eraser ? Colors.white : _color,
                            _size,
                          ),
                      ],
                    ),
                    child: _current.isEmpty && _actions.isEmpty
                        ? const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.brush_outlined,
                                    size: 36, color: Color(0xFFD1D5DB)),
                                SizedBox(height: 8),
                                Text(
                                  'Start drawing here!',
                                  style: TextStyle(
                                    color: Color(0xFF9CA3AF),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : null,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _ToolButton(
                      label: 'Brush',
                      icon: Icons.brush_rounded,
                      active: _tool == _Tool.brush,
                      onTap: () => setState(() => _tool = _Tool.brush),
                    ),
                    const SizedBox(width: 8),
                    _ToolButton(
                      label: 'Eraser',
                      icon: Icons.cleaning_services_rounded,
                      active: _tool == _Tool.eraser,
                      onTap: () => setState(() => _tool = _Tool.eraser),
                    ),
                    const SizedBox(width: 8),
                    _ToolButton(
                      label: 'Stamp',
                      icon: Icons.emoji_emotions_rounded,
                      active: _tool == _Tool.stamp,
                      onTap: () => setState(() => _tool = _Tool.stamp),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (_tool == _Tool.stamp) ...[
                  const Text('Stamps',
                      style: TextStyle(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    children: [
                      for (final s in _stamps)
                        GestureDetector(
                          onTap: () => setState(() => _stamp = s),
                          child: Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _stamp == s
                                  ? const Color(0xFFFBBF24).withOpacity(0.2)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: _stamp == s
                                    ? const Color(0xFFFBBF24)
                                    : const Color(0xFFE5E7EB),
                                width: 2,
                              ),
                            ),
                            child: Text(s, style: const TextStyle(fontSize: 22)),
                          ),
                        ),
                    ],
                  ),
                ] else ...[
                  const Text('Colors',
                      style: TextStyle(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (final c in _palette)
                        GestureDetector(
                          onTap: () => setState(() => _color = c),
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: c,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _color == c
                                    ? const Color(0xFF1F2937)
                                    : const Color(0xFFE5E7EB),
                                width: _color == c ? 3 : 2,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
                const SizedBox(height: 14),
                const Text('Brush Size',
                    style: TextStyle(fontWeight: FontWeight.w900)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    for (final s in [3.0, 6.0, 10.0, 16.0])
                      GestureDetector(
                        onTap: () => setState(() => _size = s),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: _size == s
                                ? const Color(0xFF60A5FA)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _size == s
                                  ? const Color(0xFF60A5FA)
                                  : const Color(0xFFE5E7EB),
                              width: 2,
                            ),
                          ),
                          child: Container(
                            width: s + 4,
                            height: s + 4,
                            decoration: BoxDecoration(
                              color: _size == s
                                  ? Colors.white
                                  : const Color(0xFF1F2937),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    AppStateScope.of(context).addStars(1);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Drawing saved! ⭐ +1'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Color(0xFFFBBF24),
                        Color(0xFFF97316),
                      ]),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.download_rounded, color: Colors.white),
                          SizedBox(width: 6),
                          Text('Save',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => setState(() {
                  _actions.clear();
                  _current = [];
                }),
                child: Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.delete_rounded,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ToolButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;
  const _ToolButton({
    required this.label,
    required this.icon,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? const Color(0xFF60A5FA) : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: active
                  ? const Color(0xFF60A5FA)
                  : const Color(0xFFE5E7EB),
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 16,
                  color: active ? Colors.white : const Color(0xFF1F2937)),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: active ? Colors.white : const Color(0xFF1F2937),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawAction {
  final List<Offset> points;
  final Color color;
  final double size;
  final String? stamp;
  _DrawAction.path(this.points, this.color, this.size) : stamp = null;
  _DrawAction.stamp(Offset p, this.stamp, this.size)
      : points = [p],
        color = Colors.transparent;
}

class _DrawingPainter extends CustomPainter {
  final List<_DrawAction> actions;
  _DrawingPainter({required this.actions});

  @override
  void paint(Canvas canvas, Size size) {
    for (final a in actions) {
      if (a.stamp != null) {
        final tp = TextPainter(
          text: TextSpan(
            text: a.stamp,
            style: TextStyle(fontSize: a.size),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        tp.paint(
          canvas,
          a.points.first - Offset(tp.width / 2, tp.height / 2),
        );
      } else {
        final p = Paint()
          ..color = a.color
          ..strokeWidth = a.size
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;
        for (int i = 1; i < a.points.length; i++) {
          canvas.drawLine(a.points[i - 1], a.points[i], p);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DrawingPainter old) =>
      old.actions != actions;
}
