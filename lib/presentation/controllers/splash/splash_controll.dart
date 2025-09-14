import 'package:get/get.dart';
import 'package:the_magnificent_three/presentation/pages/auth/auth_page.dart';

class SplashControll extends GetxController {
  final opacity = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSplash();
  }

  void _loadSplash() {
    Future.delayed(Duration(milliseconds: 100), () async {
      opacity.value = 1.0;
    });
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => AuthPage(), transition: Transition.fadeIn);
    });
  }
}
