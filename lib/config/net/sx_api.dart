import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:sx_app/config/net/api.dart';

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
    var cookieJar = CookieJar();
    options.baseUrl = 'http://api.wemeng.com/';
    // options.baseUrl = 'http://192.168.0.199:8080/';
    interceptors..add(ApiInterceptor())..add(CookieManager(cookieJar));
  }
}

class ApiInterceptor extends InterceptorsWrapper {
  @override
  Future onResponse(Response response) {
    ResponseData responseData = ResponseData.fromJson(response.data);
    if (responseData.success) {
      response.data = responseData.data;
      return http.resolve(response);
    } else {
      if (responseData.code == -1001) {
        throw const UnAuthorizedException();
      } else {
        throw NotSuccessException.fromResponseData(responseData);
      }
    }
  }
}

class ResponseData extends BaseResponseData {
  bool get success => 0 == code;

  ResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }
}
