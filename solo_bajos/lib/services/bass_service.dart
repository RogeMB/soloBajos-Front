import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:solo_bajos/config/locator.dart';
import 'package:solo_bajos/models/bass.dart';
import 'package:solo_bajos/repositories/bass_repo.dart';
import 'package:get_it/get_it.dart';

import 'localstorage_service.dart';

abstract class BassServiceAbstract {
  Future<BassResponse?> getAllBasses([int page = 0]);
}

@Order(2)
//@Singleton(as: AuthenticationService)
@singleton
class BassService extends BassServiceAbstract {
  late LocalStorageService _localStorageService;
  late BassRepository _bassRepository;

  BassService() {
    _bassRepository = getIt<BassRepository>();
    GetIt.I
        .getAsync<LocalStorageService>()
        .then((value) => _localStorageService = value);
  }

  @override
  Future<BassResponse> getAllBasses([int page = 0]) async {
    //String? loggedUser = _localStorageService.getFromDisk("user");
    //print("get bass list from $page");
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      dynamic response = await _bassRepository.findAllBasses(page);
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Error();
      }
    } else {
      throw Error();
    }
  }
}
