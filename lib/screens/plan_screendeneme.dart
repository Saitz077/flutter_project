import 'package:flutter/material.dart';
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
  var _gorevBaslangicTarihController = TextEditingController();
  var _gorevBitisTarihController = TextEditingController();
  var _secilenDeger;
  var _kategoriler = <DropdownMenuItem<String>>[];
  DateTime _baslangicTarih = DateTime.now();
  DateTime? _bitisTarih;

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


  _seciliGorevTarih(BuildContext context, String tarihTipi) async {
    var secilenTarih = await showDatePicker(
      context: context,
      initialDate: tarihTipi == "baslangic" ? _baslangicTarih : _bitisTarih ?? _baslangicTarih,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );


    if (secilenTarih != null) {
      setState(() {
        if (tarihTipi == "baslangic") {
          _baslangicTarih = secilenTarih;
          _gorevBaslangicTarihController.text = DateFormat("dd.MM.yyyy").format(secilenTarih);
        } else {
          _bitisTarih = secilenTarih;
          _gorevBitisTarihController.text = DateFormat("dd.MM.yyyy").format(secilenTarih);
        }
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
              labelText: "Başlık",
              hintText: "Görev Başlığı Giriniz",
            ),
          ),
          TextField(
            controller: _gorevAciklamaController,
            decoration: InputDecoration(
              labelText: "Açıklama",
              hintText: "Görev Açıklaması Giriniz",
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _gorevBaslangicTarihController,
                  decoration: InputDecoration(
                    labelText: "Başlangıç Tarihi",
                    hintText: "Tarih Seçiniz",
                    prefixIcon: InkWell(
                      onTap: () {
                        _seciliGorevTarih(context, "baslangic");
                      },
                      child: Icon(Icons.calendar_today),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _gorevBitisTarihController,
                  decoration: InputDecoration(
                    labelText: "Bitiş Tarihi",
                    hintText: "Tarih Seçiniz",
                    prefixIcon: InkWell(
                      onTap: () {
                        _seciliGorevTarih(context, "bitis");
                      },
                      child: Icon(Icons.calendar_today),
                    ),
                  ),
                ),
              ),
            ],
          ),
          DropdownButtonFormField(
            value: _secilenDeger,
            items: _kategoriler,
            hint: Text("Kategori"),
            onChanged: (deger) {
              setState(() {
                _secilenDeger = deger;
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              if (_bitisTarih != null && _baslangicTarih.isAfter(_bitisTarih!)) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Uyarı"),
                    content: Text("Başlangıç tarihi, bitiş tarihinden sonra olamaz."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Tamam"),
                      ),
                    ],
                  ),
                );
                return;
              }

              var gorevNesnesi = Plan();
              gorevNesnesi.baslik = _gorevBaslikController.text;
              gorevNesnesi.aciklama = _gorevAciklamaController.text;
              gorevNesnesi.kategori = _secilenDeger.toString();
              gorevNesnesi.baslangicTarih = _baslangicTarih;
              gorevNesnesi.bitisTarih = _bitisTarih;

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
}