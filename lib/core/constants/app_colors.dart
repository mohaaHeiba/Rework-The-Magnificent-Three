import 'package:flutter/material.dart';
import 'package:the_magnificent_three/core/theme/app_gradients.dart';

class AppColors {
  //light theme
  static const Color primaryLight = Color(0xFF3B8A99);
  static const Color onPrimaryLight = Colors.white;
  static const Color errorLight = Color(0xFFD32F2F);
  static const Color onErrorLight = Colors.white;
  static const Color containerLight = Colors.white;
  static const Color surfaceLight = Colors.white;
  static const Color onSurfaceLight = Color(0xFF333333);
  static const Color backGroundlight = Color.fromARGB(255, 238, 238, 238);

  static const AppGradients gradientsLight = AppGradients(
    primary: [Color(0xFF2E7D9A), Color(0xFF1E5A73), Color(0xFF0D3D56)],
    nav: [Color(0xFF2E7D9A), Color(0xFF1E5A73), Color(0xFF0D3D56)],
  );

  //dark theme
  static const Color primaryDark = Color(0xFF3B8A99);
  static const Color onPrimaryDark = Colors.black;
  static const Color errorDark = Color(0xFFEF5350);
  static const Color onErrorDark = Colors.black;
  static const Color containerDark = Color.fromARGB(255, 66, 66, 66);

  static const Color surfaceDark = Color(0xFF2D2D2D);
  static const Color onSurfaceDark = Color(0xFFE0E0E0);
  static const Color backGroundDark = Color.fromARGB(255, 33, 33, 33);

  static const AppGradients gradientsDark = AppGradients(
    primary: [Color(0xFF424242), Color(0xFF212121), Colors.black],
    nav: [Colors.black, Colors.black, Colors.black],
  );
}
