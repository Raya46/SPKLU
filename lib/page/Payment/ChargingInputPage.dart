// ignore_for_file: avoid_unnecessary_containers

import 'package:flutetr_spklu/NavigationPage.dart';
import 'package:flutetr_spklu/global/color.dart';
import 'package:flutetr_spklu/page/Feature/HistoryPage.dart';
import 'package:flutetr_spklu/page/Feature/LocationPage.dart';
import 'package:flutetr_spklu/page/Main/DashboardPage.dart';
import 'package:flutetr_spklu/page/Payment/ConfirmPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';

class ChargingInputPage extends StatelessWidget {
  const ChargingInputPage({
    Key? key,
    required this.scanBarcode,
  }) : super(key: key);

  final String scanBarcode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '$scanBarcode ',
      home: ChargingInputScreen(scanBarcode: scanBarcode),
    );
  }
}

class ChargingInputScreen extends StatefulWidget {
  const ChargingInputScreen({
    Key? key,
    required this.scanBarcode,
  }) : super(key: key);

  final String scanBarcode;

  @override
  State<ChargingInputScreen> createState() => _ChargingInputScreenState();
}

class _ChargingInputScreenState extends State<ChargingInputScreen> {
  final nominalKWH = TextEditingController();
  String estimasiBiaya = "0";
  String scanBarcode = '';

  @override
  void initState() {
    super.initState();
    nominalKWH.addListener(() {
      setState(() {
        if (nominalKWH.text.isEmpty) {
          estimasiBiaya = "0";
        } else {
          estimasiBiaya = (int.parse(nominalKWH.text) * 2475)
              .toStringAsFixed(0)
              .replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final height = constraints.maxHeight;
      return Scaffold(
        appBar: appbarApk(context),
        body: BuildBody(
          width: width,
          height: height,
          nominalKWH: nominalKWH,
          estimasiBiaya: estimasiBiaya,
          scanBarcode: scanBarcode,
        ),
      );
    });
  }

  AppBar appbarApk(BuildContext context) {
    return AppBar(
      leading: BackButton(
        color: const Color.fromRGBO(247, 247, 248, 1),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NavigationPage(),
              ));
        },
      ),
      elevation: 1,
      bottomOpacity: 1,
      toolbarHeight: 70,
      centerTitle: true,
      backgroundColor: bluee,
      title: Text(
        "Charging Input",
        style: GoogleFonts.inter(
            color: Color.fromRGBO(247, 247, 248, 1),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

class BuildBody extends StatelessWidget {
  const BuildBody({
    Key? key,
    required this.width,
    required this.scanBarcode,
    required this.height,
    required this.nominalKWH,
    required this.estimasiBiaya,
  }) : super(key: key);

  final String scanBarcode;
  final double width;
  final double height;
  final TextEditingController nominalKWH;
  final String estimasiBiaya;
  // final String scanBarcode;

  @override
  Widget build(BuildContext context) {
    final Color black = Color.fromRGBO(55, 63, 71, 1);
    final Color black70 = Color.fromRGBO(55, 63, 71, 0.7);
    final Color white = Color.fromRGBO(247, 247, 248, 1);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // ignore: avoid_unnecessary_containers
        Container(
          child: Column(
            children: [
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: width * 0.05, top: 20.0),
                      child: Text(
                        'SPKLU Location',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ignore: avoid_unnecessary_containers
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: width * 0.05, top: 5.0),
                      child: Container(
                        height: height * 0.058,
                        width: height * 0.058,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 125, 251, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: height * 0.016,
                            ),
                            const Icon(
                              Icons.map_sharp,
                              size: 20,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: width * 0.02, top: 5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SPKLU Location',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromRGBO(55, 63, 71, 1),
                              ),
                            ),
                            Text(
                              'Jl. Cikunir Raya No.689, RT.002/RW.015, Jaka Mulya, Kec. Bekasi Sel., Kota Bks, Jawa Barat 17146',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromRGBO(55, 63, 71, 0.7),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: width * 0.05, top: 20.0),
                      child: Text(
                        'Charging Station',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: width * 0.05, top: 5.0),
                      child: Container(
                        height: height * 0.058,
                        width: height * 0.058,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 125, 251, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: height * 0.016,
                            ),
                            const Icon(
                              Icons.charging_station_rounded,
                              size: 20,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: width * 0.02, top: 5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Intek DC Cikunir Charger',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromRGBO(55, 63, 71, 1),
                              ),
                            ),
                            Text(
                              'Plug: Ultra Charger - 180 kWh',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromRGBO(55, 63, 71, 0.7),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: width * 0.05, top: height * 0.02),
                      child: Text(
                        'Nominal kWh',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: black),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        left: width * 0.05,
                        top: height * 0.01,
                      ),
                      child: Text(
                        'Input the number of kWh you want to buy below',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: black70,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.01, horizontal: width * 0.05),
                child: TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding: const EdgeInsets.only(left: 20.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        5.0,
                      ),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    suffix: Container(
                      margin: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        'kWh',
                        style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  controller: nominalKWH,
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        left: width * 0.05,
                        top: height * 0.01,
                      ),
                      child: Text(
                        'Estimated Cost',
                        style: GoogleFonts.inter(
                          color: black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: width * 0.05, top: height * 0.01),
                      child: Text(
                        'Rp $estimasiBiaya',
                        style: TextStyle(
                          fontSize: 28,
                          color: black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(15.0),
          height: height * 0.065,
          width: width,
          child: Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                primary: const Color.fromRGBO(0, 125, 251, 1),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmPage(estimasiBiaya: estimasiBiaya),
                    ));
              },
              child: Text('Next',
                  style: GoogleFonts.inter(
                      fontSize: 16, color: white, fontWeight: FontWeight.bold)),
            ),
          ),
        )
      ],
    );
  }
}
