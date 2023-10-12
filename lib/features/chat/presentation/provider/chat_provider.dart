import 'package:flutter/material.dart';
import 'package:spesochat/features/chat/data/chat_service.dart';
import 'package:spesochat/features/chat/domain/model/chat_model.dart';

class ChatProvider extends ChangeNotifier {
  List<ChatModels> _messages = [];

  List<ChatModels> get messages => _messages;
  final ChatService _chatService = ChatService();

  Future<void> sendMessage(BuildContext contex, ChatModels chat) async {
    await _chatService.sendMessage(chat).then((value) async {
      await getMessage(contex, chat);
    });
    notifyListeners();
  }

  Future<void> getMessage(BuildContext contex, ChatModels chat) async {
    _messages = await _chatService.getChat(chat);
    notifyListeners();
  }
}
