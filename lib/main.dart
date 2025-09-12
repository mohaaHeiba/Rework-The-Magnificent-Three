import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_magnificent_three/app.dart';
import 'package:the_magnificent_three/features/signup/presentation/controller/sign_up_controll.dart';
import 'package:the_magnificent_three/core/controllers/navigation_controll.dart';
import 'package:the_magnificent_three/core/controllers/splash_controll.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(SplashControll());
  Get.put(NavigationControll());
  Get.lazyPut(() => InsertDataController());

  runApp(const MyApp());
}
