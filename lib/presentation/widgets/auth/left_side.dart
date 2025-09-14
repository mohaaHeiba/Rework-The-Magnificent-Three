import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_magnificent_three/core/constants/app_constraints.dart';
import 'package:the_magnificent_three/core/theme/app_gradients.dart';

Widget leftSideWidget(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,

        end: Alignment.bottomCenter,
        colors:
            Theme.of(context).extension<AppGradients>()?.primary ??
            [Colors.amber],
      ),
    ),
    child: SingleChildScrollView(
      child: SizedBox(
        height: Get.height,

        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.1,
                child: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(48.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(
                          context,
                        ).colorScheme.onPrimary.withOpacity(0.2),

                        border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      child: Icon(
                        Icons.psychology_rounded,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 80,
                      ),
                    ),
                    AppSpacing.h32,
                    Text(
                      "Brain Tumor Analysis",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
