import 'dart:convert';
import 'package:solo_bajos/config/locator.dart';
import 'package:solo_bajos/models/user.dart';
import 'package:injectable/injectable.dart';

import 'package:solo_bajos/rest/rest.dart';

@Order(-1)
@singleton
class UserRepository {
  late RestAuthenticatedClient _client;

  UserRepository() {
    _client = getIt<RestAuthenticatedClient>();
  }

  Future<dynamic> profile() async {
    String url = "/user/profile";

    var jsonResponse = await _client.get(url);
    return User.fromJson(jsonResponse);
  }
}
