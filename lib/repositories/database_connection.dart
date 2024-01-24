import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  Future<Database?> veritabaniAyarla() async {
    var uygulamaDizini = await getApplicationDocumentsDirectory();
    var yol = join(uygulamaDizini.path, "db_planuygulamasi1_sqflite");
    var veritabani = await openDatabase(yol, version: 1, onCreate: _veritabaniOlustur);
    return veritabani;
  }

  Future<void> _veritabaniOlustur(Database veritabani, int versiyon) async {
    await veritabani.execute("CREATE TABLE categories(id INTEGER PRIMARY KEY,isim TEXT,aciklama TEXT,renk TEXT)");

    await veritabani.execute("CREATE TABLE todos (id INTEGER PRIMARY KEY, baslik TEXT, aciklama TEXT, kategori TEXT, baslangicTarih INTEGER, bitisTarih INTEGER, bitirme INTEGER, kategoriId INTEGER, FOREIGN KEY(kategoriId) REFERENCES categories(id) ON DELETE NO ACTION)");

  }
}