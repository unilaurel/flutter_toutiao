import 'package:flutter/material.dart';
import 'package:flutter_toutiao/widget/search_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

List<String> CACHE_URLS = [
  'm.ctrip.com/',
  'm.ctrip.com/html5/',
  'm.ctrip.com/html5'
];

class WebViews extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  WebViews(
      {this.url = '',
      this.statusBarColor = '',
      this.title = '',
      this.hideAppBar = false,
      this.backForbid = false});

  @override
  State<WebViews> createState() => _WebViewsState();
}

class _WebViewsState extends State<WebViews> {
  late WebViewController _webViewController;
  bool exiting = false;

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }

    return Scaffold(
      body: Column(
        children: [
          _appBar(
              Color(int.parse('0xff' + statusBarColorStr)), backButtonColor),
          Expanded(
            child: WebView(
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onPageStarted: (String url) async {
                if (_isToMain(url) && !exiting) {
                  if (widget.backForbid) {
                    await _webViewController.loadUrl(widget.url);
                  } else {
                    Navigator.pop(context);
                    exiting = true;
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _isToMain(String url) {
    bool contain = false;
    for (final value in CACHE_URLS) {
      if (url?.endsWith(value) ?? false) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  Widget _appBar(Color? backgroundColor, Color? backButtonColor) {
  return AppBar(
    leading:
       Row(
        children: [
          Expanded(child: IconButton(onPressed: (){
            Navigator.pop(context);
          },icon: Icon(Icons.arrow_back_ios),),),

          Expanded(child: IconButton(onPressed: (){},icon: Icon(Icons.card_giftcard,color: Colors.red,),),)

        ],
      ),

    title:Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: SearchBar_(hideLeft: true,hideRight: true,defaultText: '搜你想看的',),
    ),
    actions: [
      Text('听',style: TextStyle(fontSize: 18),),
IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz))
    ],
    
  );

  }

}

