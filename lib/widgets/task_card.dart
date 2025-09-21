import 'package:flutter/material.dart';
import 'icon_label.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String priority;
  final String deadline;
  final IconData icon;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.priority,
    required this.deadline,
    required this.icon,
  });

  Color get _priorityColor =>
      priority.toLowerCase() == 'high' ? Colors.redAccent : Colors.green;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Leading Icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.black87, size: 28),
            ),
            const SizedBox(width: 16),

            // Task Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                      ),
                      _PriorityBadge(priority: priority),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.black87)),
                  const SizedBox(height: 8),
                  IconLabel(icon: Icons.calendar_today_rounded, label: deadline),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      IconLabel(icon: Icons.comment, label: '2 comments'),
                      SizedBox(width: 12),
                      IconLabel(icon: Icons.check_circle_outline, label: '0 done'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PriorityBadge extends StatelessWidget {
  final String priority;
  const _PriorityBadge({required this.priority});

  Color get _color =>
      priority.toLowerCase() == 'high' ? Colors.redAccent : Colors.green;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(priority,
          style: TextStyle(color: _color, fontWeight: FontWeight.w600)),
    );
  }
}