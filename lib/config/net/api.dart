import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

abstract class BaseHttp extends DioForNative {
  BaseHttp() {
    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    init();
  }

  void init();
}

abstract class BaseResponseData {
  int code = 0;
  String message;
  dynamic data;

  BaseResponseData({this.code, this.message, this.data});
}

class NotSuccessException implements Exception {
  String message;

  NotSuccessException.fromResponseData(BaseResponseData responseData) {
    message = responseData.message;
  }
}

class UnAuthorizedException implements Exception {
  const UnAuthorizedException();
}
