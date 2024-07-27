import 'package:comments/core/shared/widgets/loader.dart';
import 'package:comments/core/theme/colors.dart';
import 'package:comments/features/auth/presentation/provider/auth_provider.dart';
import 'package:comments/features/auth/presentation/widgets/auth_field.dart';
import 'package:comments/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:comments/features/auth/presentation/widgets/heading_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
          Consumer<AuthenticationProvider>(builder: (context, auth, child) {
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
                            buttonText: "Sign In",
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await Provider.of<AuthenticationProvider>(
                                        context,
                                        listen: false)
                                    .login(
                                  email: emailController.text.trim(),
                                  password: passController.text.trim(),
                                  context: context,
                                );
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Don\'t have an account? ',
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                              TextSpan(
                                  text: 'Sign Up',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: AppColors.gradient2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(context, "/signup");
                                    }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      })),
    );
  }
}
