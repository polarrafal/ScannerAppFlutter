import 'dart:convert';
import 'package:http/http.dart';
import 'package:scannerappflutter/services/configuration_service.dart';

class HttpService {
  Uri getUri(String endpoint) {
    var url = '${ConfigurationService.baseUrl}/api/$endpoint';
    var uri = Uri.parse(url);
    return uri;
  }

  Future<Response> getAsync(String endpoint) async {
    var uri = getUri(endpoint);
    var getResponse = await get(uri);
    return getResponse;
  }

  Future<Response> postAsync(String endpoint, Object data) async {
    var uri = getUri(endpoint);
    var postResponse = await post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data));

    return postResponse;
  }
}
