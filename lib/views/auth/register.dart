import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/route_names.dart';
import '../../widgets/auth_input.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();
  final AuthController controller = Get.put(AuthController());

  void submit() {
    if (_form.currentState!.validate()) {
      controller.register(nameController.text.trim(),
          emailController.text.trim(), passwordController.text);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    cpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  Center(
                    child: Image.asset(
                      'assets/images/app_tag.png',
                      width: 80,
                      height: 80,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Join Connectify today',
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                  const SizedBox(height: 32),
                  AuthInput(
                    label: 'Username',
                    hintText: 'Enter your username',
                    isPasswordField: false,
                    controller: nameController,
                    validatorCallback: ValidationBuilder()
                        .required()
                        .minLength(3)
                        .maxLength(50)
                        .build(),
                  ),
                  const SizedBox(height: 16),
                  AuthInput(
                    label: 'Email',
                    hintText: 'Enter your email',
                    isPasswordField: false,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validatorCallback:
                        ValidationBuilder().required().email().build(),
                  ),
                  const SizedBox(height: 16),
                  AuthInput(
                    label: 'Password',
                    hintText: 'Enter your password',
                    isPasswordField: true,
                    controller: passwordController,
                    validatorCallback: ValidationBuilder()
                        .required()
                        .minLength(6)
                        .maxLength(50)
                        .build(),
                  ),
                  const SizedBox(height: 16),
                  AuthInput(
                    label: 'Confirm Password',
                    hintText: 'Re-enter your password',
                    isPasswordField: true,
                    controller: cpasswordController,
                    validatorCallback: (val) {
                      if (val == null || val.isEmpty)
                        return 'This field is required';
                      if (passwordController.text != val)
                        return 'Passwords do not match';
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Obx(() => ElevatedButton(
                        onPressed:
                            controller.registerLoading.value ? null : submit,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          controller.registerLoading.value
                              ? 'Creating account...'
                              : 'Create Account',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )),
                  const SizedBox(height: 24),
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(color: Colors.grey.shade400),
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.toNamed(RouteNames.login),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
