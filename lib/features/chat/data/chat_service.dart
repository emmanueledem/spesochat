import 'package:logger/logger.dart';
import 'package:spesochat/core/database_helper.dart';
import 'package:spesochat/features/chat/domain/model/chat_model.dart';
import 'package:sqflite/sqflite.dart';

class ChatService {
  late DatabaseHelper dbHelper;

  Future<bool> sendMessage(ChatModels chat) async {
    var result = false;
    dbHelper = DatabaseHelper();
    await dbHelper.initDB();
    final res = await dbHelper.db
        .insert(
      tableChat,
      chat.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    )
        .then((value) async {
      result = true;
    });
    Logger().d(res);
    return result;
  }

  Future<List<ChatModels>> getChat(ChatModels chat) async {
    dbHelper = DatabaseHelper();
    await dbHelper.initDB();
    final List<Map<String, dynamic>> queryResponse = await dbHelper.db.query(
      tableChat,
      where:
          'recieverId = ? and senderId = ? OR senderId  = ? and recieverId = ? ',
      whereArgs: [
        chat.recieverId,
        chat.senderId,
        chat.recieverId,
        chat.senderId,
      ],
      orderBy: 'id DESC',
    );
    return queryResponse.map(ChatModels.fromJson).toList();
  }
}
