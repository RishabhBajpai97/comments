import 'package:comments/core/theme/theme.dart';
import 'package:comments/features/auth/presentation/pages/login_page.dart';
import 'package:comments/features/auth/presentation/pages/signup_page.dart';
import 'package:comments/features/auth/presentation/provider/auth_provider.dart';
import 'package:comments/features/comments/presentation/pages/comments.dart';
import 'package:comments/features/comments/presentation/provider/comments_provider.dart';
import 'package:comments/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDependencies();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => serviceLocator<AuthenticationProvider>(),
        ),
        ChangeNotifierProvider(
            create: (_) => serviceLocator<CommentsProvider>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Future.microtask(() {
      Provider.of<AuthenticationProvider>(context, listen: false)
          .getCurrentUser(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeMode,
      home: Consumer<AuthenticationProvider>(builder: (context, auth, child) {
        return auth.user != null ? const CommentsPage() : const LoginPage();
      }),
      routes: {
        "/signup": (context) => const SignupPage(),
        "/login": (context) => const LoginPage(),
        "/comments": (context) => const CommentsPage(),
      },
    );
  }
}
