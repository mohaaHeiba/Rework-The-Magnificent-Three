import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_magnificent_three/presentation/controllers/navigation_controll.dart';
import 'package:the_magnificent_three/presentation/widgets/navigation_widgets/build_navItem.dart';

class SideNavigations extends StatelessWidget {
  const SideNavigations({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NavigationControll>();

    return Scaffold(
      body: Obx(
        () => Row(
          children: [
            // Side Navigation Bar
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: MediaQuery.of(context).size.height,
              width: controller.isCollapsed.value ? 80 : 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF2E7D9A),
                    const Color(0xFF1E5A73),
                    const Color(0xFF0F3A4A),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(2, 0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Header Section
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 16,
                    ),
                    child: Column(
                      children: [
                        // App Logo/Icon
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.psychology,
                            size: 28,
                            color: Color(0xFF2E7D9A),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // App Title
                        if (!controller.isCollapsed.value) ...[
                          const Text(
                            "The Magnificent Three",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Brain Tumor Detection",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Divider
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    height: 1,
                    color: Colors.white.withOpacity(0.2),
                  ),

                  // Navigation Items
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        children: [
                          buildNavItem(
                            icon: Icons.dashboard_rounded,
                            title: "Dashboard",
                            isSelected: controller.index.value == 0,
                            isCollapsed: controller.isCollapsed.value,
                            onTap: () => controller.index.value = 0,
                          ),
                          buildNavItem(
                            icon: Icons.upload_file_rounded,
                            title: "Upload Scan",
                            isSelected: controller.index.value == 1,
                            isCollapsed: controller.isCollapsed.value,
                            onTap: () => controller.index.value = 1,
                          ),

                          buildNavItem(
                            icon: Icons.folder_shared_rounded,
                            title: "Reports",
                            isSelected: controller.index.value == 2,
                            isCollapsed: controller.isCollapsed.value,
                            onTap: () => controller.index.value = 2,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Section
                  Container(
                    padding: const EdgeInsets.all(1),
                    child: Column(
                      children: [
                        // Divider
                        Container(
                          height: 1,
                          color: Colors.white.withOpacity(0.2),
                        ),
                        const SizedBox(height: 16),

                        // Settings
                        buildNavItem(
                          icon: Icons.settings_rounded,
                          title: "Settings",
                          isSelected: controller.index.value == 3,
                          isCollapsed: controller.isCollapsed.value,
                          onTap: () => controller.index.value = 3,
                        ),

                        const SizedBox(height: 12),

                        // Toggle Button
                        SizedBox(
                          width: double.infinity,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () => controller.isCollapsed.value =
                                  !controller.isCollapsed.value,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  controller.isCollapsed.value
                                      ? Icons.chevron_right_rounded
                                      : Icons.chevron_left_rounded,
                                  color: Colors.white,
                                  size: 20,
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

            // Main Content
            Expanded(
              child: Container(
                color: const Color(0xFFF8F9FA), // Light background
                child: controller.screens[controller.index.value],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
