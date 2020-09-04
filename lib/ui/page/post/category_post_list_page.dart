import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sx_app/model/post.dart';
import 'package:sx_app/provider/provider_widget.dart';
import 'package:sx_app/provider/view_state_widget.dart';
import 'package:sx_app/ui/widget/post_widget.dart';
import 'package:sx_app/view_model/post_list_model.dart';

class CategoryPostListPage extends StatefulWidget {
  final int categoryId;

  const CategoryPostListPage(this.categoryId, {Key key}) : super(key: key);

  @override
  _CategoryPostListPageState createState() {
    return _CategoryPostListPageState();
  }
}

class _CategoryPostListPageState extends State<CategoryPostListPage> {
  @override
  Widget build(BuildContext context) {
    int cid = widget.categoryId;
    return ProviderWidget<PostListModel>(
      model: PostListModel(cid),
      onModelReady: (model) {
        model.initData();
      },
      builder: (context, model, child) {
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
