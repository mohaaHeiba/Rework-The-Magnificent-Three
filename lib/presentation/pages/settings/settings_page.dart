import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:the_magnificent_three/core/constants/app_constraints.dart';
import 'package:the_magnificent_three/core/theme/app_gradients.dart';
import 'package:the_magnificent_three/data/datasources/patient_dao.dart';
import 'package:the_magnificent_three/presentation/controllers/settings/settings_controll.dart';
import 'package:the_magnificent_three/presentation/pages/auth/auth_page.dart';
import 'package:the_magnificent_three/core/controller/init_database.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.find<SettingsControll>();

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.background,

        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // بطاقة البروفايل
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors:
                        theme.extension<AppGradients>()?.primary ??
                        [Colors.amber],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // صورة المستخدم
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: theme.colorScheme.background,
                      backgroundImage: null, // ضع صورة المستخدم هنا
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.user.value!.name,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.email_outlined,
                                size: 18,
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  controller.user.value!.email,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onPrimaryContainer,
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.h32,

              Text(
                "General Settings",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSpacing.h16,

              Obx(
                () => _buildSwitchTile(
                  icon: Icons.light_mode_outlined,
                  title: "Dark Mode",
                  value: controller.isDarkMode,
                  onChanged: (_) => controller.toggleTheme(),
                ),
              ),

              _buildInfoTile(
                icon: Icons.info_outline,
                title: "App Version",
                subtitle: "1.0.0",
              ),
              _buildInfoTile(
                icon: Icons.chat_bubble_outline,
                title: "Contact Us",
              ),

              AppSpacing.h32,

              Text(
                "Account",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSpacing.h16,
              ListTile(
                leading: const Icon(Icons.clear, color: Colors.red),
                title: const Text("Clear", style: TextStyle(color: Colors.red)),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Clear All Data"),
                      content: const Text(
                        'This will remove all patient records. Are you sure you want to continue?',
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              // Get PatientDao instance
                              final patientDao =
                                  Get.find<InitDatabase>().patientdao;

                              // Clear storage and patient data
                              await GetStorage().erase();
                              await patientDao.deleteAllPatients();

                              // Clear controller data
                              await controller.deleteData();

                              // Navigate to auth page and remove settings controller
                              Get.offAll(() => const AuthPage());
                              Get.delete<SettingsControll>();

                              // Show success message
                              Get.snackbar(
                                'Success',
                                'All data has been cleared',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                              );
                            } catch (e) {
                              // Show error message
                              print(e);
                              Get.snackbar(
                                'Error',
                                'Failed to clear data: $e',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Clear'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required RxBool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: Switch(
        value: value.value,
        onChanged: onChanged,
        activeColor: Colors.blue,
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    String? subtitle,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      onTap: () {},
    );
  }
}
