import 'package:flutter/material.dart';
import 'package:sx_app/ui/widget/gradient_border_cotainer.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Icon(
                    Icons.settings,
                  ),
                ),
              ],
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GradientBorderContainer(
            size: 80,
            shape: BoxShape.circle,
            image: NetworkImage(
                'https://i1.hdslb.com/bfs/face/046edcb046a97ab421dce0ed8cb36be447ae1f28.jpg'),
          ),
          Text(
            'username',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCategory('收藏'),
                _buildCategory('点赞'),
                _buildCategory('讨论'),
              ],
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
