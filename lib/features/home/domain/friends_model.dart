// ignore_for_file: sort_constructors_first

class FriendsModel {
  final int? id;
  final String? username;
  final String? emailAddress;
  final String? password;

  FriendsModel({
    this.id,
    this.username,
    this.emailAddress,
    this.password,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'emailAddress': emailAddress,
        'password': password,
      };

  factory FriendsModel.fromJson(Map<String, dynamic> json) {
    return FriendsModel(
      id: json['id'] as int,
      username: json['username'] as String,
      emailAddress: json['emailAddress'] as String,
      password: json['password'] as String,
    );
  }

  @override
  String toString() {
    return 'FriendsModel{id: $id, username: $username, emailAddress: $emailAddress, password: $password}';
  }
}
