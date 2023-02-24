import 'dart:convert';
//import 'dart:developer';

import 'package:solo_bajos/config/locator.dart';
import 'package:solo_bajos/models/register.dart';
import 'package:solo_bajos/services/localstorage_service.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

//import '../exceptions/exceptions.dart';
import 'package:solo_bajos/models/models.dart';
import 'package:solo_bajos/repositories/repositories.dart';

abstract class RegisterService {
  Future<User> registerNewUser(String fullName, String username, String email,
      String verifyEmail, String password, String verifyPassword);
}

@Order(2)
//@Singleton(as: AuthenticationService)
@singleton
class JwtRegisterService extends RegisterService {
  late RegisterRepository _registerRepo;
  late LocalStorageService _localStorageService;

  JwtRegisterService() {
    _registerRepo = getIt<RegisterRepository>();
    GetIt.I
        .getAsync<LocalStorageService>()
        .then((value) => _localStorageService = value);
  }

  @override
  Future<User> registerNewUser(String fullName, String username, String email,
      String verifyEmail, String password, String verifyPassword) async {
    RegisterResponse response = await _registerRepo.doRegister(
        fullName, username, email, verifyEmail, password, verifyPassword);
    await _localStorageService.saveToDisk(
        'user', jsonEncode(response.toJson()));
    return User.fromRegisterResponse(response);
  }
}
