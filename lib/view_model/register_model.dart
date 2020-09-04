import 'package:sx_app/provider/view_state_model.dart';

import 'mock_model.dart';

class RegisterModel extends ViewStateModel with MockModel {
  Future<bool> singUp(loginName, password) async {
    setBusy();
    try {
      await repository.register(loginName, password);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }
}
