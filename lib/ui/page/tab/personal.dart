import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sx_app/config/route_manager.dart';
import 'package:sx_app/ui/widget/gradient_border_cotainer.dart';
import 'package:sx_app/view_model/user_model.dart';

const double toolbarHeight = 50.0;

class PersonalPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PersonalPageState();
  }
}

class _PersonalPageState extends State<PersonalPage>
    with SingleTickerProviderStateMixin {
  List<Widget> tabs = [
    Tab(
        icon: Icon(
      Icons.favorite,
      size: 30,
    )),
    Tab(
        icon: Icon(
      Icons.dashboard,
      size: 30,
    )),
    Tab(
        icon: Icon(
      Icons.bookmark,
      size: 30,
    )),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  Widget _buildStory() {
    return Container(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return SizedBox(width: 10);
          }
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
                  height: 50,
                  width: 50,
                  image: NetworkImage(
                      'https://i1.hdslb.com/bfs/face/046edcb046a97ab421dce0ed8cb36be447ae1f28.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人主页'),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
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
            Center(
              child: Text('1'),
            ),
            Center(
              child: Text('2'),
            ),
            Center(
              child: Text('3'),
            ),
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
                              ? mengerModel.menger.username
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
          Container(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return SizedBox(width: 10);
                }
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
                        height: 50,
                        width: 50,
                        image: NetworkImage(
                            'https://i1.hdslb.com/bfs/face/046edcb046a97ab421dce0ed8cb36be447ae1f28.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
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
