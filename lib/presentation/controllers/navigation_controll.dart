import 'package:get/get.dart';
import 'package:the_magnificent_three/presentation/pages/detactions/detaction_page.dart';
import 'package:the_magnificent_three/presentation/pages/home/home_page.dart';
import 'package:the_magnificent_three/presentation/pages/settings/setting_page.dart';

class NavigationControll extends GetxController {
  final index = 0.obs;

  final screens = [HomePage(), DetactionPage(), SettingPage()];

  void changeIndex(int i) {
    index.value = i;
  }
}
