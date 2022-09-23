// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

class AppError {
  final String id;
  final String detail;
  const AppError({
    required this.id,
    required this.detail,
  });

  factory AppError.fromJson(Map<String, Object?> json) {
    return AppError(id: json['id'] as String, detail: json['detail'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'detail': detail,
    };
  }
}

/// Result
class Result<Value> {
  final Value? value;
  final AppError? error;
  Result._(this.value, this.error);

  factory Result.ok(Value value) {
    return Result._(value, null);
  }

  factory Result.error(AppError error) {
    return Result._(null, error);
  }
}

Result<Value> json2result<Value>(Map<String, Object?> json) {
  final jsonValue = jsonEncode(json['value']);
  final Value value = jsonDecode(jsonValue);
  final jsonError = jsonEncode(json['error']);
  final AppError error = jsonDecode(jsonError);
  return Result._(
    value,
    error,
  );
}

String result2json<Value>(Result<Value> result) {
  final json = jsonEncode(result);
  return json;
}
