class NewsModel {
  int? code;
  String? msg;
  Result? result;

  NewsModel({this.code, this.msg, this.result});

  NewsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  int? curpage;
  int? allnum;
  List<News>? list;

  Result({this.curpage, this.allnum, this.list});

  Result.fromJson(Map<String, dynamic> json) {
    curpage = json['curpage'];
    allnum = json['allnum'];
    if (json['list'] != null) {
      list = <News>[];
      json['list'].forEach((v) {
        list!.add(new News.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['curpage'] = this.curpage;
    data['allnum'] = this.allnum;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class News {
  String? id;
  String? ctime;
  String? title;
  String? description;
  String? picUrl;
  String? url;
  String? source;

  News(
      {this.id,
        this.ctime,
        this.title,
        this.description,
        this.picUrl,
        this.url,
        this.source});

  News.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ctime = json['ctime'];
    title = json['title'];
    description = json['description'];
    picUrl = json['picUrl'];
    url = json['url'];
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ctime'] = this.ctime;
    data['title'] = this.title;
    data['description'] = this.description;
    data['picUrl'] = this.picUrl;
    data['url'] = this.url;
    data['source'] = this.source;
    return data;
  }
}
