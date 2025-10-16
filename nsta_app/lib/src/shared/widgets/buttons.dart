import 'package:flutter/material.dart';
import 'package:nsta_app/src/core/theme/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool destructive;
  final EdgeInsetsGeometry? padding;

  const PrimaryButton(
      {super.key,
      required this.label,
      this.onPressed,
      this.destructive = false,
      this.padding});

  @override
  Widget build(BuildContext context) {
    final Color bg = destructive ? AppTheme.primaryRed : AppTheme.primaryRed;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: padding ?? const EdgeInsets.symmetric(vertical: 14),
          backgroundColor: bg,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const SecondaryButton({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          side: const BorderSide(color: Color(0xffe0e0e0)),
        ),
        child: Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.w700, color: Colors.black54)),
      ),
    );
  }
}
