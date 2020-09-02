import 'package:sx_app/provider/view_state_model.dart';
import 'package:sx_app/view_model/user_model.dart';

class LoginModel extends ViewStateModel {
  final UserModel userModel;

  LoginModel(this.userModel) : assert(userModel != null);

  
}
