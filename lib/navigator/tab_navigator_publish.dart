import 'package:flutter/material.dart';
import 'package:flutter_toutiao/pages/publish_page.dart';
import '../pages/home_page.dart';
import '../pages/my_page.dart';
import '../pages/present_page.dart';
import '../pages/search_page.dart';
import '../pages/task_page.dart';
import '../pages/video_page.dart';

class TabBarNavigator extends StatefulWidget {
  const TabBarNavigator({super.key});

  @override
  State<TabBarNavigator> createState() => _TabBarNavigatorState();
}

class _TabBarNavigatorState extends State<TabBarNavigator> {
  final Color _defaultColor = Colors.black;
  final Color _activeColor = Colors.red;
  int _currentIndex = 2;
  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: <Widget>[
          // HomePage(),
          // // SearchPage(),
          // VideoPage(),
          PublishPage(),
          // PresentPage(),
          // MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.black,
        unselectedItemColor: _defaultColor,
        selectedItemColor: _activeColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          _bottomItem('灵感',Icons.article),
          _bottomItem('文章', Icons.play_circle_outline_rounded),
          _bottomItem('微头条', Icons.event_available),
          _bottomItem('模版', Icons.card_giftcard),
          _bottomItem('视频', Icons.person_2_outlined),

          // BottomNavigationBarItem(
          //     icon: Icon(
          //       Icons.account_circle,
          //       color: _defaultColor,
          //     ),
          //     activeIcon: Icon(
          //       Icons.account_circle,
          //       color: _activeColor,
          //     ),
          //     label: "我的"),
        ],
      ),
    );
  }

  _bottomItem(String title, IconData icon) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: _defaultColor,
        ),
        activeIcon: Icon(
          icon,
          color: _activeColor,
        ),
        label: title);
  }
}
