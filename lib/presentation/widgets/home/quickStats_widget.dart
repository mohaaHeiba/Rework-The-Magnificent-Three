import 'package:flutter/material.dart';

Widget buildQuickStats(ThemeData theme) {
  return Row(
    children: [
      Expanded(
        child: _buildStatCard(
          "Total Scans",
          "1,247",
          Icons.scanner_rounded,
          Colors.blue,
          theme,
        ),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: _buildStatCard(
          "Positive Cases",
          "89",
          Icons.warning_rounded,
          Colors.orange,
          theme,
        ),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: _buildStatCard(
          "Accuracy Rate",
          "94.2%",
          Icons.check_circle_rounded,
          Colors.green,
          theme,
        ),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: _buildStatCard(
          "Pending Reviews",
          "23",
          Icons.pending_actions_rounded,
          Colors.purple,
          theme,
        ),
      ),
    ],
  );
}

Widget _buildStatCard(
  String title,
  String value,
  IconData icon,
  Color color,
  ThemeData theme,
) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: theme.colorScheme.primaryContainer,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: color, size: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "+12%",
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: theme.colorScheme.onPrimaryContainer.withOpacity(0.7),
          ),
        ),
      ],
    ),
  );
}
