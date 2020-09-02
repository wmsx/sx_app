import 'package:flutter/material.dart';
import 'package:sx_app/model/user.dart';

class UserModel extends ChangeNotifier {
  static const String kUser = 'sxUser';

  User _user;

  User get user => _user;

  bool get hasUser => user != null;
}
