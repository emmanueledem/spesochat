import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spesochat/core/constants/app_assets.dart';
import 'package:spesochat/core/constants/navigators/navigators.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController logoContoller;

  void _handleStartup() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, RouteName.home);
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
