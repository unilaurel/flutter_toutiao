import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_toutiao/model/news_model.dart';
import 'package:flutter_toutiao/pages/search_page.dart';
import 'package:flutter_toutiao/widget/loadding_container.dart';
import 'package:flutter_toutiao/widget/web_view.dart';

import '../dao/news_dao.dart';
import '../utils/navigator_util.dart';
import '../widget/search_bar.dart';
import 'home_tab_page.dart';

const SEARCH_BAR_DEFAULT_TEXT = '长安区谈固街道办事处发通告';
const DEFAULT_IMAGE_URL =
    'https://p3-sign.toutiaoimg.com/tos-cn-i-tjoges91tu/TPxuPrp29DHonL~noop.image?_iz=58558&from=article.pc_detail&lk3s=953192f4&x-expires=1704462481&x-signature=a32IYOaQ3SAmmA4MSTJbmI5Amj4%3D';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<String> _list = [
    '关注',
    '推荐',
    '热榜',
    '发现',
    '问界M9',
    '北京',
    '视频',
    '畅听',
    '图片',
    '娱乐',
    '科技'
  ];

  List<News> _listNews = [];

  late TabController _controller;

  Future<Null> _handleRefresh() async {
    NewsModel model = await NewsDao.fetch();
    setState(() {
      _listNews = model.result!.list!;

      // _loading = false;
    });
    return null;
  }

  @override
  void initState() {
    _controller =
        TabController(length: _list.length, initialIndex: 1, vsync: this);
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SearchBar_(
          searchBarType: SearchBarType.home,
          inputBoxClick: _jumpToSearch,
          defaultText: SEARCH_BAR_DEFAULT_TEXT,
        ),
        _tabBar(),
        Expanded(
          child: TabBarView(
              controller: _controller,
              children: _list.map((e) => _listView(e)).toList()),
        ),
      ],
    ));
  }
//navigation bar
  _tabBar() {
    return Container(
      height: 30,
      child: TabBar(
        isScrollable: true,
        labelColor: Colors.red,
        labelStyle: TextStyle(fontWeight: FontWeight.w700),
        unselectedLabelStyle: TextStyle(fontSize: 14),
        indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.red, width: 2),
            insets: EdgeInsets.fromLTRB(5, 0, 5, 2)),
        controller: _controller,
        tabs: _list
            .map((e) => Tab(
                  child: Text(e),
                ))
            .toList(),
      ),
    );
  }

  _jumpToSearch() {
    NavigatorUtil.push(
        context,
        SearchPage(
          hint: SEARCH_BAR_DEFAULT_TEXT,
        ));
  }
//body
  MediaQuery _listView(String e) {
    Widget _widget = _listNewsColunm(e);
    return MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView(
          children: [
            _widget,
            if (e == '推荐') ...[_card(7), _cardMiddle(6), _card(8), _card(9)]
          ],
        ));
  }

  //top news
  _listNewsColunm(String e) {
    bool _topFlag = true;

    if (e == '推荐') {
      return _listNews.isEmpty
          ? Container()
          : Column(
              children: List.generate(
                  5,
                  (index) => _listTitle(
                      index < 3 ? _topFlag = true : _topFlag = false,
                      index + 1)),
            );
    }
    return Center(
      child: Center(
        child: Text(
          e,
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
//top news 明細
  _listTitle(bool _topFlag, int index) {
    Random random = new Random();
    int randomNum = random.nextInt(200) + 50;

    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.zero,
      child: GestureDetector(
        onTap: () {
          NavigatorUtil.push(context, WebViews(url: _listNews[index].url!));
        },
        child: Column(children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _listNews[index].title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          Row(
            children: [
              _topFlag
                  ? Text(
                      '置顶',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    )
                  : Container(),
              _topFlag
                  ? SizedBox(
                      width: 10,
                    )
                  : Container(),
              Text(
                _listNews[index].source!,
                style: TextStyle(color: Colors.black54, fontSize: 12),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '$randomNum评论',
                style: TextStyle(color: Colors.black54, fontSize: 12),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  //middle news
  _card(int index) {
    if (_listNews.isEmpty) {
      return Container();
    }
    return GestureDetector(
      onTap: () {
        NavigatorUtil.push(context, WebViews(url: _listNews[index].url!));
      },
      child: Column(
        children: [
          SizedBox(
            height: 18,
          ),
          Container(
            padding: EdgeInsets.all(5),
            alignment: Alignment.centerLeft,
            child: Text(_listNews[index].title!),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: PhysicalModel(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              clipBehavior: Clip.antiAlias,
              child: index == 9
                  ? Image.network(DEFAULT_IMAGE_URL)
                  : Image.network(_listNews[index].picUrl!),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          Row(
            children: [
              index == 7 || index == 8
                  ? Container(
                      margin: EdgeInsets.only(left: 5),
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(color: Colors.orange[50]),
                      child: Row(
                        children: [
                          Icon(
                            Icons.whatshot,
                            size: 11,
                            color: Colors.red,
                          ),
                          Text(
                            '上升热点',
                            style: TextStyle(color: Colors.red, fontSize: 10),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              SizedBox(
                width: 10,
              ),
              Text(
                _listNews[index].source!,
                style: TextStyle(color: Colors.black54, fontSize: 12),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                _listNews[index].ctime!,
                style: TextStyle(color: Colors.black54, fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }

  //middle news2
  _cardMiddle(int index) {
    if (_listNews.isEmpty) {
      return Container();
    }
    return GestureDetector(
        onTap: () {
          NavigatorUtil.push(context, WebViews(url: _listNews[index].url!));
        },
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
              width: 0.5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(6))
          ),

          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(_listNews[index].title!),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Container(
                          decoration:
                          BoxDecoration(color: Colors.orange[50]),
                          child: Row(
                            children: [
                              Icon(
                                Icons.whatshot,
                                size: 11,
                                color: Colors.red,
                              ),
                              Text(
                                '热点',
                                style: TextStyle(
                                    color: Colors.red, fontSize: 10),
                              ),
                            ],
                          ),
                        )
                        ,
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          _listNews[index].source!,
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          _listNews[index].ctime!.substring(0,10)!,
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  // padding: EdgeInsets.all(5),
                  child: PhysicalModel(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(DEFAULT_IMAGE_URL)),
                ),
              )
            ],
          ),
        )
    );
  }
}
