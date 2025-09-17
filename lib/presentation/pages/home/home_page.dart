import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_magnificent_three/domain/entities/auth_entity.dart';
import 'package:the_magnificent_three/presentation/controllers/auth/auth_controll.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final data = controller.userData.value;

    return Column(
      spacing: 15,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(data!.name ?? 'asdasd', style: TextStyle(color: Colors.white)),
        Text(data!.email ?? '', style: TextStyle(color: Colors.white)),
        ElevatedButton(
          onPressed: controller.deleteUser,
          child: const Text("Delete"),
        ),
        ElevatedButton(
          onPressed: controller.updateUser,
          child: const Text("Update"),
        ),
        ElevatedButton(onPressed: controller.getUser, child: const Text("Get")),
      ],
    );
  }
}
