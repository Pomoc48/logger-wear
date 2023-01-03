import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';

class LineChart extends StatelessWidget {
  const LineChart({required this.data, super.key});

  final List<int> data;

  @override
  Widget build(BuildContext context) {
    List<double> dataConverted = [];

    for (int i in data) {
      dataConverted.add(i.toDouble());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28),
      child: Sparkline(
        lineWidth: 2,
        data: dataConverted,
        lineGradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.1),
            Theme.of(context).colorScheme.primary.withOpacity(0.4),
          ],
        ),
        fillGradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.0),
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
          ],
        ),
        fillMode: FillMode.below,
      ),
    );
  }
}
