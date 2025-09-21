// main.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

void main() => runApp(const TaskApp());

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task App',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFDFDFD),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFECEFF1),
          foregroundColor: Colors.black87,
        ),
        cardTheme: CardThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 3,
        ),
      ),
      home: const TaskListPage(),
    );
  }
}

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  static final _demoTasks = [
    {
      'title': 'Write unit tests',
      'description': 'Cover TaskCard widget and interactive behavior.',
      'priority': 'High',
      'deadline': 'Sep 25, 2025 • 5:00 PM',
      'icon': Icons.bug_report, // 🐞 test/debug icon
    },
    {
      'title': 'Refactor auth',
      'description': 'Move logic into a reusable AuthService and clean up UI.',
      'priority': 'Low',
      'deadline': 'Sep 28, 2025 • 2:30 PM',
      'icon': Icons.lock_open, // 🔐 auth/security icon
    },
    {
      'title': 'Design review',
      'description': 'Prepare slides for Friday review with product.',
      'priority': 'High',
      'deadline': 'Sep 30, 2025 • 9:00 AM',
      'icon': Icons.palette, // 🎨 design icon
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // -------------------
            // User Profile Header
            // -------------------
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFFAF3F3), // pastel pink header
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?img=12',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ana Victoria",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      Text("Productivity Mode: On",
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ],
              ),
            ),

            // -------------------
            // Task List
            // -------------------
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: _demoTasks.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, i) {
                  final t = _demoTasks[i];
                  return TaskCard(
                    title: t['title']! as String,
                    description: t['description']! as String,
                    priority: t['priority']! as String,
                    deadline: t['deadline']! as String,
                    colorIndex: i,
                    icon: t['icon'] as IconData,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddModal(context),
        backgroundColor: const Color(0xFFB5EAEA),
        child: const Icon(Icons.add, color: Colors.black87),
      ),
    );
  }

  void _openAddModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Add Task', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                const TextField(decoration: InputDecoration(labelText: 'Title')),
                const SizedBox(height: 8),
                const TextField(
                  maxLines: 2,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(height: 8),
                const TextField(
                  decoration: InputDecoration(labelText: 'Deadline (e.g., Sep 25, 2025 • 5:00 PM)'),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFC6E2E9)),
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Create (UI only)'))),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// ---------------------------
/// TaskCard with icon + pastel colors
/// ---------------------------
class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String priority;
  final String deadline;
  final int colorIndex;
  final IconData icon;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.priority,
    required this.deadline,
    required this.colorIndex,
    required this.icon,
  });

  static final List<Color> pastelColors = [
    Color(0xFFFFF1E6), // pastel orange
    Color(0xFFE4FBFF), // pastel blue
    Color(0xFFFBEAFF), // pastel purple
    Color(0xFFD6E5FA), // pastel light blue
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: pastelColors[colorIndex % pastelColors.length],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Leading icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.black87, size: 28),
            ),
            const SizedBox(width: 16),

            // Task info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                )),
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
                    children: [
                      IconLabel(icon: Icons.comment, label: '2 comments'),
                      const SizedBox(width: 12),
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

/// ---------------------------
/// Reusable IconLabel widget
/// ---------------------------
class IconLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  const IconLabel({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.black87),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: Colors.black87)),
      ],
    );
  }
}