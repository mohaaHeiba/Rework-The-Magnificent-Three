import 'package:get/get.dart';
import 'package:the_magnificent_three/domain/entities/auth_entity.dart';
import 'package:the_magnificent_three/presentation/controllers/auth/auth_controll.dart';
import 'package:the_magnificent_three/presentation/controllers/settings/settings_controll.dart';

class HomeControll extends GetxController {
  final controller = Get.find<AuthController>();

  final user = Rxn<AuthEntity>();

  @override
  Future<void> onInit() async {
    super.onInit();
    loadUser();
  }

  Future<void> loadUser() async {
    user.value = await controller.getUser();
    s();
  }

  Future<void> s() async {
    Get.put(SettingsControll());
  }
}
