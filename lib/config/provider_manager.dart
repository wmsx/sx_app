import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sx_app/view_model/user_model.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
];

/// 独立的model
List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider<UserModel>(
    create: (context) => UserModel(),
  ),
];
