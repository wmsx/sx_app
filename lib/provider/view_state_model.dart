import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sx_app/config/net/api.dart';

import 'view_state.dart';

class ViewStateModel with ChangeNotifier {
  /// 当前的页面状态,默认为busy,可在viewModel的构造方法中指定;
  ViewState _viewState;

  ViewStateError _viewStateError;

  /// 根据状态构造
  ///
  /// 子类可以在构造函数指定需要的页面状态
  /// FooModel():super(viewState:ViewState.busy);
  ViewStateModel({ViewState viewState})
      : _viewState = viewState ?? ViewState.idle {
    debugPrint('ViewStateModel---constructor--->$runtimeType');
  }

  ViewState get viewState => _viewState;

  set viewState(ViewState viewState) {
    _viewStateError = null;
    _viewState = viewState;
    notifyListeners();
  }

  void setBusy() {
    viewState = ViewState.busy;
  }

  bool get isBusy => viewState == ViewState.busy;
  bool get isEmpty => viewState == ViewState.empty;
  bool get isIdle => viewState == ViewState.idle;
  bool get isError => viewState == ViewState.error;

  void setEmpty() {
    viewState = ViewState.empty;
  }

  void setIdle() {
    viewState = ViewState.idle;
  }

  ViewStateError get viewStateError => _viewStateError;

  /// [e]分类Error和Exception两种
  void setError(e, stackTrace, {String message}) {
    ViewStateErrorType errorType = ViewStateErrorType.defaultError;
    if (e is DioError) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.SEND_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorType = ViewStateErrorType.networkTimeoutError;
        message = e.error;
      } else if (e.type == DioErrorType.RESPONSE) {
        // incorrect status, such as 404, 503...
        message = e.error;
      } else if (e.type == DioErrorType.CANCEL) {
        message = e.error;
      } else {
        // dio将原error重新套了一层
        e = e.error;
        if (e is UnAuthorizedException) {
          stackTrace = null;
          errorType = ViewStateErrorType.unauthorizedError;
        } else if (e is SocketException) {
          errorType = ViewStateErrorType.networkTimeoutError;
          message = e.message;
        } else {
          message = e.message;
        }
      }
    }

    viewState = ViewState.error;
    _viewStateError =
        ViewStateError(errorType, message: message, errorMessage: e.toString());
    onError(viewStateError);
  }

  void onError(ViewStateError viewStateError) {}
}
