import 'package:comments/core/theme/colors.dart';
import 'package:comments/features/auth/presentation/provider/auth_provider.dart';
import 'package:comments/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Consumer<AuthenticationProvider>(
                    builder: (context, auth, child) {
                  final name = auth.user?.name;
                  return ListTile(
                    title: Text(
                      name ?? "",
                      style: const TextStyle(color: AppColors.gradient1),
                    ),
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: const Text("All Comments"),
                  trailing: const Icon(Icons.comment),
                  onTap: () {
                    Navigator.of(context).pushNamed("/comments");
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                AuthGradientButton(
                    buttonText: "Logout",
                    onPressed: () {
                      Provider.of<AuthenticationProvider>(
                        context,
                        listen: false,
                      ).logout(context: context);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
