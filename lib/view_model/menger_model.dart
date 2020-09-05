import 'package:flutter/material.dart';
import 'package:sx_app/model/menger.dart';

class MengerModel extends ChangeNotifier {
  static const String kMenger = 'kMenger';

  MengerModel() {
    // var mengerMap = StorageManager.localStorage.getItem(kMenger);
    // _menger = mengerMap != null ? Menger.fromJson(mengerMap) : null;
  }

  Menger _menger;

  Menger get menger => _menger;

  bool get hasMenger => _menger != null;

  saveMenger(Menger menger) {
    _menger = menger;
    notifyListeners();
    // StorageManager.localStorage.setItem(kMenger, menger);
  }

  /// 清除持久化的用户数据
  clearMenger() {
    _menger = null;
    notifyListeners();
    // StorageManager.localStorage.deleteItem(kMenger);
  }
}
