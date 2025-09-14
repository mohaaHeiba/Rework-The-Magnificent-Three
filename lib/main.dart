import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_magnificent_three/app.dart';
import 'package:the_magnificent_three/presentation/controllers/splash/splash_controll.dart';

Future<void> main() async {
  Get.put(SplashControll());
  runApp(const MyApp());
}
