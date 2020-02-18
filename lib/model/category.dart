class Category{
  String title;
  int cid;

  Category({this.cid, this.title});

  Map<String, dynamic> toMap() => {
    "cid":cid,
    "title":title,
  };

  Category.fromMap(Map<String, dynamic> map){
    this.cid = map['cid'];
    this.title = map['title'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return "cid:$cid\ntitle:$title";
  }
}

