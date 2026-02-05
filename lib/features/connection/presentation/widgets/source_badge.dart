import 'package:flutter/material.dart';

class SourceBadge extends StatelessWidget {
  const SourceBadge._({required this.label, required this.icon, required this.color});

  final String label;
  final IconData icon;
  final Color color;

  const SourceBadge.cloud({super.key})
      : label = '云端',
        icon = Icons.cloud_outlined,
        color = const Color(0xFF7AA2FF);

  const SourceBadge.local({super.key})
      : label = '本地',
        icon = Icons.phone_android_outlined,
        color = const Color(0xFF6EE7B7);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}
