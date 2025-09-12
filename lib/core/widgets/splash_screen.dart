import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_magnificent_three/core/controllers/splash_controll.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SplashControll>();
    return Scaffold(
      body: Center(
        child: Obx(
          () => AnimatedOpacity(
            opacity: controller.opacity.value,
            duration: Duration(seconds: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.assistant,
                  size: 100,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                const SizedBox(height: 20),
                Text(
                  'Brain tumor classification',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Text(
                      'Your AI Assistant',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      'Odysera',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
