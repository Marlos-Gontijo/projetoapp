import 'package:completeecommerce/screens/forgot_password/forgot_password_screen.dart';
import 'package:completeecommerce/screens/login_success/login_success_screen.dart';
import 'package:completeecommerce/screens/sign_in/sign_in_screen.dart';
import 'package:completeecommerce/screens/sign_up/sign_up_screen.dart';
import 'package:completeecommerce/screens/splash/splash_screen.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
};