import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const DEFAULT_TEXT = '说点什么或者试试图片智能配文吧';

class PublishPage extends StatefulWidget {
  PublishPage({super.key});

  @override
  State<PublishPage> createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  bool showClear = false;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent, // 透明状态栏背景
      statusBarIconBrightness: Brightness.light, // 状态栏文字颜色为白色
    ));
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          _appBar(),
          Expanded(child: _textBox()),
        ],
      ),
    ));
  }

  _appBar() {
    return Container(
      height: MediaQuery.of(context).padding.top,
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: Colors.black,
      ),
    );
  }

  _textBox() {
    return Column(
      children: [
        _topButton(),
        _inputBox(),
        _imageBox(),
        Expanded(child: _items())
      ],
    );
  }

  _onChanged(String text) {
    if (text.length > 0) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
  }

  _wrapTap(Widget child, void Function()? callback) {
    return GestureDetector(
      onTap: () {
        if (callback != null) callback();
      },
      child: child,
    );
  }

  _inputBox() {
    return Container(
      height: 100,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            onChanged: _onChanged,
            autofocus: true,
            maxLines: 4,
            cursorHeight: 18,
            cursorColor: Colors.blue,
            cursorWidth: 1,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black54,
              fontWeight: FontWeight.w300,
            ),
            decoration: InputDecoration(
                hintText: DEFAULT_TEXT,
                hintStyle: TextStyle(
                  color: Colors.black54,
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none),

            //     hintStyle: TextStyle(fontSize: 15)),
          )),
        ],
      ),
    );
  }

  _topButton() {
    return Row(
      children: [
        Expanded(
            child: Row(
          children: [
            TextButton(
                onPressed: () {},
                child: Text(
                  '取消',
                  style: TextStyle(color: Colors.black),
                )),
          ],
        )),
        Row(
          children: [
            TextButton(
                onPressed: () {},
                child: Text(
                  '预览',
                  style:
                      TextStyle(color: !showClear ? Colors.grey : Colors.black),
                )),
            TextButton(
                onPressed: () {},
                child: Text(
                  '发布',
                  style: TextStyle(
                      color: !showClear ? Colors.black : Colors.red,
                      fontWeight:
                          !showClear ? FontWeight.normal : FontWeight.w700),
                )),
          ],
        )
      ],
    );
  }

  _imageBox() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(color: Colors.black12),
                child: Icon(
                  Icons.add,
                  size: 60,
                  color: Colors.grey,
                ),
              )
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '热聊话题',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                '添加话题，获得更多曝光',
                style: TextStyle(fontSize: 11, color: Colors.black87),
              ),
            ],
          )
        ],
      ),
    );
  }

  _items() {
    return MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView(
          children: [
            _item(1, '退休金养老还不够吗', '55万热度'),
            _item(2, '养老金双轨制度有没有改进的方法', '62万热度'),
            _item(3, '65岁就可以领高龄补贴吗', '53万热度'),
            _item(4, '80至85岁养老金多少钱', '545热度'),
            _item(5, '你的养老金拖国家后腿了吗', '6632热度'),
          ],
        ));
  }

  _item(int num, String leftText, String rightText) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
      decoration: BoxDecoration(
          color: num < 4 ? Colors.deepOrangeAccent[100] : Colors.black12,
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.deepOrange.shade50.withOpacity(1.0),
              Colors.deepOrange.shade50.withOpacity(0.5),
              Colors.deepOrange.shade50.withOpacity(0.0),
            ],
          )),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '$num',
                      style: TextStyle(color: num<4?Colors.red:Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(leftText),
                  ],
                ),
                Text(
                  rightText,
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
