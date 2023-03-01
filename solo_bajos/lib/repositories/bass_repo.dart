import 'package:solo_bajos/models/bass.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../config/locator.dart';
import '../rest/rest_client.dart';

const _bassLimit = 10;

@Order(-1)
@singleton
class BassRepository {
  late RestAuthenticatedClient _client;

  BassRepository() {
    _client = getIt<RestAuthenticatedClient>();
  }

  Future<BassResponse> findAllBasses([int page = 0]) async {
    String url = "/bass/?page=$page";
    var response = await _client.get(url);
    return BassResponse.fromJson(jsonDecode(response.body));
  }
}
