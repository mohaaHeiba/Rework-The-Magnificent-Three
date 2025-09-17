import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_magnificent_three/presentation/controllers/auth/auth_controll.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Obx(() {
          final user = controller.userData.value;

          if (user == null) {
            return const Text(
              'No user data',
              style: TextStyle(color: Colors.white),
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user.name,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                user.email,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: controller.deleteUser,
                child: const Text("Delete"),
              ),
              ElevatedButton(
                onPressed: controller.updateUser,
                child: const Text("Update"),
              ),
              ElevatedButton(
                onPressed: controller.getUser,
                child: const Text("Get"),
              ),
            ],
          );
        }),
      ),
    );
  }
}
