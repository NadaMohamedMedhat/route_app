import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class ThemeIcon extends StatelessWidget {
  const ThemeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return   IconButton(
      onPressed: () {
        themeProvider.changeTheme(
          themeProvider.themeMode == ThemeMode.light
              ? ThemeMode.dark
              : ThemeMode.light,
        );
      },
      icon: Icon(
        themeProvider.themeMode == ThemeMode.dark
            ? Icons.light_mode
            : Icons.dark_mode,
      ),
    );
  }
}
