import 'package:flutter/material.dart';
import 'package:planuygulamasi/screens/anasayfa_screen.dart';
import 'package:planuygulamasi/screens/kategori_screen.dart';
import 'package:planuygulamasi/service/kategori_service.dart';


import '../screens/anaekran_deneme.dart';
import '../screens/plan_kategori.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  List<Widget> _kategoriListesi = [];
  KategoriServisi _kategoriServisi = KategoriServisi();

  @override
  initState() {
    super.initState();
    kategorileriAl();
  }

  kategorileriAl() async {
    var kategoriler = await _kategoriServisi.kategorileriOku();

    kategoriler?.forEach((kategori) {
      setState(() {
        _kategoriListesi.add(InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => KategoriyeGoreGorevler(kategori: kategori['isim']),
            ),
          ),
          child: ListTile(
            title: Text(kategori['isim']),
          ),
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Admin"),
              accountEmail: Text("admin@mail.com"),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Ana Sayfa"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ));
              },
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text("Kategoriler"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => KategorilerEkran(),
                ));
              },
            ),
            Divider(),
            Column(
              children: _kategoriListesi,
            )
          ],
        ),
      ),
    );
  }
}