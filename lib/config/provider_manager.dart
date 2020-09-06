import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sx_app/view_model/discuss_group_list_model.dart';
import 'package:sx_app/view_model/socket_model.dart';
import 'package:sx_app/view_model/menger_model.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
];

/// 独立的model
List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider<MengerModel>(
    create: (context) => MengerModel(),
  ),
];

/// 需要依赖的model
///
List<SingleChildWidget> dependentServices = [
  ChangeNotifierProxyProvider<MengerModel, DiscussGroupListModel>(
    create: (_) => DiscussGroupListModel(),
    update: (context, mengerModel, discussGroupListModel) =>
        discussGroupListModel..update(mengerModel),
  ),
  ChangeNotifierProxyProvider<DiscussGroupListModel, SocketModel>(
    create: (_) => SocketModel(),
    update: (context, discussGroupListModel, socketModel) =>
        socketModel..update(discussGroupListModel),
  ),
];
