import 'package:flutter/material.dart';
import 'package:planuygulamasi/models/plan.dart';
import 'package:planuygulamasi/service/uygulama_service.dart';
import 'package:planuygulamasi/repositories/repositories.dart';

class PlanDetayScreen extends StatefulWidget {
  final int? planId;

  PlanDetayScreen({this.planId});

  @override
  _PlanDetayScreenState createState() => _PlanDetayScreenState();
}

class _PlanDetayScreenState extends State<PlanDetayScreen> {
  var _planBaslikController = TextEditingController();
  var _planAciklamaController = TextEditingController();
  var _planTarihController = TextEditingController();

  var _plan = Plan();
  var _planServisi = PlanServisi();

  @override
  void initState() {
    super.initState();
    _planGetir();
  }

  _planGetir() async {
    var _plan = await _planServisi.planIdIleOku(widget.planId);
    setState(() {
      _planBaslikController.text = _plan![0]["baslik"] ?? "Başlık Yok";
      _planAciklamaController.text = _plan[0]["aciklama"] ?? "Açıklama Yok";
      _planTarihController.text =
      _plan[0]["baslangicTarih"] != null ? _plan[0]["baslangicTarih"].toString() : "Tarih Yok";
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plan Detay"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Başlık:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(_planBaslikController.text),
            SizedBox(height: 16),
            Text(
              "Açıklama:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(_planAciklamaController.text),
            SizedBox(height: 16),
            Text(
              "Tarih:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(_planTarihController.text),
          ],
        ),
      ),
    );
  }
}