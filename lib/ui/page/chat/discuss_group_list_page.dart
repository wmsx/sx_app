import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sx_app/model/disscuss_group.dart';
import 'package:sx_app/ui/widget/discuss_group_item.dart';
import 'package:sx_app/view_model/socket_model.dart';

class DiscussGroupListPage extends StatefulWidget {
  @override
  _DiscussGroupListPageState createState() {
    return _DiscussGroupListPageState();
  }
}

class _DiscussGroupListPageState extends State<DiscussGroupListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<SocketModel>(
      builder: (context, socketModel, child) {
        socketModel.discussGroupListModel.initData();
        socketModel.connect();
        List<DiscussGroup> discussGroups =
            socketModel.discussGroupListModel.list;
        return Scaffold(
          appBar: AppBar(
            title: Text(socketModel.connected ? '讨论组' : '连接中...'),
            centerTitle: true,
            elevation: 0.0,
          ),
          body: Container(
            child: ListView.separated(
              padding: EdgeInsets.all(10),
              separatorBuilder: (BuildContext context, int index) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 0.5,
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: Divider(),
                  ),
                );
              },
              itemCount: discussGroups.length,
              itemBuilder: (BuildContext context, int index) {
                DiscussGroup discussGroup = discussGroups[index];
                return DiscussGroupItem(discussGroup: discussGroup);
              },
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
