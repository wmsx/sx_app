import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'provider/view_state_widget.dart';
import 'ui/page/tab/personal.dart';
import 'ui/page/tab/comunity.dart';
import 'ui/page/tab/explore.dart';
import 'ui/page/tab/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '私享',
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: [
          HomePage(),
          ExplorePage(),
          CommunityPage(),
          PersonalPage(),
          ViewStateBusyWidget(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.pink,
        items: [
          BottomNavigationBarItem(
            title: Text('首页'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('探索'),
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            title: Text('社区'),
            icon: Icon(Icons.forum),
          ),
          BottomNavigationBarItem(
            title: Text('我的'),
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            title: Text('测试'),
            icon: Icon(Icons.text_snippet),
          ),
        ],
        currentIndex: _page,
        onTap: navigationTapped,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
