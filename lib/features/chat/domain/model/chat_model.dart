// ignore_for_file: constant_identifier_names, sort_constructors_first

import 'dart:convert';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

const tableChat = 'chat';

class ChatFields {
  static final List<String> values = [
    id,
    recieverId,
    senderId,
    message,
  ];

  static const String id = 'id';
  static const String recieverId = 'recieverId';
  static const String senderId = 'senderId';
  static const String message = 'message';
}

enum ChatModelsModelType {
  Text,
  Image,
  Audio,
  Video,
  Document,
}

class ChatModels {
  ChatModels({
    required this.type,
    required this.message,
    required this.senderId,
    required this.recieverId,
    this.id,
    this.read,
    this.createdAt,
    this.fileSize,
    this.fileName,
  });

  final int? id;
  final String senderId;
  final String recieverId;
  String message;
  final bool? read;
  final num? fileSize;
  final String? fileName;
  final ChatModelsModelType type;
  final DateTime? createdAt;

  factory ChatModels.fromMap(Map<String, dynamic> map) {
    return ChatModels(
      id: map['id'] as int,
      senderId: map['member_id'] as String,
      recieverId: map['member_id2'] as String,
      message: map['message'] as String,
      fileName: map['file_name'] as String,
      fileSize: num.tryParse(map['file_size'].toString()),
      read: map['status'] != null && map['status'] != 0,
      type: ChatModelsModelType.values.byName(map['message_type'] as String),
      createdAt:
          DateTime.tryParse(map['created_at'] as String) ?? DateTime.now(),
    );
  }

  factory ChatModels.fromJson(Map<String, dynamic> json) => ChatModels(
        id: json['id'] as int,
        senderId: json['senderId'] as String,
        recieverId: json['recieverId'] as String,
        message: json['message'] as String,
        fileName: '',
        fileSize: num.tryParse(json['file_size'].toString()),
        read: json['status'] != null && json['status'] != 0,
        type: ChatModelsModelType.Text,
        createdAt: DateTime.now(),
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'recieverId': recieverId,
      'message': message,
      // 'message_type': type.name,
      // 'file_size': fileSize,
      // 'file_name': fileName,
      // 'created_at': createdAt?.toIso8601String(),
    };
  }

  String toJson() => jsonEncode(toMap());

  int get previewLimit => 50;

  String get preview {
    switch (type) {
      case ChatModelsModelType.Text:
        var msg = message.replaceAll(RegExp(r'\s+'), ' ').trim();

        if (msg.length > previewLimit) {
          msg = '${msg.substring(0, previewLimit - 3)}...';
        }

        return msg;
      case ChatModelsModelType.Image:
      case ChatModelsModelType.Audio:
      case ChatModelsModelType.Video:
      case ChatModelsModelType.Document:
        var msg = '[${type.name}';

        if (fileName != null) {
          msg += ': $fileName';
        }

        return '$msg]';
    }
  }

  types.Message toMessage() {
    final author = types.User(
      id: senderId,
    );

    switch (type) {
      case ChatModelsModelType.Text:
        return types.TextMessage(
          text: message,
          author: author,
          id: id.toString(),
        );
      case ChatModelsModelType.Image:
        return types.ImageMessage(
          uri: message,
          author: author,
          id: id.toString(),
          size: fileSize ?? 0,
          name: fileName ?? type.name,
        );
      case ChatModelsModelType.Document:
        return types.FileMessage(
          uri: message,
          author: author,
          id: id.toString(),
          size: fileSize ?? 0,
          name: fileName ?? type.name,
        );
      case ChatModelsModelType.Audio:
      case ChatModelsModelType.Video:
        return types.CustomMessage(
          id: id.toString(),
          author: author,
          metadata: {
            'type': type,
            'url': message,
            'size': fileSize ?? 0,
            'name': fileName ?? type.name,
          },
        );
    }
  }
}
