import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_magnificent_three/core/constants/app_constraints.dart';
import 'package:the_magnificent_three/presentation/controllers/auth/auth_controll.dart';
import 'package:the_magnificent_three/presentation/pages/home/home_page.dart';
import 'package:the_magnificent_three/presentation/widgets/auth/right_side_widget/dropdownmenu_widget.dart';
import 'package:the_magnificent_three/presentation/widgets/auth/right_side_widget/fileds_forms.dart';

Widget rightSideWidget(BuildContext context) {
  final theme = Theme.of(context);
  final controller = Get.find<AuthController>();
  return Container(
    color: theme.colorScheme.primaryContainer,
    height: Get.height,
    width: double.infinity,
    child: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.secondary,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      offset: const Offset(0, 6),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: theme.colorScheme.surface,
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              AppSpacing.h16,
              fieldsTextForm(
                'Full Name',
                'Enter your full name',
                Icons.person,
                false,
                context,
                controller.contName,
              ),
              AppSpacing.h8,

              fieldsTextForm(
                'Email',
                'Enter your email',
                Icons.email,
                false,
                context,
                controller.contEmail,
              ),
              AppSpacing.h8,

              fieldsTextForm(
                'Password',
                'Enter your password',
                Icons.lock,
                true,
                context,
                controller.contPass,
              ),
              AppSpacing.h8,

              dropDownmenuWidget(
                title: 'Professional Role',
                hint: 'Choose your role',
                theme: theme,
                roles: controller.entries,
                controll: controller.contEntry,
              ),
              AppSpacing.h32,

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: theme.colorScheme.primary,
                  ),

                  onPressed: () async {
                    final user = await controller.inserUser();
                    Get.to(() => const HomePage(), arguments: user);
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
