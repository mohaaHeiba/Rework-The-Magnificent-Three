import 'package:get/get.dart';
import 'package:the_magnificent_three/domain/entities/auth_entity.dart';
import 'package:the_magnificent_three/presentation/controllers/auth/auth_controll.dart';

class HomeControll extends GetxController {
  final controller = Get.find<AuthController>();

  final user = Rxn<AuthEntity>();

  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  Future<void> loadUser() async {
    user.value = await controller.getUser();
  }
}
