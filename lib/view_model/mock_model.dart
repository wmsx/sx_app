import 'package:sx_app/service/mock_sx_repository.dart';
import 'package:sx_app/service/sx_repository.dart';

class MockModel {
  static Repository _mock = MockSXRepository();
  static Repository _actual = SXRepository();

  bool isMock = true;

  Repository get repository => isMock ? _mock : _actual;
}
