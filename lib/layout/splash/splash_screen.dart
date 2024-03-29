import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../shared/providers/theme_provider.dart';
import '../../shared/remote/firebase_auth/auth_provider.dart';
import '../auth/login/login_screen.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'SplashScreen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = Provider.of<ThemeProvider>(context).themeMode;
    Future.delayed(const Duration(seconds: 2), () {
      checkAutoLogin();
    });
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          themeMode == ThemeMode.light
              ? 'assets/images/route.svg'
              : 'assets/images/route_dark.svg',
        ),
      ),
    );
  }

  checkAutoLogin() async {
    AuthProviders authProviders =
        Provider.of<AuthProviders>(context, listen: false);
    if (authProviders.isFirebaseUserLoggedIn()) {
      await authProviders.retrieveDatabaseUserData();
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }
}
