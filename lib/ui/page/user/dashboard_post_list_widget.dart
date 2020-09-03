import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sx_app/model/post.dart';
import 'package:sx_app/provider/provider_widget.dart';
import 'package:sx_app/provider/view_state_widget.dart';
import 'package:sx_app/ui/page/user/empty_widget.dart';
import 'package:sx_app/ui/widget/post_widget.dart';
import 'package:sx_app/view_model/dashboard_post_model.dart';

class DashboardPostListWidget extends StatefulWidget {
  @override
  _DashboardPostListWidgetState createState() {
    return _DashboardPostListWidgetState();
  }
}

class _DashboardPostListWidgetState extends State<DashboardPostListWidget> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<DashboardPostModel>(
      model: DashboardPostModel(),
      onModelReady: (model) {
        model.initData();
      },
      builer: (context, model, child) {
        if (model.isBusy) {
          return ViewStateBusyWidget();
        }
        if (model.isError) {
          return ViewStateErrorWidget(
              error: model.viewStateError, onPressed: model.initData);
        }
        if (model.isEmpty) {
          return EmptyDashboradWidget();
        }

        return SmartRefresher(
          controller: model.refreshController,
          onRefresh: model.refresh,
          onLoading: model.loadMore,
          enablePullUp: true,
          child: ListView.builder(
            itemCount: model.list.length,
            itemBuilder: (context, index) {
              Post post = model.list[index];
              return PostWidget(post);
            },
          ),
        );
      },
    );
  }
}
