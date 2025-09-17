import 'package:flutter/material.dart';

Widget buildRecentActivity(ThemeData theme) {
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: theme.colorScheme.primaryContainer,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recent Activity",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            TextButton(onPressed: () {}, child: const Text("View All")),
          ],
        ),
        const SizedBox(height: 20),
        ...List.generate(
          4,
          (index) => buildActivityItem(
            "Patient #${1000 + index}",
            "MRI scan analyzed - ${index % 2 == 0 ? 'Negative' : 'Requires review'}",
            "${2 + index}h ago",
            index % 2 == 0 ? Colors.green : Colors.orange,
            theme,
          ),
        ),
      ],
    ),
  );
}

Widget buildActivityItem(
  String title,
  String subtitle,
  String time,
  Color statusColor,
  ThemeData theme,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: theme.colorScheme.onPrimaryContainer.withOpacity(0.5),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Text(
          time,
          style: TextStyle(
            color: theme.colorScheme.onPrimaryContainer.withOpacity(0.5),
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}

Widget buildSystemStatus(ThemeData theme) {
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: theme.colorScheme.primaryContainer,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "System Status",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(height: 20),
        buildStatusItem("AI Model", "Online", Colors.green, theme),
        buildStatusItem("Database", "Online", Colors.green, theme),
        buildStatusItem("Backup System", "Last: 2h ago", Colors.blue, theme),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 16),
              SizedBox(width: 8),
              Text(
                "All systems operational",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildStatusItem(
  String title,
  String status,
  Color color,
  ThemeData theme,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: theme.colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}
