import 'package:comments/core/shared/widgets/loader.dart';
import 'package:comments/core/theme/colors.dart';
import 'package:comments/features/auth/presentation/provider/auth_provider.dart';
import 'package:comments/features/auth/presentation/widgets/auth_field.dart';
import 'package:comments/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:comments/features/auth/presentation/widgets/heading_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Consumer<AuthenticationProvider>(
        builder: (context, auth, child) {
          return auth.isLoading
              ? const Loader()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HeadingText(),
                          const SizedBox(
                            height: 30,
                          ),
                          AuthField(
                              hintText: "Name", controller: nameController),
                          const SizedBox(
                            height: 30,
                          ),
                          AuthField(
                              hintText: "Email", controller: emailController),
                          const SizedBox(
                            height: 30,
                          ),
                          AuthField(
                            hintText: "Password",
                            controller: passController,
                            isObscureText: true,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AuthGradientButton(
                              buttonText: "Sign Up",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Provider.of<AuthenticationProvider>(context,
                                          listen: false)
                                      .signup(
                                          name: nameController.text.trim(),
                                          email: emailController.text.trim(),
                                          password: passController.text.trim(),
                                          context: context);
                                }
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Already have an account? ',
                              style: Theme.of(context).textTheme.titleMedium,
                              children: [
                                TextSpan(
                                    text: 'Sign In',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: AppColors.gradient2,
                                          fontWeight: FontWeight.bold,
                                        ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacementNamed(
                                            context, "/login");
                                      }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
      )),
    );
  }
}
