import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget rightSideWidget(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(36),

    width: double.infinity,
    height: Get.height,
    color: Theme.of(context).colorScheme.background,
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1,
                  color: Theme.of(
                    context,
                  ).colorScheme.onPrimary.withOpacity(0.5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: Offset(5, 11),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,

                radius: 70,
                child: Icon(Icons.person, size: 60),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
