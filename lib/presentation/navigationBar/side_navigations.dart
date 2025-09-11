import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:the_magnificent_three/presentation/controllers/navigation_controll.dart';

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
            SideNavigationBar(
              selectedIndex: controller.index.value,
              items: const [
                SideNavigationBarItem(icon: Icons.home, label: 'Home'),
                SideNavigationBarItem(icon: Icons.settings, label: 'detaction'),
                SideNavigationBarItem(icon: Icons.person, label: 'Profile'),
              ],
              onTap: (index) {
                controller.changeIndex(index);
              },
            ),
            // Main Content
            Expanded(child: controller.screens[controller.index.value]),
          ],
        ),
      ),
    );
  }
}
