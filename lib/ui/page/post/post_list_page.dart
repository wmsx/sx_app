import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sx_app/model/post.dart';
import 'package:sx_app/provider/provider_widget.dart';
import 'package:sx_app/provider/view_state_widget.dart';
import 'package:sx_app/ui/widget/post_widget.dart';
import 'package:sx_app/view_model/post_list_model.dart';

class PostListPage extends StatefulWidget {
  final int categoryId;

  const PostListPage(this.categoryId, {Key key}) : super(key: key);

  @override
  _PostListPageState createState() {
    return _PostListPageState();
  }
}

class _PostListPageState extends State<PostListPage> {
  @override
  Widget build(BuildContext context) {
    int cid = widget.categoryId;
    return ProviderWidget<PostListModel>(
      model: PostListModel(cid),
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
          return ViewStateEmptyWidget(
            onPressed: model.initData(),
          );
        }

        return SmartRefresher(
          controller: model.refreshController,
          onRefresh: model.refresh,
          onLoading: model.loadMore,
          child: ListView.builder(
              itemCount: model.list.length,
              itemBuilder: (context, index) {
                Post post = model.list[index];
                return PostWidget(post);
              }),
        );
      },
    );
  }
}
