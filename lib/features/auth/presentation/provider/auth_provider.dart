import 'package:comments/core/shared/usecase.dart';
import 'package:comments/core/utils/show_snackbar.dart';
import 'package:comments/features/auth/domain/entities/user.dart';
import 'package:comments/features/auth/domain/usecase/get_current_user.dart';
import 'package:comments/features/auth/domain/usecase/user_login.dart';
import 'package:comments/features/auth/domain/usecase/user_logout.dart';
import 'package:comments/features/auth/domain/usecase/user_signup.dart';
import 'package:comments/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthenticationProvider with ChangeNotifier {
  final UserLogin userLogin;
  final UserSignup userSignup;
  final UserLogout userLogout;
  final GetCurrentUser getcurruser;
  User? _user;
  User? get user => _user;
  bool isLoading = false;
  bool get isAuthenticated => _user != null;
  AuthenticationProvider(
      {required this.userLogin,
      required this.userLogout,
      required this.userSignup,
      required this.getcurruser});
  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
    final res = await userLogin(LoginParams(email: email, password: password));
    res.fold((l) {
      showSnackbar(context, l.message);
      _user = null;
    }, (user) {
      _user = user;
      Navigator.of(context).pushReplacementNamed("/comments");
    });
    isLoading = false;
    notifyListeners();
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();
    final res = await userSignup(
        SignupParams(email: email, password: password, name: name));
    res.fold((l) {
      showSnackbar(context, l.message);
      _user = null;
    }, (user) {
      _user = user;
      Navigator.of(context).pushReplacementNamed("/comments");
    });
    isLoading = false;
    notifyListeners();
  }

  Future<void> logout({required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
    final res = await userLogout(NoParams());
    res.fold((l) {
      showSnackbar(context, l.message);
    }, (_) {
      _user = null;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (Route<dynamic> route) => false);
    });
    isLoading = false;
    notifyListeners();
  }

  Future<void> getCurrentUser(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final res = await getcurruser(NoParams());
    res.fold((l) {
      showSnackbar(context, l.message);
    }, (u) {
      _user = u;
    });
    isLoading = false;
    notifyListeners();
  }
}
