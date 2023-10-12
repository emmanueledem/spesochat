import 'package:logger/logger.dart';
import 'package:spesochat/core/database_helper.dart';
import 'package:spesochat/features/auth/auth.dart';
import 'package:sqflite/sqflite.dart';

class AuthService {
  late DatabaseHelper dbHelper;

  Future<bool> register(UsersModel user) async {
    var result = false;
    dbHelper = DatabaseHelper();
    await dbHelper.initDB();
    await dbHelper.db
        .insert(
      tableUser,
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    )
        .then((value) async {
      result = true;
    });
    return result;
  }

  Future<List<UsersModel>> login(UsersModel user) async {
    dbHelper = DatabaseHelper();
    await dbHelper.initDB();
    final List<Map<String, dynamic>> queryResponse = await dbHelper.db.query(
      tableUser,
      where: 'emailAddress = ? and password = ?',
      limit: 1,
      whereArgs: [user.emailAddress, user.password],
    );

    Logger().d(queryResponse);
    return queryResponse.map(UsersModel.fromJson).toList();
  }
}
