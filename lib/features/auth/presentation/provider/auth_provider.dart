import 'package:flutter/material.dart';
import 'package:spesochat/core/core.dart';
import 'package:spesochat/features/auth/auth.dart';
import 'package:spesochat/features/auth/data/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final TempStorage _tempStorage = TempStorage();

  List<UsersModel> availableData = [];

  Future<bool> register(BuildContext contex, UsersModel user) async {
    final result = await _authService.register(user);
    notifyListeners();
    return result;
  }

  Future<bool> login(BuildContext contex, UsersModel user) async {
    var result = false;
    availableData = await _authService.login(user);
    if (availableData.isNotEmpty) {
      result = true;
      final tempStorage = TempStorage();
      await tempStorage.saveUser(availableData[0]);
    } else {
      result = false;
    }
    notifyListeners();
    return result;
  }

  Future<void> logout(
    BuildContext context,
  ) async {
    await _tempStorage.removeUser().then((value) {
      Navigator.pushNamed(context, RouteName.loginView);
    });
    notifyListeners();
  }
}
