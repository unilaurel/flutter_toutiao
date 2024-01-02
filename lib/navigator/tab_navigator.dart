import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/my_page.dart';
import '../pages/present_page.dart';
import '../pages/search_page.dart';
import '../pages/task_page.dart';
import '../pages/video_page.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({super.key});

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final Color _defaultColor = Colors.black54;
  final Color _activeColor = Colors.red;
  int _currentIndex = 0;
  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: <Widget>[
          HomePage(),
          // SearchPage(),
          VideoPage(),
          TaskPage(),
          PresentPage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
          _bottomItem('首页', Icons.article),
          _bottomItem('视频', Icons.play_circle_outline_rounded),
          _bottomItem('任务', Icons.event_available),
          _bottomItem('好礼季', Icons.card_giftcard),
          _bottomItem('我的', Icons.person_2_outlined),

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
