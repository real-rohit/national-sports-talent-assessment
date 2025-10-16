import 'package:flutter/material.dart';
import 'package:nsta_app/src/shared/widgets/buttons.dart';
import 'package:nsta_app/src/shared/widgets/sections.dart';

class TestResultScreen extends StatelessWidget {
  static const String route = '/tests/result';
  const TestResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double pad = MediaQuery.of(context).size.width > 600 ? 24 : 16;
    return Scaffold(
      appBar: AppBar(title: const Text('Test Results')),
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.all(pad),
        child: PrimaryButton(
            label: 'Save Result',
            onPressed: () => Navigator.of(context).pushNamed('/dashboard')),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(pad),
          children: [
            SectionCard(
              child: Row(
                children: const [
                  Expanded(
                      child: MetricItem(
                          label: 'Vertical Jump',
                          value: '28.5 in',
                          caption: '+3.2%')),
                  Pill(
                      text: 'Success',
                      icon: Icons.check_circle,
                      color: Colors.green),
                ],
              ),
            ),
            SectionCard(
              title: 'Comparison',
              child: SizedBox(
                height: 160,
                child: CustomPaint(
                  painter: _PlaceholderChartPainter(),
                  child: const Center(child: Text('Chart Placeholder')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderChartPainter extends CustomPainter {
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
      ..color = Colors.green
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final Path path = Path();
    for (int i = 0; i <= 10; i++) {
      final double x = size.width * i / 10;
      final double y = size.height * (0.5 + 0.3 * (i % 2 == 0 ? -1 : 1));
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
