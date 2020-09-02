import 'package:sx_app/config/storage_manager.dart';
import 'package:sx_app/provider/view_state_model.dart';
import 'package:sx_app/service/sx_repository.dart';
import 'package:sx_app/view_model/user_model.dart';

const String kLoginName = 'kLoginName';

class LoginModel extends ViewStateModel {
  final MengerModel mengerModel;

  LoginModel(this.mengerModel) : assert(mengerModel != null);

  Future<bool> login(loginName, password) async {
    setBusy();
    try {
      var menger = await SXRepository.login(loginName, password);
      mengerModel.saveMenger(menger);
      StorageManager.sharedPreferences
          .setString(kLoginName, mengerModel.menger.username);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }
}
