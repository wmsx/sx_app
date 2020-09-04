import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sx_app/model/post.dart';
import 'package:sx_app/provider/provider_widget.dart';
import 'package:sx_app/provider/view_state_widget.dart';
import 'package:sx_app/ui/widget/post_widget.dart';
import 'package:sx_app/view_model/favorite_post_model.dart';

import 'empty_widget.dart';

class FavoritePostListWidget extends StatefulWidget {
  @override
  _FavoritePostListWidgetState createState() {
    return _FavoritePostListWidgetState();
  }
}

class _FavoritePostListWidgetState extends State<FavoritePostListWidget> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<FavoritePostModel>(
      model: FavoritePostModel(),
      onModelReady: (model) {
        model.initData();
      },
      builder: (context, model, child) {
        if (model.isBusy) {
          return ViewStateBusyWidget();
        }
        if (model.isError) {
          return SingleChildScrollView(
            child: ViewStateErrorWidget(
              error: model.viewStateError,
              onPressed: model.initData,
            ),
          );
        }
        if (model.isEmpty) {
          return EmptyFavoriteWidget();
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
