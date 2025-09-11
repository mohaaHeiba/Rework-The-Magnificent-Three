import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:the_magnificent_three/presentation/pages/home/home_page.dart';

class WelcomeCaontroll extends GetxController {
  final opacity = 0.0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _loadSplash();
  }

  void _loadSplash() {
    Future.delayed(Duration(milliseconds: 100), () async {
      opacity.value = 1.0;
    });
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => HomePage(), transition: Transition.fadeIn);
    });
  }
}
