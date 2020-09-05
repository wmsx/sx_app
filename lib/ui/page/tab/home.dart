import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sx_app/model/category.dart';
import 'package:sx_app/provider/provider_widget.dart';
import 'package:sx_app/provider/view_state_widget.dart';
import 'package:sx_app/ui/page/post/category_post_list_page.dart';
import 'package:sx_app/view_model/category_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<CategoryModel>(
      model: CategoryModel(),
      onModelReady: (model) {
        model.initData();
      },
      builder: (context, model, child) {
        if (model.isBusy) {
          return ViewStateBusyWidget();
        }
        if (model.isError) {
          return ViewStateErrorWidget(
            error: model.viewStateError,
            onPressed: model.initData,
          );
        }

        List<Category> categories = model.list;
        return DefaultTabController(
          length: categories.length,
          child: Scaffold(
            backgroundColor: Color(0xFFEDF0F2),
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 80.0,
              leading: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Icon(Icons.menu),
              ),
              actions: [
                Container(
                  margin: EdgeInsets.only(right: 10.0),
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Icon(Icons.share),
                ),
              ],
              bottom: TabBar(
                isScrollable: true,
                tabs: List.generate(
                  categories.length,
                  (index) => Tab(
                    text: categories[index].showName,
                  ),
                ),
                indicator: const BoxDecoration(),
                labelStyle: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelColor: Colors.grey[400],
              ),
            ),
            body: TabBarView(
              children: List.generate(
                categories.length,
                (index) => CategoryPostListPage(categories[index].id),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
