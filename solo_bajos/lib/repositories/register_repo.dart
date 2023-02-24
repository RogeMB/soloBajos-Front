import 'package:injectable/injectable.dart';
import 'package:solo_bajos/models/register.dart';
import 'package:get_it/get_it.dart';
import '../rest/rest_client.dart';

// ignore: non_constant_identifier_names

@Order(-1)
@singleton
class RegisterRepository {
  late RestClient _client;

  RegisterRepository() {
    _client = GetIt.I.get<RestClient>();
  }
  String url = "/admin/auth/login";

  Future<dynamic> doRegister(String fullName, String username, String email,
      String verifyEmail, String password, String verifyPassword) async {
    var jsonResponse = await _client.post(
        url,
        (RegisterRequest(
          fullName: fullName,
          username: username,
          email: email,
          verifyEmail: verifyEmail,
          password: password,
          verifyPassword: verifyPassword,
        )));
    return RegisterRequest.fromJson(jsonResponse);
  }
}
