/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planuygulamasi/models/plan.dart';
import 'package:planuygulamasi/service/uygulama_service.dart';

import '../service/kategori_service.dart';

class PlanEkrani extends StatefulWidget {
  @override
  State<PlanEkrani> createState() => _GorevEkraniState();
}

class _GorevEkraniState extends State<PlanEkrani> {
  var _gorevBaslikController = TextEditingController();
  var _gorevAciklamaController = TextEditingController();
  var _gorevTarihController = TextEditingController();
  var _secilenDeger;
  var _kategoriler = <DropdownMenuItem<String>>[];
  DateTime _tarih = DateTime.now();

  @override
  void initState() {
    super.initState();
    _kategorileriYukle();
  }

  _kategorileriYukle() async {
    var _kategoriServisi = KategoriServisi();
    var kategoriler = await _kategoriServisi.kategorileriOku();
    kategoriler?.forEach((kategori) {
      setState(() {
        _kategoriler.add(DropdownMenuItem(
          child: Text(kategori["isim"] ?? "isim yok"),
          value: kategori["isim"],
        ));
      });
    });
  }

  _seciliGorevTarihi(BuildContext context) async {
    var _secilenTarih = await showDatePicker(
        context: context,
        initialDate: _tarih,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_secilenTarih != null) {
      setState(() {
        _tarih = _secilenTarih;
        _gorevTarihController.text =
            DateFormat("dd.MM.yyyy").format(_secilenTarih);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Görev Oluştur"),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _gorevBaslikController,
            decoration: InputDecoration(
                labelText: "Başlık", hintText: "Görev Başlığı Giriniz"),
          ),
          TextField(
            controller: _gorevAciklamaController,
            decoration: InputDecoration(
                labelText: "Açıklama",
                hintText: "Görev Açıklaması Giriniz"),
          ),
          TextField(
            controller: _gorevTarihController,
            decoration: InputDecoration(
                labelText: "Tarih",
                hintText: "Tarih Seçiniz",
                prefixIcon: InkWell(
                  onTap: () {
                    _seciliGorevTarihi(context);
                  },
                  child: Icon(Icons.calendar_today),
                )),
          ),
          DropdownButtonFormField(
              value: _secilenDeger,
              items: _kategoriler,
              hint: Text("Kategori"),
              onChanged: (deger) {
                setState(() {
                  _secilenDeger = deger;
                });
              }),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              var gorevNesnesi = Plan();
              gorevNesnesi.baslik = _gorevBaslikController.text;
              gorevNesnesi.aciklama = _gorevAciklamaController.text;
              gorevNesnesi.kategori = _secilenDeger.toString();
              gorevNesnesi.baslangicTarih = DateTime.parse(_gorevTarihController.text);

              var _gorevServisi = PlanServisi();
              var sonuc = await _gorevServisi.planKaydet(gorevNesnesi);

              print(sonuc);
            },
            child: Text("Kaydet"),
          )
        ],
      ),
    );
  }
}*/

