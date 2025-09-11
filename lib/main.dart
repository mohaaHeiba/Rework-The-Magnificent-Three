import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_magnificent_three/app.dart';
import 'package:the_magnificent_three/presentation/controllers/navigation_controll.dart';

import 'package:the_magnificent_three/presentation/controllers/welcome_caontroll.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(WelcomeCaontroll());
  Get.put(NavigationControll());

  runApp(const MyApp());
}
