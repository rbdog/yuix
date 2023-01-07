import 'dart:convert';
import 'package:yuix/src/utils/http_server.dart';

enum HttpMethod {
  get,
  post,
}

abstract class HttpRequest {
  abstract final String pathPattern;
  abstract final HttpMethod method;
  abstract final Map<String, String> pathParams;
  abstract final Map<String, String> queryParams;

  /// Need if not GET Method
  abstract final Object? body;
}

class HttpApi<RequestT extends HttpRequest, ResBodyT> {
  final String baseUrl;
  final ResBodyT Function(String json) jsonToRes;
  HttpApi({
    required this.baseUrl,
    required this.jsonToRes,
  });

  Future<ResBodyT> send(RequestT req) async {
    // Path Params
    var path = req.pathPattern;
    for (final param in req.pathParams.entries) {
      path = path.replaceFirst(':${param.key}', param.value);
    }
    // Query Params
    if (req.queryParams.isNotEmpty) {
      final List<String> queryStrings = [];
      for (final param in req.queryParams.entries) {
        queryStrings.add('${param.key}=${param.value}');
      }
      path += '?';
      path += queryStrings.join('&');
    }
    final urlString = '$baseUrl$path';
    final url = Uri.parse(urlString);
    final bodyJson = jsonEncode(req.body);

    late String rawResBody;
    switch (req.method) {
      case HttpMethod.get:
        rawResBody = await httpGet(url);
        break;
      case HttpMethod.post:
        rawResBody = await httpPost(url, bodyJson);
        break;
    }

    final ResBodyT resBody = jsonToRes(rawResBody);
    return resBody;
  }
}

class DisabledHttpApi<RequestT extends HttpRequest, ResBodyT>
    extends HttpApi<RequestT, ResBodyT> {
  DisabledHttpApi()
      : super(
          baseUrl: '',
          jsonToRes: (json) => throw Exception('This API is Disabled now'),
        );
  @override
  Future<ResBodyT> send(RequestT req) async {
    final log = req.pathPattern;
    throw Exception('Disabled API: $log');
  }
}
