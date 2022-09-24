import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yuix/src/utils/app_error.dart';

class HttpServer {
  final String url;
  HttpServer({
    required this.url,
  });

  HttpApi<ReqType, ResType> api<ReqType, ResType>({
    required String path,
  }) {
    return HttpApi<ReqType, ResType>(
      baseUrl: url,
      path: path,
    );
  }
}

class HttpApi<ReqType, ResType> {
  final String baseUrl;
  final String path;

  HttpApi({
    required this.baseUrl,
    required this.path,
  });

  Future<Result<ResType>> get() async {
    var urlString = '$baseUrl$path';
    var url = Uri.parse(urlString);

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      // utf8で受け取る
      final rawString = utf8.decode(response.bodyBytes);
      final ResType res = jsonDecode(rawString);
      return Result.ok(res);
    } else {
      final error = AppError(
        id: 'httpBadStatus',
        detail: 'Status Code: ${response.statusCode}',
      );
      return Result.error(error);
    }
  }

  Future<Result<ResType>> post(ReqType req) async {
    var urlString = '$baseUrl$path';
    var url = Uri.parse(urlString);

    final encoding = Encoding.getByName('utf-8');
    final body = jsonEncode(req);
    final response = await http.post(
      url,
      body: body,
      headers: {
        'Content-Type': 'application/json',
      },
      encoding: encoding,
    );
    if (response.statusCode == 200) {
      // utf8で受け取る
      final rawString = utf8.decode(response.bodyBytes);
      final ResType res = jsonDecode(rawString);
      return Result.ok(res);
    } else {
      final error = AppError(
        id: 'httpBadStatus',
        detail: 'Status Code: ${response.statusCode}',
      );
      return Result.error(error);
    }
  }
}
