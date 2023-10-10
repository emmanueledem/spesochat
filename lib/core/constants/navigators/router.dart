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
      return _getPageRoute(
        routeName: settings.name!,
        viewToShow: const HomeView(),
      );

    // case RouteName.createAccountSuccessView:
    //   return _getPageRoute(
    //     routeName: settings.name!,
    //     viewToShow: const CreateAccountSuccessView(),
    //   );

    // case RouteName.faceIdActivationView:
    //   final args = settings.arguments as FaceIdActivationViewParams;
    //   return _getPageRoute(
    //     routeName: settings.name!,
    //     viewToShow: FaceIdActivationView(
    //       params: args,
    //     ),
    //   );

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
