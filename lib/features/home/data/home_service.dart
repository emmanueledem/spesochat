import 'package:spesochat/core/database_helper.dart';
import 'package:spesochat/features/features.dart';

class HomeService {
  late DatabaseHelper dbHelper;

  Future<List<FriendsModel>> getFriends(FriendsModel user) async {
    dbHelper = DatabaseHelper();
    await dbHelper.initDB();
    final List<Map<String, dynamic>> queryResponse = await dbHelper.db.query(
      tableUser,
      where: 'id != ?',
      whereArgs: [
        user.id,
      ],
      orderBy: 'id DESC',
    );
    return queryResponse.map(FriendsModel.fromJson).toList();
  }

  Future<bool> deleteFriend(int userId) async {
    var result = false;
    dbHelper = DatabaseHelper();
    await dbHelper.initDB();
    await dbHelper.db.delete(
      tableUser,
      where: 'id = ?',
      whereArgs: [
        userId,
      ],
    ).then((value) => result = true);
    return result;
  }
}
