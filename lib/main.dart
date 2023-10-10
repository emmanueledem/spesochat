import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spesochat/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const App());
  });
}
