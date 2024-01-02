import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toutiao/navigator/tab_navigator_publish.dart';
import 'package:flutter_toutiao/pages/publish_page.dart';
import 'package:flutter_toutiao/utils/navigator_util.dart';

enum SearchBarType { home, normal }

class SearchBar_ extends StatefulWidget {
  final bool enabled;
  final bool hideLeft;
  final bool hideRight;
  final SearchBarType searchBarType;
  final String hint;
  final String defaultText;
  final void Function()? leafButtonClick;
  final void Function()? rightButtonClick;
  final void Function()? speakClick;
  final void Function()? inputBoxClick;
  final void Function(String s)? onChanged;

  const SearchBar_(
      {super.key,
      this.hideRight = false,
      this.enabled = true,
      this.hideLeft = false,
      this.searchBarType = SearchBarType.normal,
      this.hint = '',
      this.defaultText = '',
      this.leafButtonClick = null,
      this.rightButtonClick,
      this.speakClick,
      this.inputBoxClick,
      this.onChanged});

  @override
  State<SearchBar_> createState() => _SearchBar_State();
}

class _SearchBar_State extends State<SearchBar_> {
  bool showClear = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    if (widget.defaultText != null) {
      setState(() {
        _controller.text = widget.defaultText;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal
        ? _getNormalSearch()
        : _getHomeSearch();
  }

  _getNormalSearch() {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          _wrapTap(
              Container(
                padding: EdgeInsets.only(left: 5),
                child: widget.hideLeft ?? false
                    ? null
                    : Icon(
                        Icons.arrow_back_ios,
                        color: Colors.grey,
                        size: 26,
                      ),
              ),
              widget.leafButtonClick),
          Expanded(
            flex: 1,
            child: _inputBox(),
          ),
          _wrapTap(
              widget.hideRight
                  ? Container()
                  : Container(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Text(
                        '搜索',
                        style: TextStyle(color: Colors.red, fontSize: 17),
                      )),
              widget.rightButtonClick),
        ],
      ),
    );
  }

  _getHomeSearch() {
    return Container(
      height: 85,
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: Colors.red,
      ),
      child: Row(
        children: [
          _wrapTap(
              Container(
                  padding: EdgeInsets.fromLTRB(6, 5, 5, 5),
                  child: Row(
                    children: [
                      Icon(
                        Icons.card_giftcard,
                        color: _homeFontColor(),
                        size: 22,
                      )
                    ],
                  )),
              widget.leafButtonClick),
          Expanded(
            flex: 1,
            child: _inputBox(),
          ),
          _wrapTap(
              Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: GestureDetector(
                    onTap: (){
                      NavigatorUtil.push(context, TabBarNavigator());
                    },
                    child: Icon(
                      Icons.add_circle,
                      color: _homeFontColor(),
                      size: 26,
                    ),
                  )
              ),
              widget.rightButtonClick),
        ],
      ),
    );
  }

  _inputBox() {
    Color inputBoxColor = widget.searchBarType == SearchBarType.normal
        ? Colors.black12
        : Colors.white;

    return Container(
      height: 30,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
          color: inputBoxColor, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Icon(Icons.search, size: 20, color: Colors.black54),
          Expanded(
              child: widget.searchBarType == SearchBarType.normal
                  ? CupertinoTextField(
                      controller: _controller,
                      onChanged: _onChanged,
                      // autofocus: true,
                      cursorHeight: 18,
                      cursorColor: Colors.blue,
                      cursorWidth: 1,
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      placeholder: widget.hint ?? '',
                      placeholderStyle: TextStyle(fontSize: 13),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                        fontWeight: FontWeight.w300,
                      ),
                      decoration: BoxDecoration(color: Colors.transparent),
                      //     hintStyle: TextStyle(fontSize: 15)),
                    )
                  : _wrapTap(
                      Text(
                        widget.defaultText,
                        style: TextStyle(fontSize: 13, color: Colors.black87),
                      ),
                      widget.inputBoxClick)),
          !showClear
              ? Container()
              : _wrapTap(
                  Icon(
                    Icons.clear,
                    size: 22,
                    color: Colors.grey,
                  ), () {
                  setState(() {
                    _controller.clear();
                  });
                  _onChanged('');
                })
        ],
      ),
    );
  }

  _wrapTap(Widget child, void Function()? callback) {
    return GestureDetector(
      onTap: () {
        if (callback != null) callback();
      },
      child: child,
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
    if (widget.onChanged != null) {
      widget.onChanged!(text);
    }
  }

  _homeFontColor() {
    return Colors.white;
  }
}
