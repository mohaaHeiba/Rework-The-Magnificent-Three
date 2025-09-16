import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_magnificent_three/app.dart';
import 'package:the_magnificent_three/controller/init_database.dart';
import 'package:the_magnificent_three/presentation/controllers/auth/auth_controll.dart';
import 'package:the_magnificent_three/presentation/controllers/splash/splash_controll.dart';

Future<void> main() async {
  // load Databse
  final init = Get.put(InitDatabase(), permanent: true);
  await init.initDatabase();

  Get.put(SplashControll());
  Get.put(AuthController());

  runApp(const MyApp());
}
