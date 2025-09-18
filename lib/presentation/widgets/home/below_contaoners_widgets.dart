import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_magnificent_three/presentation/controllers/home/home_controll.dart';

Widget buildRecentActivity(ThemeData theme) {
  final controller = Get.find<HomeControll>();

  // Refresh data when widget is built
  controller.loadHistoryData();

  return Container(
    padding: const EdgeInsets.only(top: 24, bottom: 12, right: 24, left: 24),
    decoration: BoxDecoration(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Obx(() {
          if (controller.recentPatients.isEmpty) {
            return const Center(child: Text('No recent activity'));
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            // Update to use actual length of recentPatients
            itemCount: 4,
            separatorBuilder: (context, index) => const SizedBox(),
            itemBuilder: (context, index) {
              final patient = controller.recentPatients[index];
              final isNormal = patient.detected.toLowerCase() == 'notumor';

              return ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isNormal
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isNormal ? Icons.check_circle : Icons.warning,
                    color: isNormal ? Colors.green : Colors.red,
                  ),
                ),
                title: Text(patient.name, style: TextStyle(fontSize: 16)),
                subtitle: Text(
                  patient.detected,
                  style: TextStyle(fontSize: 14),
                ),
                trailing: Text(
                  '${(patient.confidence).toStringAsFixed(1)}%',
                  style: TextStyle(
                    color: isNormal ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          );
        }),
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
