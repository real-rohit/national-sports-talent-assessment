import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  final String? title;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const SectionCard({super.key, this.title, required this.child, this.padding, this.margin});

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry resolvedPadding = padding ?? const EdgeInsets.all(16);
    final EdgeInsetsGeometry resolvedMargin = margin ?? const EdgeInsets.symmetric(vertical: 8);
    return Container(
      margin: resolvedMargin,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: resolvedPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Text(title!, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
            ],
            child,
          ],
        ),
      ),
    );
  }
}

class MetricItem extends StatelessWidget {
  final String label;
  final String value;
  final String? caption;
  final Color? color;

  const MetricItem({super.key, required this.label, required this.value, this.caption, this.color});

  @override
  Widget build(BuildContext context) {
    final Color resolved = color ?? Theme.of(context).colorScheme.primary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.black54)),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: resolved)),
            if (caption != null) ...[
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(caption!, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class Pill extends StatelessWidget {
  final String text;
  final Color? color;
  final IconData? icon;

  const Pill({super.key, required this.text, this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    final Color bg = (color ?? Theme.of(context).colorScheme.primary).withOpacity(0.12);
    final Color fg = color ?? Theme.of(context).colorScheme.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: fg, size: 14),
            const SizedBox(width: 6),
          ],
          Text(text, style: TextStyle(color: fg, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class ResponsiveGrid extends StatelessWidget {
  final int minCrossAxisCount;
  final double childAspectRatio;
  final double spacing;
  final List<Widget> children;

  const ResponsiveGrid({super.key, this.minCrossAxisCount = 2, this.childAspectRatio = 1.2, this.spacing = 12, required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int cross = minCrossAxisCount;
        if (constraints.maxWidth > 1200) cross = 4;
        else if (constraints.maxWidth > 900) cross = 3;
        else if (constraints.maxWidth > 600) cross = 2;
        else cross = 2;
        return GridView.count(
          crossAxisCount: cross,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
          childAspectRatio: childAspectRatio,
          children: children,
        );
      },
    );
  }
}


