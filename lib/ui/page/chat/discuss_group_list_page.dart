import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sx_app/model/disscuss_group.dart';
import 'package:sx_app/provider/provider_widget.dart';
import 'package:sx_app/provider/view_state_widget.dart';
import 'package:sx_app/ui/widget/discuss_group_item.dart';
import 'package:sx_app/view_model/discuss_group_list_model.dart';
import 'package:sx_app/view_model/socket_model.dart';
import 'package:sx_app/view_model/user_model.dart';

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
    return ProviderWidget<DiscussGroupListModel>(
      model: DiscussGroupListModel(),
      onModelReady: (discussGroupListModel) {
        discussGroupListModel.initData();
      },
      builder: (context, discussGroupListModel, child) {
        if (discussGroupListModel.isBusy) {
          return ViewStateBusyWidget();
        }
        if (discussGroupListModel.isError) {
          return ViewStateErrorWidget(
            error: discussGroupListModel.viewStateError,
            onPressed: discussGroupListModel.initData,
          );
        }
        List<DiscussGroup> discussGroups = discussGroupListModel.list;

        return Consumer2<MengerModel, SocketModel>(
          builder: (context, mengerModel, socketModel, child) {
            socketModel.connect();
            
            return Scaffold(
              appBar: AppBar(
                title: TextField(
                  decoration: InputDecoration.collapsed(
                    hintText: 'Search',
                  ),
                ),
                elevation: 0.0,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.filter_list,
                    ),
                    onPressed: () {},
                  ),
                ],
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
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
