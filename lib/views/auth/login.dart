import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/route_names.dart';
import '../../widgets/auth_input.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");
  final AuthController authController = Get.put(AuthController());
  // * Submit method * //
  void submit() {
    if (_form.currentState!.validate()) {
      authController.login(emailController.text, passwordController.text);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _form,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  "assets/images/authLogo.png",
                  width: 90,
                  height: 150,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text("Welcome Back")
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                AuthInput(
                    label: "Email",
                    hintText: "Enter your email",
                    isPasswordField: false,
                    controller: emailController,
                    validatorCallback:
                        ValidationBuilder().required().email().build()),
                const SizedBox(
                  height: 20,
                ),
                AuthInput(
                    label: "Password",
                    hintText: "Enter your password",
                    isPasswordField: true,
                    controller: passwordController,
                    validatorCallback: ValidationBuilder().required().build()),
                const SizedBox(
                  height: 20,
                ),
                Obx(() => ElevatedButton(
                      onPressed: submit,
                      style: ButtonStyle(
                        minimumSize:
                            WidgetStateProperty.all(const Size.fromHeight(40)),
                      ),
                      child: Text(authController.loginLoading.value
                          ? "Processing..."
                          : "Login"),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                        text: " Sign Up",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.toNamed(RouteNames.register)),
                  ], text: "Don't have an account ?"),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
