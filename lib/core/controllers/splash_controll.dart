import 'package:get/get.dart';
import 'package:the_magnificent_three/core/widgets/side_navigations.dart';
import 'package:the_magnificent_three/features/signup/presentation/page/sign_up_page.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
      Get.off(
        () => kIsWeb ? SignUpPage() : SideNavigations(),
        transition: Transition.fadeIn,
      );
    });
  }
}
