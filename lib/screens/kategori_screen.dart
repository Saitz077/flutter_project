
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../models/kategori.dart';
import '../service/kategori_service.dart';
import 'anaekran_deneme.dart';
import 'anasayfa_screen.dart';
class KategorilerEkran extends StatefulWidget {
  @override
  State<KategorilerEkran> createState() => _KategorilerEkranState();
}

class _KategorilerEkranState extends State<KategorilerEkran> {
  var _kategoriAdiController = TextEditingController();
  var _kategoriAciklamaController = TextEditingController();

  Color _selectedColor = Colors.blue;

  var _kategori = Kategori();
  var _kategoriServisi = KategoriServisi();

  var kategori;

  List<Kategori> _kategoriListesi = [];

  var _duzenleKategoriAdiController = TextEditingController();
  var _duzenleKategoriAciklamaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tumKategorileriGetir();
  }

  final GlobalKey<ScaffoldMessengerState> _anahtar =
  GlobalKey<ScaffoldMessengerState>();

  tumKategorileriGetir() async {
    _kategoriListesi = [];
    var kategoriler = await _kategoriServisi.kategorileriOku();
    kategoriler?.forEach((kategori) {
      setState(() {
        var kategoriModel = Kategori();
        kategoriModel.isim = kategori["isim"];
        kategoriModel.aciklama = kategori["aciklama"];
        kategoriModel.id = kategori["id"];
        kategoriModel.renk=kategori["renk"];
        _kategoriListesi.add(kategoriModel);
      });
    });
  }

  _kategoriDuzenle(BuildContext context, kategoriId) async {
    kategori = await _kategoriServisi.kategoriIdIleOku(kategoriId);
    setState(() {
      _duzenleKategoriAdiController.text = kategori[0]["isim"] ?? "isimsiz";
      _duzenleKategoriAciklamaController.text = kategori[0]["aciklama"] ?? "aciklama yok";
    });
    _duzenleFormDialog(context);
  }

  _formDialogGoster(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (param) {
        return AlertDialog(
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text("İptal"),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              onPressed: () async {
                _kategori.isim = _kategoriAdiController.text;
                _kategori.aciklama = _kategoriAciklamaController.text;
                _kategori.renk = '#${_selectedColor.value.toRadixString(16)}';

                var sonuc = await _kategoriServisi.kategoriKaydet(_kategori);
                if (sonuc != null && sonuc > 0) {
                  print(sonuc);
                  Navigator.pop(context);
                  tumKategorileriGetir();
                }
              },
              child: Text("Kaydet"),
            )
          ],
          title: Text("Kategori Formu"),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _kategoriAdiController,
                  decoration: InputDecoration(
                    hintText: "Bir kategori yazın",
                    labelText: "Kategori",
                  ),
                ),
                TextField(
                  controller: _kategoriAciklamaController,
                  decoration: InputDecoration(
                    hintText: "Bir açıklama yazın",
                    labelText: "Açıklama",
                  ),
                ),
                SizedBox(height: 16),
                // Renk seçimi için IconButton
                IconButton(
                  icon: Icon(Icons.color_lens),
                  onPressed: () {
                    _showColorPicker(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

// Renk seçimi için metod
  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Renk Seçimi'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _selectedColor,
              onColorChanged: (Color color) {
                setState(() => _selectedColor = color);
              },
              colorPickerWidth: 300.0,
              pickerAreaHeightPercent: 0.7,
              enableAlpha: true,
              displayThumbColor: true,
              showLabel: true,
              paletteType: PaletteType.hsv,
              pickerAreaBorderRadius: const BorderRadius.only(
                topLeft: const Radius.circular(2.0),
                topRight: const Radius.circular(2.0),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tamam'),
            ),
          ],
        );
      },
    );
  }

  _duzenleFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              TextButton(
                  style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all(Colors.red)),
                  onPressed: () => Navigator.pop(context),
                  child: Text("İptal")),
              TextButton(
                style: ButtonStyle(
                    foregroundColor:
                    MaterialStateProperty.all(Colors.blue)),
                onPressed: () async {
                  _kategori.id = kategori[0]["id"];
                  _kategori.isim = _duzenleKategoriAdiController.text;
                  _kategori.aciklama =
                      _duzenleKategoriAciklamaController.text;

                  var sonuc = await _kategoriServisi.kategoriGuncelle(_kategori);
                  if (sonuc != null && sonuc > 0) {
                    Navigator.pop(context);
                    tumKategorileriGetir();
                    _basariSnackBarGoster(Text("Güncellendi"));
                  }
                },
                child: Text("Güncelle"),
              )
            ],
            title: Text("Kategoriyi Düzenle Formu"),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _duzenleKategoriAdiController,
                    decoration: InputDecoration(
                        hintText: "Bir kategori yazın",
                        labelText: "Kategori"),
                  ),
                  TextField(
                    controller: _duzenleKategoriAciklamaController,
                    decoration: InputDecoration(
                        hintText: "Bir açıklama yazın",
                        labelText: "Açıklama"),
                  )
                ],
              ),
            ),
          );
        });
  }

  _silmeDialogGoster(BuildContext context, kategoriId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              TextButton(
                  style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all(Colors.green)),
                  onPressed: () => Navigator.pop(context),
                  child: Text("İptal")),
              TextButton(
                style: ButtonStyle(
                    foregroundColor:
                    MaterialStateProperty.all(Colors.red)),
                onPressed: () async {
                  var sonuc =
                  await _kategoriServisi.kategoriSil(kategoriId);
                  if (sonuc != null && sonuc > 0) {
                    Navigator.pop(context);
                    tumKategorileriGetir();
                    _basariSnackBarGoster(Text("Silindi"));
                  }
                },
                child: Text("Sil"),
              )
            ],
            title: Text(
                "Bu kategoriyi silmek istediğinizden emin misiniz?"),
          );
        });
  }

  _basariSnackBarGoster(message) {
    var _snackBar = SnackBar(content: message);
    _anahtar.currentState?.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _anahtar,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    MyHomePage())); // Geri gitmek için yapılacak işlemler
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Kategoriler"),
      ),
      body: ListView.builder(

          itemCount: _kategoriListesi.length,
          itemBuilder: (context, index) {
            Color kategoriRenk = _kategoriListesi[index].renk != null
                ? Color(int.parse(_kategoriListesi[index].renk!.substring(1), radix: 16))
                : Colors.blue;
            return ListTile(
              title: Text(_kategoriListesi[index].isim!),
              subtitle: Text(_kategoriListesi[index].aciklama!),
              tileColor: kategoriRenk,
              onTap: () {
                _kategoriDuzenle(context, _kategoriListesi[index].id);
              },
              onLongPress: () {
                _silmeDialogGoster(
                    context, _kategoriListesi[index].id);
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _formDialogGoster(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

