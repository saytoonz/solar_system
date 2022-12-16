import 'package:flutter/material.dart';
import 'package:solar_system/pages/main_page.dart';
import 'package:solar_system/utils/app_colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solar System',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.white,
      ),
      home: const MainPage(),
    );
  }
}
