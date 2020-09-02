import 'package:flutter/material.dart';
import 'package:sx_app/config/storage_manager.dart';
import 'package:sx_app/model/menger.dart';

class MengerModel extends ChangeNotifier {
  static const String kMenger = 'kMenger';

  Menger _menger;

  Menger get menger => _menger;

  bool get hasMenger => _menger != null;

  saveMenger(Menger menger) {
    _menger = menger;
    notifyListeners();
    StorageManager.localStorage.setItem(kMenger, menger);
  }
}
