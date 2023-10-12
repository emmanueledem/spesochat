// ignore_for_file: cast_nullable_to_non_nullable

import 'package:flutter/material.dart';
import 'package:spesochat/core/core.dart';
import 'package:spesochat/features/features.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteName.splash:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const SplashView(),
      );

    case RouteName.home:
      final args = settings.arguments as HomeViewParams;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: HomeView(
          params: args,
        ),
      );

    case RouteName.registerView:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const RegisterView(),
      );

    case RouteName.loginView:
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const LoginView(),
      );

    case RouteName.createFriendView:
      final args = settings.arguments as CreateFriendViewParams;

      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: CreateFriendView(
          params: args,
        ),
      );

    case RouteName.chatScreenView:
      final args = settings.arguments as ChatScreenViewParams;
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: ChatScreenView(
          params: args,
        ),
      );

    default:
      return MaterialPageRoute<dynamic>(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

Route<dynamic> _getPageRoute({
  required String routeName,
  required Widget viewToShow,
}) {
  return MaterialPageRoute(
    settings: RouteSettings(
      name: routeName,
    ),
    builder: (_) => viewToShow,
  );
}
