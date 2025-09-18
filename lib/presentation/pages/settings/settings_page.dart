import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:the_magnificent_three/core/constants/app_constraints.dart';
import 'package:the_magnificent_three/presentation/controllers/settings/settings_controll.dart';
import 'package:the_magnificent_three/presentation/pages/auth/auth_page.dart';

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
                    colors: [Colors.blue.shade50, Colors.blue.shade100],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // صورة المستخدم
                    const CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.blue,
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
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.email_outlined,
                                size: 18,
                                color: Colors.grey.shade700,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  controller.user.value!.email,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey.shade700,
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

              _buildInfoTile(icon: Icons.edit, title: "Edit  Email"),

              Obx(
                () => _buildSwitchTile(
                  icon: Icons.light_mode_outlined,
                  title: "Dark Mode",
                  value: controller.isDarkMode,
                  onChanged: (v) {
                    controller.isDarkMode.value = !controller.isDarkMode.value;
                  },
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
                      title: Text("this will be remove all data"),
                      content: Text('Are u sura about that'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            GetStorage().erase();
                            await controller.deleteData();
                            Get.offAll(AuthPage());
                            Get.delete<SettingsControll>();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: Text('clear'),
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
