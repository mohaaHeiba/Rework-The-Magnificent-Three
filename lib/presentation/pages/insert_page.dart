import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:the_magnificent_three/presentation/controllers/insert_data.dart';
import 'package:the_magnificent_three/presentation/widgets/welcome/build_dropdown_field.dart';

class InertPage extends StatelessWidget {
  const InertPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InsertDataController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // Left Side - Visual/Image Section
          Expanded(
            flex: 5,
            child: Container(
              height: MediaQuery.of(context).size.height,

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF2E7D9A),
                    const Color(0xFF1E5A73),
                    const Color(0xFF0D3D56),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Background Pattern
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.1,
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Content
                  SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(48.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // App Logo/Icon
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.psychology_rounded,
                                size: 80,
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(height: 32),

                            // Title
                            const Text(
                              "Brain Tumor Analysis",
                              style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: 16),

                            // Subtitle
                            Text(
                              "Advanced AI-powered medical imaging analysis for healthcare professionals",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white.withOpacity(0.9),
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: 48),

                            // Features List
                            Column(
                              children: [
                                buildFeatureItem("🧠", "AI-Powered Analysis"),
                                const SizedBox(height: 16),
                                buildFeatureItem("📊", "Detailed Reports"),
                                const SizedBox(height: 16),
                                buildFeatureItem("⚡", "Fast Processing"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Right Side - Form Section
          Expanded(
            flex: 4,
            child: Container(
              color: const Color(0xFFF8F9FA),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  top: 48.0,
                  right: 48.0,
                  left: 48.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Form
                    Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          // Profile Picture
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(
                                        0xFF2E7D9A,
                                      ).withOpacity(0.3),
                                      width: 3,
                                    ),
                                  ),
                                  child: Obx(
                                    () => CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.grey[200],
                                      backgroundImage:
                                          controller.profileImageProvider.value,
                                      child:
                                          controller
                                                  .profileImageProvider
                                                  .value ==
                                              null
                                          ? Icon(
                                              Icons.person,
                                              size: 50,
                                              color: Colors.grey[400],
                                            )
                                          : null,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: controller.pickProfileImage,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF2E7D9A),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt_rounded,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 40),

                          // Full Name
                          buildTextFormField(
                            controller: controller.fullNameController,
                            label: "Full Name",
                            hint: "Dr. Ahmed Farouk",
                            icon: Icons.person_rounded,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Full name is required';
                              }
                              return null;
                            },
                            context: context,
                          ),

                          const SizedBox(height: 10),

                          // Email
                          buildTextFormField(
                            controller: controller.emailController,
                            label: "Email ",
                            hint: "doctor@hospital.com",
                            icon: Icons.email_rounded,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Email is required';
                              }
                              if (!RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              ).hasMatch(value!)) {
                                return 'Enter valid email';
                              }
                              return null;
                            },
                            context: context,
                          ),

                          const SizedBox(height: 10),

                          // Phone
                          buildTextFormField(
                            controller: controller.phoneController,
                            label: "Phone Number",
                            hint: "+1 (555) 123-4567",
                            icon: Icons.phone_rounded,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Phone number is required';
                              }
                              return null;
                            },
                            context: context,
                          ),

                          const SizedBox(height: 10),

                          // Role
                          Obx(
                            () => buildDropdownField(
                              label: "Professional Role",
                              value: controller.selectedRole.value,
                              items: controller.userRoles,
                              onChanged: (value) =>
                                  (() =>
                                      controller.selectedRole.value = value!),
                              icon: Icons.work_rounded,
                            ),
                          ),

                          const SizedBox(height: 40),

                          // Submit Button
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton.icon(
                              onPressed: controller.isSubmitting.value
                                  ? null
                                  : controller.submitUserData,
                              icon: controller.isSubmitting.value
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                      ),
                                    )
                                  : const Icon(
                                      Icons.person_add_rounded,
                                      size: 24,
                                    ),
                              label: Text(
                                controller.isSubmitting.value
                                    ? "Creating Account..."
                                    : "Create Account",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2E7D9A),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
