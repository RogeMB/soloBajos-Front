/*
class User {
  final String id;
  final String username;
  final String fullName;
  final String email;
  final String accessToken;
  final String roles;
  final bool enabled;
  final String avatar;
  final String createdAt;

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.accessToken,
      required this.roles,
      required this.fullName,
      required this.avatar,
      required this.enabled,
      required this.createdAt});

  @override
  String toString() =>
      'User { name: $username, email: $email, fullName: $fullName, roles: $roles, enabled: $enabled}';


  user.fromLoginResponse(LoginResponse response) {
      this.id = response.id;
      this.username = response.username;
      this.avatar = response.avatar;
      this.fullName = response.fullName;
    }
}    
*/

class LoginResponse {
  String? id;
  String? username;
  String? fullName;
  String? email;
  String? avatar;
  bool? enabled;
  List<String>? roles;
  String? createdAt;
  String? token;

  LoginResponse(
      {this.id,
      this.username,
      this.fullName,
      this.email,
      this.avatar,
      this.enabled,
      this.roles,
      this.createdAt,
      this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
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

class LoginRequest {
  String? username;
  String? password;

  LoginRequest({this.username, this.password});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
