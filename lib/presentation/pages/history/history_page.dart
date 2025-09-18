import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_magnificent_three/presentation/pages/history/history_controller.dart';
import 'package:the_magnificent_three/domain/entities/patient_entity.dart';

class HistoryPage extends GetView<HistoryController> {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(Get.context!).colorScheme.background,

      body: RefreshIndicator(
        onRefresh: controller.refreshPatients,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            padding: const EdgeInsets.all(32.0),
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.hasError.value) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error loading data',
                        style: TextStyle(color: Colors.red[700], fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(controller.errorMessage.value),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: controller.loadPatients,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (controller.patients.isEmpty) {
                return Center(
                  child: Text(
                    'No patient records found',
                    style: TextStyle(
                      fontSize: 18,

                      color: Theme.of(
                        Get.context!,
                      ).colorScheme.onPrimaryContainer,
                    ),
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Text(
                    'Patient History',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,

                      color: Theme.of(
                        Get.context!,
                      ).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'View and manage all previous brain tumor analyses',
                    style: TextStyle(
                      fontSize: 16,

                      color: Theme.of(
                        Get.context!,
                      ).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Stats Cards Row
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'Total Scans',
                          controller.patients.length.toString(),
                          Icons.analytics,
                          Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          'Normal',
                          controller.patients
                              .where(
                                (p) => p.detected.toLowerCase() == 'notumor',
                              )
                              .length
                              .toString(),
                          Icons.check_circle,
                          Colors.green,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildStatCard(
                          'Abnormal',
                          controller.patients
                              .where(
                                (p) => p.detected.toLowerCase() != 'notumor',
                              )
                              .length
                              .toString(),
                          Icons.warning,
                          Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Data Table
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(
                          Get.context!,
                        ).colorScheme.primaryContainer,
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
                        children: [
                          // Table Header
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                Get.context!,
                              ).colorScheme.primaryContainer,

                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Patient Name',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,

                                      color: Theme.of(
                                        Get.context!,
                                      ).colorScheme.onPrimaryContainer,

                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Result',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,

                                      color: Theme.of(
                                        Get.context!,
                                      ).colorScheme.onPrimaryContainer,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Confidence',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,

                                      color: Theme.of(
                                        Get.context!,
                                      ).colorScheme.onPrimaryContainer,

                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Container(width: 60), // Space for actions
                              ],
                            ),
                          ),

                          // Table Body
                          Expanded(
                            child: ListView.builder(
                              itemCount: controller.patients.length,
                              itemBuilder: (context, index) {
                                return _buildTableRow(
                                  controller.patients[index],
                                  index,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(Get.context!).colorScheme.primaryContainer,

        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(Get.context!).colorScheme.onPrimaryContainer,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(Get.context!).colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(PatientEntity patient, int index) {
    final bool isNormal = patient.detected.toLowerCase() == 'notumor';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(Get.context!).colorScheme.primaryContainer,
      ),
      child: Row(
        children: [
          // Patient Name
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isNormal ? Colors.green : Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  patient.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(
                      Get.context!,
                    ).colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),

          // Result
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),

              child: Text(
                patient.detected,
                style: TextStyle(
                  fontSize: 13,
                  color: isNormal ? Colors.green[700] : Colors.red[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Confidence
          Expanded(
            flex: 2,
            child: Text(
              '${(patient.confidence).toStringAsFixed(1)}%',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,

                color: Theme.of(Get.context!).colorScheme.onPrimaryContainer,
              ),
            ),
          ),

          // Actions
          SizedBox(
            width: 60,
            child: IconButton(
              onPressed: () => _showDetailsDialog(Get.context!, patient),
              icon: Icon(Icons.more_horiz, color: Colors.grey[600], size: 20),
              tooltip: 'View Details',
            ),
          ),
        ],
      ),
    );
  }

  void _showDetailsDialog(BuildContext context, PatientEntity patient) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'Analysis Details',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDetailRow('Patient Name', patient.name),
                _buildDetailRow('Result', patient.detected),
                _buildDetailRow(
                  'Confidence',
                  '${(patient.confidence * 100).toStringAsFixed(1)}%',
                ),
                if (patient.pathimage.isNotEmpty)
                  Image.file(
                    File(patient.pathimage),
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.deletePatient(patient);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,

                color: Theme.of(Get.context!).colorScheme.onPrimary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Theme.of(Get.context!).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
