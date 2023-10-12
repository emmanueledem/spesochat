import 'package:flutter/material.dart';
import 'package:spesochat/features/home/home.dart';

class HomeProvider extends ChangeNotifier {
  final HomeService _homeService = HomeService();

  List<FriendsModel> availableData = [];
  bool isLoading = false;

  Future<bool> getFriends(FriendsModel user) async {
    isLoading = true;
    notifyListeners();
    availableData = await _homeService.getFriends(user);
    isLoading = false;
    notifyListeners();
    return isLoading;
  }

  Future<bool> deleteFriends(int friendId, int currentUserId) async {
    var result = false;
    notifyListeners();
    result = await _homeService.deleteFriend(friendId);
    await getFriends(FriendsModel(id: currentUserId));

    notifyListeners();
    return result;
  }
}
