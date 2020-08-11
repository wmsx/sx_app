import 'package:dio/dio.dart';
import 'package:sx_app/config/net/api.dart';

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = 'http://api.wemeng.com/';
    interceptors..add(ApiInterceptor());
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
    code = json['errorCode'];
    message = json['errorMsg'];
    data = json['data'];
  }
}
