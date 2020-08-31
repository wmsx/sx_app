import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sx_app/model/disscuss_group.dart';
import 'package:sx_app/provider/provider_widget.dart';
import 'package:sx_app/provider/view_state_widget.dart';
import 'package:sx_app/ui/widget/discuss_group_item.dart';
import 'package:sx_app/view_model/discuss_group_list_model.dart';

class CommunityPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CommunityPageState();
  }
}

class _CommunityPageState extends State<CommunityPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<DiscussGroupListModel>(
      model: DiscussGroupListModel(),
      onModelReady: (model) {
        model.initData();
      },
      builer: (context, model, child) {
        if (model.isBusy) {
          return ViewStateBusyWidget();
        }
        if (model.isError) {
          return ViewStateErrorWidget(
            error: model.viewStateError,
            onPressed: model.initData,
          );
        }

        List<DiscussGroup> discussGroups = model.list;
        return Scaffold(
          appBar: AppBar(
            title: TextField(
              decoration: InputDecoration.collapsed(
                hintText: 'Search',
              ),
            ),
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
  }

  @override
  bool get wantKeepAlive => true;
}
