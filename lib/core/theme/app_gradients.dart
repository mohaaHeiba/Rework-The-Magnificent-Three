import 'package:flutter/material.dart';

@immutable
class AppGradients extends ThemeExtension<AppGradients> {
  const AppGradients({required this.primary});

  final List<Color> primary;

  @override
  AppGradients copyWith({List<Color>? primary}) {
    return AppGradients(primary: primary ?? this.primary);
  }

  @override
  AppGradients lerp(ThemeExtension<AppGradients>? other, double t) {
    if (other is! AppGradients) {
      return this;
    }
    return AppGradients(
      primary: [
        for (int i = 0; i < primary.length; i++)
          Color.lerp(primary[i], other.primary[i], t)!,
      ],
    );
  }
}
