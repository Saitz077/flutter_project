class Kategori {
  int? id;
  String? isim;
  String? aciklama;
  String? renk;

  Kategori({this.id, this.isim, this.aciklama, this.renk});

  Map<String, dynamic> kategoriMap() {
    var mapping = Map<String, dynamic>();
    mapping["id"] = id;
    mapping["isim"] = isim;
    mapping["aciklama"] = aciklama;
    mapping["renk"] = renk;

    return mapping;
  }

  factory Kategori.fromMap(Map<String, dynamic> map) {
    return Kategori(
      id: map["id"],
      isim: map["isim"],
      aciklama: map["aciklama"],
      renk: map["renk"],
    );
  }
}