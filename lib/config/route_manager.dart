import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sx_app/main.dart';
import 'package:sx_app/ui/page/chat/discuss_group_list_page.dart';
import 'package:sx_app/ui/page/user/login_page.dart';
import 'package:sx_app/ui/page/user/register_page.dart';

class RouteName {
  static const String splash = 'splash';
  static const String tab = '/';
  static const String mainPage = '/';
  static const String homeSecondFloor = 'homeSecondFloor';
  static const String login = 'login';
  static const String register = 'register';
  static const String articleDetail = 'articleDetail';
  static const String structureList = 'structureList';
  static const String favouriteList = 'favouriteList';
  static const String setting = 'setting';
  static const String coinRecordList = 'coinRecordList';
  static const String coinRankingList = 'coinRankingList';
  static const String discussGroupList = 'discussGroupList';
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.mainPage:
        return CupertinoPageRoute(
          builder: (context) => MainPage(),
        );
      case RouteName.login:
        return CupertinoPageRoute(
            fullscreenDialog: true, builder: (_) => LoginPage());
      case RouteName.register:
        return CupertinoPageRoute(builder: (_) => RegisterPage());
      case RouteName.discussGroupList:
        return CupertinoPageRoute(builder: (_) => DiscussGroupListPage());
      default:
        return CupertinoPageRoute(
          builder: (context) => MainPage(),
        );
    }
  }
}
