import 'package:planuygulamasi/repositories/repositories.dart';

import '../models/plan.dart';



class PlanServisi {
  Repository? _depo;



  PlanServisi() {
    _depo = Repository();

  }


  // Planı kaydet
  Future<int?> planKaydet(Plan plan) async {
      var kategori = await _depo?.kategoriIdIleOku("todos",plan.kategoriId!);
      if (kategori != null && kategori.isNotEmpty) {
        plan.kategoriRenk = kategori[0]["renk"];
        return await _depo?.veriEkle("todos", plan.planMap());

  }}

  //id ile planları oku
  Future<List<Map<String, dynamic>>?> planIdIleOku(int? id) async {
    return await _depo?.veriOkuIdIle("todos", id!);
  }

  Future<List<Map<String, dynamic>>?> KategoriyeGorePlanlariOku(String kategori) async {
    return await _depo?.getTodosByCategory(kategori);
  }



  // Tüm planları oku
  Future<List<Map<String, dynamic>>?> planOku() async {
    return await _depo!.veriOku("todos"); // plans tablosundan okunduğu varsayıldı
  }

  // Kategoriye göre planları oku
  Future<List<Map<String, dynamic>>?> kategoriyeGorePlanlariOku(String kategori) async {
    return await _depo?.veriOkuSutunAdiIle("todos", "kategori", kategori);
  }
}