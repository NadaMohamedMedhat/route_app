import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:route_app/layout/auth/login/login_screen.dart';
import 'package:route_app/layout/auth/register/register_screen.dart';
import 'package:route_app/layout/home/home_screen.dart';
import 'package:route_app/style/app_theme.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     initialRoute: LoginScreen.routeName,
     routes: {
       LoginScreen.routeName : (context) => LoginScreen(),
       RegisterScreen.routeName : (context) => RegisterScreen(),
       HomeScreen.routeName : (context) => const HomeScreen(),
     },
     theme: AppTheme.lightTheme,
     //darkTheme: AppTheme.darkTheme,
   );
  }
}


