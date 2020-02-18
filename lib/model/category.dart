class Category{
  String title;
  int id;

  Category({this.id, this.title});

  Map<String, dynamic> toMap() => {
    "id":id,
    "title":title,
  };

  Category.fromMap(Map<String, dynamic> map){
    this.id = map['id'];
    this.title = map['title'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return "id:$id\ntitle:$title";
  }
}

