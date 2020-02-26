class System {
  int sid;
  String title, code;
  DateTime data;

  System.fromMap(Map<String, dynamic> systemMap){
    this.sid = systemMap['sid'];
    this.title = systemMap['title'];
    this.code = systemMap['code'];
    this.data = DateTime.parse(systemMap['data']);
  }

  Map<String, dynamic> toMap(){
    return {
      'sid':this.sid,
      'title':this.title,
      'code':this.code,
      'data':this.toString()
    };
  }
}