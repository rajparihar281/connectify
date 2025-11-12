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
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController nameController = TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");
  final TextEditingController cpasswordController =
      TextEditingController(text: "");
  final AuthController controller = Get.put(AuthController());

  void submit() {
    if (_form.currentState!.validate()) {
      controller.register(
          nameController.text, emailController.text, passwordController.text);
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
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _form,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/authLogo.png",
                  width: 60,
                  height: 60,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text("Welcome to Twinote")
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                AuthInput(
                    label: "Username",
                    hintText: "Enter your username",
                    isPasswordField: false,
                    controller: nameController,
                    validatorCallback: ValidationBuilder()
                        .required()
                        .minLength(3)
                        .maxLength(50)
                        .build()),
                const SizedBox(
                  height: 20,
                ),
                AuthInput(
                    label: " Email",
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
                    validatorCallback: ValidationBuilder()
                        .required()
                        .minLength(6)
                        .maxLength(50)
                        .build()),
                const SizedBox(
                  height: 20,
                ),
                AuthInput(
                  label: "Confirm Password",
                  hintText: "Enter your confirm password",
                  isPasswordField: true,
                  controller: cpasswordController,
                  validatorCallback: (arg) {
                    if (passwordController.text != arg) {
                      return "Both password do not match !";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => ElevatedButton(
                    onPressed: submit,
                    style: ButtonStyle(
                      minimumSize:
                          WidgetStateProperty.all(const Size.fromHeight(40)),
                    ),
                    child: Text(controller.registerLoading.value
                        ? "Processing..."
                        : "Register"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                        text: " Login ",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.toNamed(RouteNames.login)),
                  ], text: "Already have an account ?"),
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
