import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spesochat/core/constants/colors.dart';
import 'package:spesochat/core/constants/constants.dart';
import 'package:spesochat/features/auth/presentation/provider/auth_provider.dart';
import 'package:spesochat/features/chat/presentation/provider/chat_provider.dart';
import 'package:spesochat/features/home/presentation/provider/home_provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => ChatProvider()),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
