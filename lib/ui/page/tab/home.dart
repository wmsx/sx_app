import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: [
            Tab(
              text: '1xxxxxxxxxxxxxxxxxxx',
            ),
            Tab(
              text: '2xxxxxxxxxxxxxxxxxx',
            ),
            Tab(
              text: '3xxxxxxxxxxxxxxx',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
