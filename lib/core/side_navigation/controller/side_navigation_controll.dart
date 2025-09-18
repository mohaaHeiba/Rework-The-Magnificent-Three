import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:the_magnificent_three/presentation/pages/detection/detaction_page.dart';
import 'package:the_magnificent_three/presentation/pages/history/history_page.dart';
import 'package:the_magnificent_three/presentation/pages/home/home_page.dart';
import 'package:the_magnificent_three/presentation/pages/settings/settings_page.dart';

class SidenavigationControll extends GetxController {
  final index = 0.obs;
  final isCollapsed = true.obs;

  final screens = [HomePage(), DetectionPage(), HistoryPage(), SettingsPage()];

  void changeIndex(int i) {
    index.value = i;
  }
}
