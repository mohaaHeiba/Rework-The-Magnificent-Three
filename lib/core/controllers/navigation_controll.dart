import 'package:get/get.dart';
import 'package:the_magnificent_three/features/detections/presentation/page/detection_page.dart';
import 'package:the_magnificent_three/features/home/presentation/page/home_page.dart';
import 'package:the_magnificent_three/features/report/presentation/page/report_page.dart';
import 'package:the_magnificent_three/features/settings/presentation/page/setting_page.dart';

class NavigationControll extends GetxController {
  final index = 0.obs;
  final isCollapsed = true.obs;

  final screens = [HomePage(), DetectionPage(), ReportPage(), SettingPage()];

  void changeIndex(int i) {
    index.value = i;
  }
}
