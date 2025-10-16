import 'package:flutter/material.dart';
import 'package:nsta_app/src/shared/widgets/buttons.dart';
import 'package:nsta_app/src/shared/widgets/sections.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double pad = MediaQuery.of(context).size.width > 600 ? 24 : 16;
    return Scaffold(
      appBar: AppBar(title: const Text('Your Progress')),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(pad),
          children: [
            SectionCard(
              title: 'Test Improvement',
              child: SizedBox(
                height: 160,
                child: CustomPaint(
                  painter: _PlaceholderChartPainter(color: Colors.red),
                  child: const Center(child: Text('Line Chart')),
                ),
              ),
            ),
            SectionCard(
              title: 'Strength vs Endurance vs Speed',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _Dot(label: 'STRENGTH'),
                  _Dot(label: 'ENDURANCE'),
                  _Dot(label: 'SPEED'),
                ],
              ),
            ),
            SectionCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  MetricItem(label: 'Avg vs Benchmark', value: '80/100'),
                  MetricItem(label: 'Best Performance', value: '95'),
                ],
              ),
            ),
            const SizedBox(height: 8),
            PrimaryButton(label: 'View Detailed Report', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final String label;
  const _Dot({required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
              color: Colors.redAccent, shape: BoxShape.circle),
        ),
        const SizedBox(height: 8),
        Text(label,
            style: const TextStyle(fontSize: 12, color: Colors.black54)),
      ],
    );
  }
}

class _PlaceholderChartPainter extends CustomPainter {
  final Color color;
  const _PlaceholderChartPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final Paint grid = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1;
    for (int i = 1; i < 4; i++) {
      final double y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
    final Paint line = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    final Path path = Path();
    for (int i = 0; i <= 10; i++) {
      final double x = size.width * i / 10;
      final double y = size.height * (0.6 + 0.3 * (i % 3 == 0 ? -1 : 1));
      if (i == 0)
        path.moveTo(x, y);
      else
        path.lineTo(x, y);
    }
    canvas.drawPath(path, line);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
