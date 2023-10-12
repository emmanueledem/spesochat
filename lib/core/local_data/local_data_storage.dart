import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:spesochat/features/features.dart';

class TempStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  Future<void> clear() async {
    await storage.deleteAll();
  }

  Future<void> removeUser() {
    return storage.delete(key: userKey);
  }

  Future<UsersModel?> getUser() {
    return storage.read(key: userKey).then((value) {
      if (value == null) {
        return null;
      } else {
        return UsersModel.fromJson(json.decode(value) as Map<String, dynamic>);
      }
    });
  }

  Future<void> saveUser(UsersModel user) {
    return storage
        .write(key: userKey, value: jsonEncode(user.toJson()))
        .then((value) {});
  }
}

const String userKey = 'user';
