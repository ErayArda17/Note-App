class Kategori {
  int? kategoriId;
  String? kategoriBaslik;
  Kategori(this.kategoriBaslik);
  Kategori.withId(this.kategoriId, this.kategoriBaslik);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["kategoriId"] = kategoriId;
    map["kategoriBaslik"] = kategoriBaslik;
    return map;
  }

  Kategori.fromMap(Map<String, dynamic> map) {
    this.kategoriId = map["kategoriId"];
    this.kategoriBaslik = map["kategoriBaslik"];
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Kategori Id: $kategoriId, Kategori Başlık: $kategoriBaslik";
  }
}
