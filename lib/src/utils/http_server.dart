import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:yuix/src/utils/http_api.dart';

Future<String> httpGet(Uri url) async {
  final rawRes = await http.get(
    url,
    headers: {
      "Content-Type": "application/json",
    },
  );
  if (rawRes.statusCode == 200) {
    // utf8で受け取る
    final rawResBody = utf8.decode(rawRes.bodyBytes);
    return rawResBody;
  } else {
    throw ("Error Status Code: ${rawRes.statusCode}");
  }
}

Future<String> httpPost(Uri url, String bodyJson) async {
  final encoding = Encoding.getByName('utf-8');
  final rawRes = await http.post(
    url,
    body: bodyJson,
    headers: {
      'Content-Type': 'application/json',
    },
    encoding: encoding,
  );
  if (rawRes.statusCode == 200) {
    // utf8で受け取る
    final rawResBody = utf8.decode(rawRes.bodyBytes);
    return rawResBody;
  } else {
    throw ("Error Status Code: ${rawRes.statusCode}");
  }
}

class HttpServer {
  final String url;
  HttpServer({
    required this.url,
  });

  HttpApi<RequestT, ResBodyT> api<RequestT extends HttpRequest, ResBodyT>(
    ResBodyT Function(dynamic json) jsonToRes,
  ) {
    return HttpApi<RequestT, ResBodyT>(baseUrl: url, jsonToRes: jsonToRes);
  }
}

class DisabledHttpServer extends HttpServer {
  DisabledHttpServer() : super(url: '');

  @override
  HttpApi<RequestT, ResBodyT> api<RequestT extends HttpRequest, ResBodyT>(
    ResBodyT Function(dynamic json) jsonToRes,
  ) {
    return DisabledHttpApi();
  }
}
