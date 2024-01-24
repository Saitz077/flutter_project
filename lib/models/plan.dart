class Plan {
  int? id;
  String? baslik;
  String? aciklama;
  String? kategori;
  DateTime? baslangicTarih;
  DateTime? bitisTarih;
  bool? bitirme;
  int? kategoriId;
  String? kategoriRenk;

  Map<String, dynamic> planMap() {
    var mapping = Map<String, dynamic>();
    mapping["id"] = id;
    mapping["baslik"] = baslik;
    mapping["aciklama"] = aciklama;
    mapping["kategori"] = kategori;
    mapping["baslangicTarih"] = baslangicTarih?.millisecondsSinceEpoch;
    mapping["bitisTarih"] = bitisTarih?.millisecondsSinceEpoch;
    mapping["bitirme"] = bitirme == true ? 1 : 0;
    mapping["kategoriId"] = kategoriId;
    mapping["kategoriRenk"] = kategoriRenk;

    return mapping;
  }
}

