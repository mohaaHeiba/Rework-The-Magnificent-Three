import 'package:get/get.dart';
import 'package:the_magnificent_three/presentation/pages/home/home_page.dart';

class SidenavigationControll extends GetxController {
  final index = 0.obs;
  final isCollapsed = true.obs;

  final screens = [HomePage()];

  void changeIndex(int i) {
    index.value = i;
  }
}
