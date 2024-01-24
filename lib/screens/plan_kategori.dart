import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planuygulamasi/models/plan.dart';
import 'package:planuygulamasi/service/uygulama_service.dart';

class KategoriyeGoreGorevler extends StatefulWidget {
  late final String kategori;

  KategoriyeGoreGorevler({required this.kategori});

  @override
  State<KategoriyeGoreGorevler> createState() =>
      _KategoriyeGoreGorevlerState();
}

class _KategoriyeGoreGorevlerState extends State<KategoriyeGoreGorevler> {
  List<Plan> _gorevListesi = [];
  PlanServisi? _gorevServisi = PlanServisi();

  @override
  void initState() {
    super.initState();
    KategorilereGoreGorevleriGetir();
  }

  KategorilereGoreGorevleriGetir() async {
    var gorevler = await _gorevServisi?.KategoriyeGorePlanlariOku(widget.kategori);
    gorevler?.forEach((gorev) {
      setState(() {
        var model = Plan();
        model.baslik = gorev['baslik'];
        model.aciklama = gorev['aciklama'];
        model.baslangicTarih = gorev['baslangicTarih'];

        _gorevListesi.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Görevler - ${widget.kategori}"),
      ),
      body: ListView.builder(
        itemCount: _gorevListesi.length,
        itemBuilder: (context, index) {
          var gorev = _gorevListesi[index];
          return ListTile(
            title: Text(gorev.baslik ?? ""),
            subtitle: Text(gorev.aciklama ?? ""),
            // Diğer görev özelliklerini isteğe bağlı olarak göster
          );
        },
      ),
    );
  }
}