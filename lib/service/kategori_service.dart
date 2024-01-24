import 'package:planuygulamasi/repositories/repositories.dart';
import 'package:sqflite/sqflite.dart';
import 'uygulama_service.dart';

import '../models/kategori.dart';

class KategoriServisi {
  Repository? _depo;

  KategoriServisi() {
    _depo = Repository();
  }



  // Kategori oluştur
  Future<int?> kategoriOlustur(Kategori kategori) async {
    return await _depo?.veriEkle("categories", kategori.kategoriMap());
  }
  //Kategori kaydet
  Future<int?> kategoriKaydet(Kategori kategori) async {
    return await _depo?.veriEkle("categories", kategori.kategoriMap());
  }

  // Tüm kategorileri oku
  Future<List<Map<String, dynamic>>?> kategorileriOku() async {
    return await _depo?.veriOku("categories");
  }

  // Belirli bir kategori id'sine göre veriyi oku
  Future<List<Map<String, dynamic>>?> kategoriIdIleOku(int kategoriId) async {
    return await _depo?.veriOkuIdIle("categories", kategoriId);
  }

  // Veriyi güncelle
  Future<int?> kategoriGuncelle(Kategori kategori) async {
    return await _depo?.veriGuncelle("categories", kategori.kategoriMap());
  }

  // Veriyi sil
  Future<int?> kategoriSil(int? kategoriId) async {


    return await _depo?.veriSil("categories", kategoriId);
  }
}