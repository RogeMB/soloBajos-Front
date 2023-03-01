import 'package:solo_bajos/models/login.dart';
import 'package:solo_bajos/models/register.dart';

class User {
  String? id;
  String? username;
  String? fullName;
  String? email;
  String? avatar;
  bool? enabled;
  List<String>? roles;
  String? createdAt;
  String? token;

  User(
      {this.id,
      this.username,
      this.fullName,
      this.email,
      this.avatar,
      this.enabled,
      this.roles,
      this.createdAt,
      this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullName = json['fullName'];
    email = json['email'];
    avatar = json['avatar'];
    enabled = json['enabled'];
    roles = json['roles'].cast<String>();
    createdAt = json['createdAt'];
    token = json['token'];
  }

  User.fromLoginResponse(LoginResponse response) {
    id = response.id;
    username = response.username;
    fullName = response.fullName;
    email = response.email;
    avatar = response.avatar;
    enabled = response.enabled;
    roles = response.roles;
    createdAt = response.createdAt;
    token = response.token;
  }

  User.fromRegisterResponse(RegisterResponse response) {
    id = response.id;
    username = response.username;
    fullName = fullName;
    email = response.email;
    avatar = response.avatar;
    enabled = response.enabled;
    roles = response.roles;
    createdAt = response.createdAt;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['fullName'] = fullName;
    data['email'] = email;
    data['avatar'] = avatar;
    data['enabled'] = enabled;
    data['roles'] = roles;
    data['createdAt'] = createdAt;
    data['token'] = token;
    return data;
  }
}

class UserResponse extends User {
  UserResponse(
      id, username, fullName, avatar, email, enabled, createdAt, token, roles)
      : super(
            id: id,
            username: username,
            fullName: fullName,
            avatar: avatar,
            email: email,
            enabled: enabled,
            createdAt: createdAt,
            token: token,
            roles: roles);

  UserResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    avatar = json['avatar'];
    fullName = json['fullName'];
    email = json['email'];
    enabled = json['enabled'];
    createdAt = json['createdAt'];
    token = json['token'];
    roles = json['roles'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['avatar'] = avatar;
    data['fullName'] = fullName;
    data['email'] = email;
    data['enabled'] = enabled;
    data['createdAt'] = createdAt;
    data['token'] = token;
    data['roles'] = roles;
    return data;
  }
}
