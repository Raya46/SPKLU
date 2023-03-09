import 'package:flutetr_spklu/page/Feature/DetailPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:google_fonts/google_fonts.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

final Color blue = Color.fromRGBO(0, 125, 251, 1);
    final Color black = Color.fromRGBO(55, 63, 71, 1);
    final Color black70 = Color.fromRGBO(55, 63, 71, 0.7);
    final Color white = Color.fromRGBO(247, 247, 248, 1);
    final Color bg = Color.fromRGBO(240, 239, 244, 1);
    final Color text = Color.fromRGBO(48, 48, 244, 1);

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        leading: const BackButton(color: Color.fromRGBO(247, 247, 248, 1)),
        elevation: 1,
        bottomOpacity: 1,
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: blue,
        title: const Text(
          "History Transaksi",
          style: TextStyle(color: Color.fromRGBO(247, 247, 248, 1)),
        ),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "14 Notification",
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      children: [
                        widgetHistory(context),
                      ],
                    ))
              ]),
        ),
      ),
    );
  }
}

Widget widgetHistory(context) => Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Text(
                "15 Januari 2023",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.all(const Radius.circular(10)),
          child: Container(
            height: 60,
            color: white,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Container(
                  height: 60,
                  width: 60,
                  color: blue,
                  child: Icon(
                    Icons.electric_bolt,
                    color: white,
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailPage(nominalKwh: '',)),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.35,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Top Up kWh"), Text("-Rp 90.312")],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
