import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:route_app/shared/remote/firebase_auth/auth_provider.dart';
import 'package:route_app/shared/reusable%20components/theme_icon.dart';

import '../../shared/providers/theme_provider.dart';
import '../../style/app_colors.dart';
import '../auth/login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProviders authProviders = Provider.of<AuthProviders>(context);
    ThemeMode themeMode = Provider.of<ThemeProvider>(context).themeMode;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    SvgPicture.asset(
                      themeMode == ThemeMode.light
                          ? 'assets/images/route.svg'
                          : 'assets/images/route_dark.svg',
                      width: 80,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          'Welcome to Route',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    fontSize: 16,
                                  ),
                        ),
                        Text(
                          'Enjoy our courses',
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: AppColors.labelSmallColor,
                                    fontSize: 16,
                                  ),
                        ),
                      ],
                    ),
                  ]),
                  Row(
                    children: [
                      const ThemeIcon(),
                      IconButton(
                        onPressed: () {
                          authProviders.signOut();
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        },
                        icon: const Icon(
                          Icons.exit_to_app,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
