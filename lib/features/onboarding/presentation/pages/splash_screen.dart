import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spesochat/core/constants/app_assets.dart';
import 'package:spesochat/core/core.dart';
import 'package:spesochat/features/features.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController logoContoller;
  final TempStorage tempStorage = TempStorage();

  void _handleStartup() {
    Future.delayed(const Duration(seconds: 2), () async {
      await tempStorage.getUser().then((value) {
        if (value == null) {
          Navigator.pushNamed(context, RouteName.registerView);
        } else {
          Navigator.pushNamed(
            context,
            RouteName.home,
            arguments: HomeViewParams(
              id: value.id!,
              username: value.username.toString(),
            ),
          );
        }
      });
    });
  }

  Future<void> _animate() async {
    logoContoller = AnimationController(
      duration: const Duration(seconds: 1),
      upperBound: 100,
      vsync: this,
    );

    unawaited(logoContoller.forward());

    logoContoller.addListener(() {
      setState(() {});
      // ignore: avoid_print
    });
  }

  @override
  void initState() {
    _animate();
    _handleStartup();
    super.initState();
  }

  @override
  void dispose() {
    logoContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            AppAssets.appLogo,
            width: logoContoller.value,
            height: logoContoller.value,
          ),
        ),
      ),
    );
  }
}
