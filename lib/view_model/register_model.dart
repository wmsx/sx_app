import 'package:sx_app/provider/view_state_model.dart';
import 'package:sx_app/service/mock_sx_repository.dart';
import 'package:sx_app/service/sx_repository.dart';

import 'mock_model.dart';

class RegisterModel extends ViewStateModel with MockModel {
  Future<bool> singUp(loginName, password) async {
    setBusy();
    try {
      await (isMock
          ? MockSXRepository.register(loginName, password)
          : SXRepository.register(loginName, password));
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }
}
