import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/auth_input.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

  void submit() {
    if (_form.currentState!.validate()) {
      authController.forgotPassword(emailController.text.trim());
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Get.back(),
        ),
        title: const Text('Forgot Password'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.lock_reset, size: 64, color: Colors.white70),
                  const SizedBox(height: 24),
                  const Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enter your email and we\'ll send you a link to reset your password.',
                    style: TextStyle(color: Colors.grey.shade400, height: 1.5),
                  ),
                  const SizedBox(height: 32),
                  AuthInput(
                    label: 'Email',
                    hintText: 'Enter your email',
                    isPasswordField: false,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validatorCallback:
                        ValidationBuilder().required().email().build(),
                  ),
                  const SizedBox(height: 24),
                  Obx(() => ElevatedButton(
                        onPressed:
                            authController.forgotLoading.value ? null : submit,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          authController.forgotLoading.value
                              ? 'Sending...'
                              : 'Send Reset Link',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
