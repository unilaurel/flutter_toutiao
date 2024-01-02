import 'package:flutter/material.dart';

import '../widget/search_bar.dart';


// const URL= 'https: //m.ctrip.com/restapi/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';
const URL = 'https://m.ctrip.com/html5/';

class SearchPage extends StatefulWidget {
  const SearchPage(
      {super.key,
      this.hideLeft = false,
      this.searchUrl = URL,
      this.keyword = '',
      this.hint = ''});

  final bool hideLeft;
  final String searchUrl;
  final String keyword;
  final String hint;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late String keyword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        _appBar(),
      ],
    ));
  }

  _onTextChange(String text) {
    setState(() {
      keyword = text;
    });
      return;
    }

  _appBar() {
    return Column(
      children: [
         Container(
          padding: EdgeInsets.only(top: 30),
          height: 80,
          child: SearchBar_(
              hideLeft: widget.hideLeft,
              defaultText: widget.keyword,
              hint: widget.hint,
              leafButtonClick: () {
                Navigator.pop(context);
              },
              onChanged: _onTextChange),
        ),


      ],
    );
  }



}
