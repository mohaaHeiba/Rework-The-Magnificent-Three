import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_magnificent_three/presentation/pages/detection/detection_controller.dart';

class DetectionPage extends GetView<DetectionController> {
  const DetectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // This listener will force a rebuild of the button's Obx block
    // whenever the text in the patient name field changes.
    // We put it here to ensure the listener is active as soon as the widget is built.
    controller.patientController.addListener(() {
      controller.update();
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background,
        elevation: 0,
        title: Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              border: Border.all(color: Colors.green, width: 1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle, color: Colors.green, size: 12),
                SizedBox(width: 8),
                Text(
                  'Server Online',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: theme.colorScheme.background,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Subtitle
              Text(
                'Brain Tumor Detection',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Upload your MRI image to analyze it',
                style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 32),

              // Upload Area
              GestureDetector(
                onTap: controller.pickImage,
                child: Container(
                  width: double.infinity,
                  height: 330,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: theme.colorScheme.onPrimaryContainer.withOpacity(
                        0.4,
                      ),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: theme.colorScheme.background,
                  ),
                  child: Obx(
                    () => controller.selectedImage.value != null
                        ? Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  controller.selectedImage.value!,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: GestureDetector(
                                  onTap: controller.removeImage,
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.close, size: 16),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.cloud_upload_outlined, size: 40),
                              const SizedBox(height: 20),
                              Text(
                                'Drop image here or click to browse',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: theme.colorScheme.onPrimaryContainer
                                      .withOpacity(0.6),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Patient Name and Classify Button Row
              GetBuilder<DetectionController>(
                builder: (_) => Row(
                  children: [
                    // Patient Name Input
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: controller.patientController,
                        decoration: InputDecoration(
                          hintText: 'Enter Patient name',
                          hintStyle: TextStyle(
                            color: theme.colorScheme.onPrimaryContainer
                                .withOpacity(0.4),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: theme.colorScheme.onPrimaryContainer
                                  .withOpacity(0.4),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: theme.colorScheme.onPrimaryContainer
                                  .withOpacity(0.4)!,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Classify Button
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed:
                              (controller.selectedImage.value != null &&
                                  !controller.isAnalyzing.value &&
                                  controller.patientController.text
                                      .trim()
                                      .isNotEmpty)
                              ? controller.analyzeImage
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            disabledBackgroundColor: Colors.green.withOpacity(
                              0.4,
                            ),
                            elevation: 0,
                          ),
                          child: controller.isAnalyzing.value
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : const Text(
                                  'Classify',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
