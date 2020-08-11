// 加载中
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sx_app/config/resource_mamanger.dart';
import 'package:sx_app/generated/l10n.dart';
import 'package:sx_app/provider/view_state.dart';

class ViewStateBusyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

// 错误Widget
class ViewStateErrorWidget extends StatelessWidget {
  final ViewStateError error;
  final String title;
  final String message;
  final Widget image;
  final Widget buttonText;
  final String buttonTextData;
  final VoidCallback onPressed;

  ViewStateErrorWidget({
    Key key,
    @required this.error,
    this.title,
    this.message,
    this.image,
    this.buttonText,
    this.buttonTextData,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var defaultImage;
    var defaultTitle;
    var errorMessage = error.message;
    String defaultTextData = S.of(context).viewStateButtonRetry;

    switch (error.errorType) {
      case ViewStateErrorType.networkTimeoutError:
        defaultImage = Transform.translate(
          offset: Offset(-50, 0),
          child: Icon(
            IconFonts.pageNetworkError,
          ),
        );
        defaultTitle = S.of(context).viewStateMessageNetworkError;
        break;
      case ViewStateErrorType.defaultError:
        defaultImage = Icon(
          IconFonts.pageError,
          size: 100,
          color: Colors.grey,
        );
        defaultTitle = S.of(context).viewStateMessageError;
        break;
      case ViewStateErrorType.unauthorizedError:
        return ViewStateUnAuthWidget(
          image: image,
          message: message,
          buttonText: buttonText,
          onPressed: onPressed,
        );
    }

    return ViewStateWidget(
      onPressed: this.onPressed,
      image: image ?? defaultImage,
      title: title ?? defaultTitle,
      message: message ?? errorMessage,
      buttonTextData: buttonTextData ?? defaultTextData,
      buttonText: buttonText,
    );
  }
}

/// 页面未授权
class ViewStateUnAuthWidget extends StatelessWidget {
  final String message;
  final Widget image;
  final Widget buttonText;
  final VoidCallback onPressed;

  const ViewStateUnAuthWidget(
      {Key key, this.message, this.image, this.buttonText, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewStateWidget(
      onPressed: this.onPressed,
      image: image ?? ViewStateUnAuthImage(),
      title: message ?? S.of(context).viewStateMessageUnAuth,
      buttonText: this.buttonText,
      buttonTextData: S.of(context).viewStateButtonLogin,
    );
  }
}

/// 未授权图片
class ViewStateUnAuthImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ViewStateWidget extends StatelessWidget {
  final String title;
  final String message;
  final Widget image;
  final Widget buttonText;
  final String buttonTextData;
  final VoidCallback onPressed;

  const ViewStateWidget(
      {Key key,
      this.title,
      this.message,
      this.image,
      this.buttonText,
      this.buttonTextData,
      @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        image ??
            Icon(
              IconFonts.pageError,
              size: 80,
              color: Colors.grey[500],
            ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            children: [
              Text(
                title ?? S.of(context).viewStateMessageError,
              ),
              SizedBox(
                height: 20,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 200,
                  minHeight: 150,
                ),
                child: SingleChildScrollView(
                  child: Text(message ?? ''),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: ViewStateButton(
            onPressed: onPressed,
            textData: buttonTextData,
            child: buttonText,
          ),
        ),
      ],
    );
  }
}

class ViewStateButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final String textData;

  const ViewStateButton(
      {Key key, @required this.onPressed, this.child, this.textData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: onPressed,
      child: child ??
          Text(
            textData ?? S.of(context).viewStateButtonRetry,
            style: TextStyle(wordSpacing: 5),
          ),
      textColor: Colors.grey,
    );
  }
}
