import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:the_magnificent_three/core/theme/app_gradients.dart';
import 'package:the_magnificent_three/data/service/detection_service.dart';
import 'package:the_magnificent_three/data/datasources/patient_dao.dart';
import 'package:the_magnificent_three/domain/entities/patient_entity.dart';
import 'package:the_magnificent_three/presentation/controllers/home/home_controll.dart';
import 'package:the_magnificent_three/presentation/pages/history/history_controller.dart';

class DetectionController extends GetxController {
  final Rx<File?> selectedImage = Rx<File?>(null);
  final isAnalyzing = false.obs;
  final TextEditingController patientController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  // Add DAO field
  final PatientDao patientDao;

  // Modify constructor to accept DAO
  DetectionController({required this.patientDao});

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to pick image: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void removeImage() {
    selectedImage.value = null;
  }

  Future<void> analyzeImage() async {
    if (selectedImage.value == null) return;

    isAnalyzing.value = true;
    try {
      if (detectionService.interpreter == null) {
        await detectionService.loadModel();
      }

      final result = await detectionService.analyze(selectedImage.value!);
      final idx = result['index'];
      final conf = result['confidence'] * 100;
      _showResultDialog(idx, conf);
    } catch (e) {
      print(e);
      Get.snackbar(
        "Analysis Error",
        "Failed to analyze image: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isAnalyzing.value = false;
    }
  }

  void _showResultDialog(int idx, double confidence) {
    final TextEditingController noteController = TextEditingController();
    final String resultClass = detectionService.classes[idx];
    final Color resultColor = _getColorForConfidence(confidence);
    final String patientName = patientController.text.trim().isNotEmpty
        ? patientController.text.trim()
        : 'Unknown Patient';

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        elevation: 24,
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 900, maxHeight: 700),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Left Section: Enhanced Image Display
                Flexible(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(28),
                        bottomLeft: Radius.circular(28),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors:
                            Theme.of(
                              Get.context!,
                            ).extension<AppGradients>()?.primary ??
                            [Colors.amber],
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Background pattern (optional enhancement)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(28),
                                bottomLeft: Radius.circular(28),
                              ),
                              gradient: RadialGradient(
                                center: Alignment.topRight,
                                radius: 1.5,
                                colors: [
                                  Colors.white.withOpacity(0.1),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Enhanced image display with loading states
                              Hero(
                                tag: 'selected_image',
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 15,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: selectedImage.value != null
                                        ? Image.file(
                                            selectedImage.value!,
                                            width: double.infinity,
                                            height: 300,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return _buildImagePlaceholder(
                                                    300,
                                                  );
                                                },
                                          )
                                        : _buildImagePlaceholder(300),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Patient name with icon
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.person_outline,
                                      color: Colors.white.withOpacity(0.9),
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Flexible(
                                      child: Text(
                                        patientName,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Right Section: Enhanced Content Area
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Enhanced header with status indicator
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Analysis Results',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[800],
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Medical Image Classification',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Status indicator
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: resultColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: resultColor.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: resultColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    _getConfidenceLabel(confidence),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: resultColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: Icon(
                                Icons.close_rounded,
                                color: Colors.grey[600],
                              ),
                              onPressed: () {
                                noteController.dispose();
                                Get.back();
                              },
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.grey[100],
                                padding: const EdgeInsets.all(8),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // Enhanced Analysis Cards
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Results section
                                Text(
                                  'Classification Results',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                const SizedBox(height: 16),

                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildEnhancedDetailCard(
                                        icon: Icons.category_rounded,
                                        label: 'Detected Class',
                                        value: resultClass,
                                        color: Colors.blue.shade50,
                                        iconColor: Colors.blue.shade600,
                                        valueColor: Colors.blue.shade800,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _buildEnhancedDetailCard(
                                        icon: Icons.analytics_rounded,
                                        label: 'Confidence',
                                        value:
                                            '${confidence.toStringAsFixed(1)}%',
                                        color: resultColor.withOpacity(0.1),
                                        iconColor: resultColor,
                                        valueColor: resultColor,
                                        showProgressBar: true,
                                        confidence: confidence,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 32),

                                // Notes Section
                                Text(
                                  'Clinical Notes',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                const SizedBox(height: 16),

                                Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.grey[200]!,
                                      width: 1,
                                    ),
                                  ),
                                  child: TextField(
                                    controller: noteController,
                                    maxLines: null,
                                    expands: true,
                                    textAlignVertical: TextAlignVertical.top,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      height: 1.4,
                                    ),
                                    decoration: InputDecoration(
                                      hintText:
                                          'Enter clinical observations, treatment notes, or additional remarks...',
                                      hintStyle: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 15,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.all(16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Enhanced Action Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                noteController.dispose();
                                Get.back();
                              },
                              icon: const Icon(Icons.close_rounded, size: 18),
                              label: const Text('Cancel'),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.grey[600],
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),

                            FilledButton.icon(
                              onPressed: () => _handleSaveRecord(
                                noteController,
                                idx: idx,
                                confidence: confidence,
                              ),
                              icon: const Icon(Icons.save_rounded, size: 20),
                              label: const Text('Save Record'),
                              style: FilledButton.styleFrom(
                                backgroundColor: Theme.of(
                                  Get.context!,
                                ).primaryColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  // Enhanced helper methods
  Widget _buildImagePlaceholder(double height) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_outlined,
            size: 60,
            color: Colors.white.withOpacity(0.7),
          ),
          const SizedBox(height: 12),
          Text(
            'Image Preview',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedDetailCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required Color iconColor,
    Color? valueColor,
    bool showProgressBar = false,
    double confidence = 0.0,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: iconColor.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const Spacer(),
              if (showProgressBar)
                Container(
                  width: 4,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.bottomCenter,
                    heightFactor: confidence / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: iconColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: valueColor ?? iconColor,
            ),
          ),
        ],
      ),
    );
  }

  String _getConfidenceLabel(double confidence) {
    if (confidence > 90) return 'High';
    if (confidence > 70) return 'Good';
    if (confidence > 50) return 'Medium';
    return 'Low';
  }

  Future<void> _handleSaveRecord(
    TextEditingController noteController, {
    required int idx,
    required double confidence,
  }) async {
    try {
      // Create PatientEntity object
      final patient = PatientEntity(
        null,
        name: patientController.text.trim().isNotEmpty
            ? patientController.text.trim()
            : 'Unknown Patient',

        detected: detectionService.classes[idx],
        pathimage: selectedImage.value?.path ?? '',
        confidence: confidence,
      );

      // Insert into database
      await patientDao.insertPatients(patient);

      // Close dialog first
      Get.back();

      // Refresh both history and home controllers
      if (Get.isRegistered<HistoryController>()) {
        final historyController = Get.find<HistoryController>();
        await historyController.refreshPatients();
      }

      // Refresh home page data
      if (Get.isRegistered<HomeControll>()) {
        final homeController = Get.find<HomeControll>();
        await homeController.loadHistoryData();
      }

      // Show success feedback
      Get.snackbar(
        "Success",
        "Patient record saved successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        icon: const Icon(Icons.check_circle, color: Colors.white),
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to save patient record: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      noteController.dispose();
    }
  }

  // Updated Helper widget to build the information cards.
  Widget _buildDetailCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    Color? valueColor,
    bool showIndicator = false,
    double confidence = 0.0,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15), // Slightly more rounded cards
        border: Border.all(
          color: color.withOpacity(0.5), // Subtle border
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueGrey[600], size: 24),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blueGrey[500],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color:
                        valueColor ??
                        Colors.blueGrey[800], // Use valueColor or default
                  ),
                ),
              ],
            ),
          ),
          if (showIndicator)
            Container(
              width: 8,
              height: 40,
              decoration: BoxDecoration(
                color: _getColorForConfidence(confidence).withOpacity(0.8),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
        ],
      ),
    );
  }

  // Helper function to get a color based on confidence level.
  Color _getColorForConfidence(double confidence) {
    if (confidence > 90) {
      return Colors.green.shade600;
    } else if (confidence > 70) {
      return Colors.orange.shade600;
    } else if (confidence > 50) {
      return Colors.amber.shade600;
    } else {
      return Colors.red.shade600;
    }
  }

  @override
  void onClose() {
    patientController.dispose();
    super.onClose();
  }

  late final DetectionService detectionService;

  @override
  void onInit() {
    super.onInit();
    detectionService = DetectionService();
    _initModel();
  }

  Future<void> _initModel() async {
    await detectionService.loadModel();
  }
}
