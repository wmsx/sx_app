enum ViewState {
  idle,
  busy, // 加载中
  empty, // 无数据
  error, // 加载失败
}

enum ViewStateErrorType {
  defaultError,
  networkTimeoutError, // 网络错误
  unauthorizedError, // 未授权(一般为未登录)
}

class ViewStateError {
  ViewStateErrorType _errorType;
  String message;
  String errorMessage;

  ViewStateError(this._errorType, {this.message, this.errorMessage}) {
    _errorType ??= ViewStateErrorType.defaultError;
    message ??= errorMessage;
  }

  ViewStateErrorType get errorType => _errorType;

}
