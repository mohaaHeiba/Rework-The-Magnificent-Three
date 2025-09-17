import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_magnificent_three/presentation/controllers/home/home_controll.dart';
import 'package:the_magnificent_three/presentation/widgets/home/below_contaoners_widgets.dart';
import 'package:the_magnificent_three/presentation/widgets/home/header_widget.dart';
import 'package:the_magnificent_three/presentation/widgets/home/quickStats_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeControll>();
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Obx(() => buildHeader(controller.user.value?.name, context, theme)),
            const SizedBox(height: 32),

            // Quick Stats Cards
            buildQuickStats(theme),
            const SizedBox(height: 32),

            // Main Content Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [buildRecentActivity(context, theme)],
                  ),
                ),
                const SizedBox(width: 24),

                // Right Column
                Expanded(
                  flex: 1,
                  child: Column(children: [buildSystemStatus(theme)]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
