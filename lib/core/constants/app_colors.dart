import 'package:flutter/material.dart';

class AppColors {
  //light theme
  static const Color primaryLight = Color(0xFF3B8A99);
  static const Color onPrimaryLight = Colors.white;
  static const Color errorLight = Color(0xFFD32F2F);
  static const Color onErrorLight = Colors.white;
  static const Color backgroundLight = Color.fromARGB(255, 189, 189, 189);
  static const Color onBackgroundLight = Color(0xFF333333);
  static const Color surfaceLight = Colors.white;
  static const Color onSurfaceLight = Color(0xFF333333);

  //dark theme
  static const Color primaryDark = Color(0xFF66BB6A);
  static const Color onPrimaryDark = Colors.black;
  static const Color errorDark = Color(0xFFEF5350);
  static const Color onErrorDark = Colors.black;
  static const Color backgroundDark = Color(0xFF212121);
  static const Color onBackgroundDark = Color(0xFFE0E0E0);
  static const Color surfaceDark = Color(0xFF2D2D2D);
  static const Color onSurfaceDark = Color(0xFFE0E0E0);

  // --- الخطوة 2: تعريف نسخ من التدرجات لكل ثيم ---
  // تدرج الوضع الفاتح
  // final appGradientsLight = const AppGradients(primary: [
  // Color(0xFF3B8A99), // نفس لون الهيدر كنقطة بداية
  // Color(0xFF29626D),   // لون أزرق أغمق قليلاً كنقطة نهاية
  // ]);

  // تدرج الوضع الداكن
  // final appGradientsDark = const AppGradients(primary: [
  //   Color(0xFF66BB6A), // نفس اللون الأساسي للوضع الداكن
  //   Color(0xFF43A047), // لون أخضر أغمق قليلاً
  // ]);
}

  // // --- الخطوة 1: إنشاء ThemeExtension خاص بالتدرجات اللونية ---
  // // هذا الكلاس سيحمل قائمة الألوان الخاصة بالتدرج
  // @immutable
  // class AppGradients extends ThemeExtension<AppGradients> {
  //   const AppGradients({required this.primary});

  //   final List<Color> primary;

  //   @override
  //   AppGradients copyWith({List<Color>? primary}) {
  //     return AppGradients(primary: primary ?? this.primary);
  //   }

  //   // lerp ضرورية لعملアニメーション عند التبديل بين الثيمات
  //   @override
  //   AppGradients lerp(ThemeExtension<AppGradients>? other, double t) {
  //     if (other is! AppGradients) {
  //       return this;
  //     }
  //     // *** التصحيح هنا ***
  //     // نقوم بالمرور على كل لون في القائمة وعمل lerp له بشكل منفرد
  //     return AppGradients(
  //       primary: [
  //         for (int i = 0; i < primary.length; i++)
  //           Color.lerp(primary[i], other.primary[i], t)!,
  //       ],
  //     );
  //   }
  // }

