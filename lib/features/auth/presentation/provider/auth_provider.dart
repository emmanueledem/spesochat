import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:spesochat/features/auth/auth.dart';
import 'package:spesochat/features/auth/data/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthService authService = AuthService();

  List<UsersModel> availableData = [];

  Future<bool> register(BuildContext contex, UsersModel user) async {
    final result = await authService.register(user);
    notifyListeners();
    return result;
  }

  Future<bool> login(BuildContext contex, UsersModel user) async {
    var result = false;
    availableData = await authService.login(user);
    Logger().d(availableData);
    if (availableData.isNotEmpty) {
      result = true;
      // save id for future use
    } else {
      result = false;
    }
    notifyListeners();
    return result;
  }
}
