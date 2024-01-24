

import 'package:flutter/material.dart';
import 'package:planuygulamasi/screens/plan_screen.dart';
import 'package:planuygulamasi/screens/plan_screendeneme.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/kategori.dart';
import '../models/plan.dart';
import '../yardımcı/drawer_navigation.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Bu değişkenleri uygun şekilde tanımlamayı unutmayın
  List<Kategori> _kategoriListesi = []; // Kategorilerin listesi
  String _selectedDeger = ""; // Seçili değer
  Map<DateTime, dynamic> dayColorMap = {}; // Gün renkleri

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anasayfa'),
      ),
      body: TableCalendar(
        calendarFormat: _calendarFormat,
        focusedDay: _focusedDay,
        firstDay: DateTime.utc(2023, 1, 1),
        lastDay: DateTime.utc(2028, 12, 31),
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
          ),
        ),
        selectedDayPredicate: (DateTime day) {

          if (_selectedDay != null) {
            var selectedCategory = _kategoriListesi.firstWhere(
                  (k) => k.isim == _selectedDeger,
              orElse: () => Kategori(renk: ""), // Eksik durumda bir Kategori nesnesi ekledim.
            );

            var kategoriRenk = selectedCategory.renk;

            return isSameDay(day, _selectedDay!) &&
                (kategoriRenk != null && kategoriRenk.isNotEmpty)
                ? dayColorMap[day] == kategoriRenk
                : true;
          }
          return false;
        },

        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        calendarBuilders: CalendarBuilders(
          selectedBuilder: (context, date, _) {
            return Container(
              margin: const EdgeInsets.all(4.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                '${date.day}',
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ),
      drawer: DrawerNavigation(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PlanEkrani(),
          ));

          if (result != null && result is Plan) {
            setState(() {
              _selectedDay = result.baslangicTarih;
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
