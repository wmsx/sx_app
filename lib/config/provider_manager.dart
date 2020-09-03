import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sx_app/view_model/socket_model.dart';
import 'package:sx_app/view_model/user_model.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
];

/// 独立的model
List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider<MengerModel>(
    create: (context) => MengerModel(),
  ),
  ChangeNotifierProvider<SocketModel>(
    create: (context) => SocketModel(),
  ),
];
