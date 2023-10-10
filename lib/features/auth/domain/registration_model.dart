// ignore_for_file: sort_constructors_first

const tableUser = 'user';

class RegistrationFields {
  static final List<String> values = [
    id,
    username,
    emailAddress,
    password,
  ];

  static const String id = 'id';
  static const String username = 'username';
  static const String emailAddress = 'emailAddress';
  static const String password = 'password';
}

class UsersModel {
  final int? id;
  final String? username;
  final String? emailAddress;
  final String? password;

  UsersModel({
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

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      id: json['id'] as int,
      username: json['username'] as String,
      emailAddress: json['emailAddress'] as String,
      password: json['password'] as String,
    );
  }

  @override
  String toString() {
    return 'UsersModel{id: $id, username: $username, emailAddress: $emailAddress, password: $password}';
  }
}
