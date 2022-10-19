class Not {
  int? notID;
  int? kategoriId;
  String? notBaslik;
  String? notIcerik;
  String? lastday;


  Not( this.kategoriId, this.lastday, this.notBaslik,
      this.notIcerik);

  Not.withId( this.kategoriId, this.lastday, this.notBaslik,
      this.notIcerik, this.notID);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["notID"] = notID;
    map["notBaslik"] = notBaslik;
    map["kategoriId"] = kategoriId;
    map["notIcerik"] = notIcerik;
    map["lastday"] = lastday;

    return map;
  }

  Not.fromMap(Map<dynamic, dynamic> map) {
    this.notID = map["notID"];
    this.notBaslik = map["notBaslik"];
    this.kategoriId = map["kategoriId"];
    this.notIcerik = map["notIcerik"];
    this.lastday = map["lastday"];
 
  }
}
