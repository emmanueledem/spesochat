import 'package:flutter/material.dart';
import 'package:spesochat/core/constants/colors.dart';
import 'package:spesochat/core/constants/constants.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoute,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.white,
        appBarTheme: const AppBarTheme(
          color: AppColors.primaryColor,
        ),
        primaryColor: AppColors.primaryColor,
        colorScheme: ColorScheme.fromSwatch(
          accentColor: AppColors.primaryColor,
        ),
        useMaterial3: true,
      ),
      initialRoute: RouteName.splash,
    );
  }
}
