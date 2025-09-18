import 'package:get/get.dart';
import 'package:the_magnificent_three/domain/entities/auth_entity.dart';
import 'package:the_magnificent_three/presentation/controllers/auth/auth_controll.dart';
import 'package:the_magnificent_three/presentation/controllers/home/home_controll.dart';

class SettingsControll extends GetxController {
  final controller = Get.find<AuthController>();
  final c = Get.find<HomeControll>();

  final user = Rxn<AuthEntity>();

  final RxBool isDarkMode = false.obs;

  Future<void> loadData() async {
    user.value = c.user.value;
  }

  Future<void> deleteData() async {
    await controller.deleteUser();
  }

  Future<void> updateData() async {
    await controller.updateUser();
  }

  @override
  void onInit() {
    super.onInit();
    loadData();
  }
}
