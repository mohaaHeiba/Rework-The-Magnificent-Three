import 'package:flutter/material.dart';
import 'package:the_magnificent_three/presentation/widgets/auth/left_side.dart';
import 'package:the_magnificent_three/presentation/widgets/auth/right_side.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(flex: 10, child: leftSideWidget(context)),
          Expanded(flex: 6, child: rightSideWidget(context)),
        ],
      ),
    );
  }
}
