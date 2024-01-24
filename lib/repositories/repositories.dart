import 'package:sqflite/sqflite.dart';

import 'database_connection.dart';

class Repository {
  DatabaseConnection? _veritabaniBaglantisi;

  Repository() {
    _veritabaniBaglantisi = DatabaseConnection();
  }

  static Database? _veritabani;

 Future<List<Map<String, dynamic>>?> getTodosByCategory(String kategori) async {
    final Database? db = await _veritabaniBaglantisi?.veritabaniAyarla();

    return await db?.rawQuery('''
    SELECT * FROM todos
    JOIN categories ON todos.categoryId = categories.id
    WHERE categories.isim = '$kategori'
  ''');
  }
  Future<List<Map<String, dynamic>>?> kategoriIdIleOku(String tablo, int itemId) async {
    var db = await veritabani;

    if (db != null) {
      var result = await db.query(tablo, where: "id=?", whereArgs: [itemId]);
      return result;
    } else {
      // Veritabanı bağlantısı başarısız olduğunda uygun bir hata durumu yönetimi yapabilirsiniz.
      print('Hata: Veritabanı bağlantısı oluşturulamadı.');
      return null;
    }
  }


  Future<Database?> get veritabani async {
    if (_veritabani != null) return _veritabani;
    _veritabani = await _veritabaniBaglantisi?.veritabaniAyarla();
    return _veritabani;
  }

  Future<int?> veriEkle(String tablo, Map<String, dynamic> veri) async {
    var baglanti = await veritabani;
    return await baglanti?.insert(tablo, veri);
  }

  Future<List<Map<String, dynamic>>?> veriOku(String tablo) async {
    var baglanti = await veritabani;
    return await baglanti?.query(tablo);
  }

  Future<List<Map<String, dynamic>>?> veriOkuIdIle(String tablo, int itemId) async {
    var baglanti = await veritabani;
    return await baglanti?.query("todos", where: "id=?", whereArgs: [itemId]);
  }


  Future<int?> veriGuncelle(String tablo, Map<String, dynamic> veri) async {
    var baglanti = await veritabani;
    return await baglanti?.update(tablo, veri, where: "id=?", whereArgs: [veri["id"]]);
  }

  Future<int?> veriSil(String tablo, int? itemId) async {
    var baglanti = await veritabani;
    return await baglanti?.delete(tablo, where: "id=?", whereArgs: [itemId]);
  }


  Future<List<Map<String, dynamic>>?> veriOkuSutunAdiIle(String tablo, String sutunAdi, dynamic sutunDegeri) async {
    var baglanti = await veritabani;
    return await baglanti?.query(tablo, where: "$sutunAdi=?", whereArgs: [sutunDegeri]);
  }
}
