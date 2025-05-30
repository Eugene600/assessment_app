import 'package:flutter/material.dart';

class LegendIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const LegendIcon({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 4),
        Text(label, style: theme.textTheme.bodyMedium),
      ],
    );
  }
}
