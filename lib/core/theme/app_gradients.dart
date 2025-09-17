import 'package:flutter/material.dart';

@immutable
class AppGradients extends ThemeExtension<AppGradients> {
  const AppGradients({required this.primary, required this.nav});

  final List<Color> primary;
  final List<Color> nav;

  @override
  AppGradients copyWith({List<Color>? primary, List<Color>? nav}) {
    return AppGradients(primary: primary ?? this.primary, nav: nav ?? this.nav);
  }

  @override
  AppGradients lerp(ThemeExtension<AppGradients>? other, double t) {
    if (other is! AppGradients) return this;

    return AppGradients(
      primary: _lerpList(primary, other.primary, t),
      nav: _lerpList(nav, other.nav, t),
    );
  }

  List<Color> _lerpList(List<Color> a, List<Color> b, double t) {
    final length = a.length < b.length ? a.length : b.length;
    return List.generate(length, (i) => Color.lerp(a[i], b[i], t)!);
  }
}
