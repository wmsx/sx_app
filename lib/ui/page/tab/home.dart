import 'package:flutter/material.dart';
import 'package:sx_app/model/category.dart';
import 'package:sx_app/provider/provider_widget.dart';
import 'package:sx_app/provider/view_state_widget.dart';
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

        List<Category> categories = model.list;
        return DefaultTabController(
          length: categories.length,
          child: Scaffold(
            appBar: AppBar(
              title: TabBar(
                isScrollable: true,
                tabs: List.generate(
                  categories.length,
                  (index) => Tab(
                    text: categories[index].name,
                  ),
                ),
              ),
            ),
            body: TabBarView(
              children: List.generate(
                categories.length,
                (index) {
                  return Center(
                    child: Text(categories[index].name),
                  );
                },
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
