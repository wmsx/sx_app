import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sx_app/config/route_manager.dart';
import 'package:sx_app/model/disscuss_group.dart';
import 'package:sx_app/provider/provider_widget.dart';
import 'package:sx_app/ui/page/user/dashboard_post_list_widget.dart';
import 'package:sx_app/ui/page/user/favorite_post_list_widget.dart';
import 'package:sx_app/ui/page/user/thumbup_post_list_widget.dart';
import 'package:sx_app/ui/widget/gradient_border_cotainer.dart';
import 'package:sx_app/view_model/discuss_group_list_model.dart';
import 'package:sx_app/view_model/login_model.dart';
import 'package:sx_app/view_model/menger_model.dart';

const double toolbarHeight = 50.0;

class PersonalPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PersonalPageState();
  }
}

class _PersonalPageState extends State<PersonalPage>
    with SingleTickerProviderStateMixin {
  List<IconData> icons = [
    Icons.dashboard,
    Icons.bookmark,
    Icons.favorite,
  ];

  List<Widget> tabs;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    tabs = List.generate(
      icons.length,
      (index) => Tab(
          icon: Icon(
        icons[index],
        size: 30,
      )),
    );
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人主页'),
        centerTitle: true,
        actions: [
          ProviderWidget<LoginModel>(
            model: LoginModel(
              Provider.of(context),
            ),
            builder: (context, loginModel, child) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: IconButton(
                  icon: Icon(
                    Icons.settings,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min, // 设置最小的弹出
                          children: <Widget>[
                            new ListTile(
                              leading: new Icon(Icons.exit_to_app),
                              title: new Text("退出账号"),
                              onTap: () async {
                                bool success = await loginModel.logout();
                                if (!success) {
                                  loginModel.showErrorMessage(context);
                                }
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
        elevation: 0.0,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: toolbarHeight,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              expandedHeight: MediaQuery.of(context).size.height / 2.5,
              flexibleSpace: FlexibleSpaceBar(
                background: UserHeaderWidget(),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyTabBarDelegate(
                child: TabBar(
                  controller: this._tabController,
                  tabs: this.tabs,
                  labelColor: Color(0xFFA8A4EF),
                  unselectedLabelColor: Colors.grey[400],
                  indicatorColor: Color(0xFFA8A4EF),
                  indicatorWeight: 1.0,
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: this._tabController,
          children: [
            DashboardPostListWidget(),
            FavoritePostListWidget(),
            ThumbUpPostListWidget(),
          ],
        ),
      ),
    );
  }
}

class UserHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Column(
              children: [
                Consumer<MengerModel>(
                  builder: (context, mengerModel, _) {
                    return Row(
                      children: [
                        InkWell(
                          onTap: mengerModel.hasMenger
                              ? null
                              : () {
                                  Navigator.of(context)
                                      .pushNamed(RouteName.login);
                                },
                          child: GradientBorderContainer(
                            size: 60,
                            shape: BoxShape.circle,
                            image: mengerModel.hasMenger
                                ? NetworkImage(mengerModel.menger.avatar)
                                : AssetImage(
                                    'assets/images/default_avatar.png'),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          mengerModel.hasMenger
                              ? mengerModel.menger.name
                              : '未登录',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCategory('收藏'),
                    _buildCategory('点赞'),
                    _buildCategory('讨论'),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '讨论',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteName.discussGroupList);
                  },
                  child: Text(
                    '查看全部>>',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 60.0,
            child: Consumer<DiscussGroupListModel>(
              builder: (context, model, child) {
                List<DiscussGroup> discussGroups = model.list;
                if (discussGroups.isEmpty) {
                  return Container();
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: discussGroups.length,
                  itemBuilder: (BuildContext context, int index) {
                    DiscussGroup discussGroup = discussGroups[index];
                    return Container(
                      margin: EdgeInsets.all(10),
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 2),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        child: ClipOval(
                          child: Image(
                            height: 40,
                            width: 40,
                            image: NetworkImage(discussGroup.cover),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategory(String title) {
    return Column(
      children: <Widget>[
        Text(
          '222',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(),
        ),
      ],
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  final Color color;

  StickyTabBarDelegate({
    @required this.child,
    this.color = Colors.white,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: this.color,
      child: this.child,
    );
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
