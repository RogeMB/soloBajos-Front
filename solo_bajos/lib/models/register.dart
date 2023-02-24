class RegisterRequest {
  String? fullName;
  String? username;
  String? email;
  String? verifyEmail;
  String? password;
  String? verifyPassword;

  RegisterRequest(
      {this.fullName,
      this.username,
      this.email,
      this.verifyEmail,
      this.password,
      this.verifyPassword});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    username = json['username'];
    email = json['email'];
    verifyEmail = json['verifyEmail'];
    password = json['password'];
    verifyPassword = json['verifyPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['username'] = username;
    data['email'] = email;
    data['verifyEmail'] = verifyEmail;
    data['password'] = password;
    data['verifyPassword'] = verifyPassword;
    return data;
  }
}

class RegisterResponse {
  String? id;
  String? username;
  String? fullName;
  String? email;
  String? avatar;
  bool? enabled;
  List<String>? roles;
  String? createdAt;

  RegisterResponse(
      {this.id,
      this.username,
      this.fullName,
      this.email,
      this.avatar,
      this.enabled,
      this.roles,
      this.createdAt});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullName = json['fullName'];
    email = json['email'];
    avatar = json['avatar'];
    enabled = json['enabled'];
    roles = json['roles'].cast<String>();
    createdAt = json['createdAt'];
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
    return data;
  }
}
