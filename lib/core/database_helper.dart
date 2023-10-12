// ignore_for_file: sort_constructors_first, sort_unnamed_constructors_first

import 'dart:async';
import 'package:path/path.dart';
import 'package:spesochat/features/features.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._();

  DatabaseHelper._();

  late Database db;

  Future<void> initDB() async {
    final path = await getDatabasesPath();

    db = await openDatabase(
      join(path, 'userDB.db'),
      version: 1,
      onCreate: (Database db, version) async {
        const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT ';
        const textType = 'TEXT NOT NULL';
        await db.execute('''
           CREATE TABLE $tableUser (
       ${RegistrationFields.id} $idType,
       ${RegistrationFields.username} $textType,
       ${RegistrationFields.emailAddress} $textType,
       ${RegistrationFields.password} $textType)
          ''');
        await db.execute('''
           CREATE TABLE $tableChat (
       ${ChatFields.id} $idType,
       ${ChatFields.recieverId} $textType,
       ${ChatFields.senderId} $textType,
       ${ChatFields.message} $textType)
          ''');
      },
    );
  }

  factory DatabaseHelper() {
    return _databaseHelper;
  }
}
