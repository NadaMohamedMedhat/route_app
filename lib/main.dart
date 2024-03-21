import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_app/layout/auth/login/login_screen.dart';
import 'package:route_app/layout/auth/register/register_screen.dart';
import 'package:route_app/layout/home/home_screen.dart';
import 'package:route_app/layout/splash/splash_screen.dart';
import 'package:route_app/shared/prefs_helper.dart';
import 'package:route_app/shared/providers/theme_provider.dart';
import 'package:route_app/style/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'shared/remote/firebase_auth/auth_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PrefsHelper.preferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProviders()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()..loadTheme()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        SplashScreen.routeName: (context) => const SplashScreen(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
    );
  }
}
