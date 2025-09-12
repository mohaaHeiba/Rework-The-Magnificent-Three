import 'package:get/get.dart';
import 'package:the_magnificent_three/feature/detactions/presentation/page/detaction_page.dart';
import 'package:the_magnificent_three/feature/home/presentation/page/home_page.dart';
import 'package:the_magnificent_three/feature/report/presentation/page/report_page.dart';
import 'package:the_magnificent_three/feature/settings/presentation/page/setting_page.dart';

class NavigationControll extends GetxController {
  final index = 0.obs;
  final isCollapsed = true.obs;

  final screens = [HomePage(), DetactionPage(), ReportPage(), SettingPage()];

  void changeIndex(int i) {
    index.value = i;
  }
}
