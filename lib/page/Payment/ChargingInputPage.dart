import 'dart:convert';

import 'package:flutetr_spklu/NavigationPage.dart';
import 'package:flutetr_spklu/global/color.dart';
import 'package:flutetr_spklu/page/LoginPage/LoginPage.dart';
import 'package:flutetr_spklu/page/Payment/ConfirmPage.dart';
import 'package:flutetr_spklu/page/Payment/widget/alertPay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class ChargingInputPage extends StatelessWidget {
  const ChargingInputPage({
    Key? key,
    required this.qrCode,
  }) : super(key: key);
  final String qrCode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pengisian kWh',
      home: ChargingInputScreen(qrCode: qrCode),
    );
  }
}

class ChargingInputScreen extends StatefulWidget {
  const ChargingInputScreen({
    Key? key,
    required this.qrCode,
  }) : super(key: key);
  final String qrCode;

  @override
  State<ChargingInputScreen> createState() => _ChargingInputScreenState();
}

class _ChargingInputScreenState extends State<ChargingInputScreen> {
  late List lokasiCharger = [];
  late List dataTarif = [];
  final nominalKWH = TextEditingController();
  String estimasiBiaya = "0";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchLokasiCharger();
    _fetchDataTarif();
    nominalKWH.addListener(() {
      setState(() {
        if (nominalKWH.text.isEmpty) {
          estimasiBiaya = "0";
        } else {
          estimasiBiaya = ((int.parse(nominalKWH.text) *
                          int.parse(dataTarif[0]['tarif_perkwh']) +
                      int.parse(dataTarif[0]['tarif_ppj']) +
                      int.parse(dataTarif[0]['tarif_ppn']) +
                      int.parse(dataTarif[0]['tarif_admin'])) +
                  int.parse(dataTarif[0]['tarif_materai']))
              .toStringAsFixed(0)
              .replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.');
        }
      });
    });
  }

  Future<void> _fetchLokasiCharger() async {
    final prefs = await SharedPreferences.getInstance();
    final api_token = prefs.getString('api_token');
    final response = await http.get(Uri.parse(
        'http://spklu.solusi-rnd.tech/api/lokasi-charger?token=$api_token&qrcode=${widget.qrCode}'));
    if (response.statusCode == 200) {
      setState(() {
        lokasiCharger = jsonDecode(response.body);
        isLoading = true;
      });
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  Future<void> _fetchDataTarif() async {
    final prefs = await SharedPreferences.getInstance();
    final api_token = prefs.getString('api_token');
    final response = await http.get(Uri.parse(
        'http://spklu.solusi-rnd.tech/api/data-tarif?token=$api_token'));
    if (response.statusCode == 200) {
      setState(() {
        dataTarif = jsonDecode(response.body);
        isLoading = true;
      });
      print(dataTarif);
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final height = constraints.maxHeight;
      return Scaffold(
        appBar: appbarApk(context),
        body: Column(
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
                          padding:
                              EdgeInsets.only(left: width * 0.05, top: 20.0),
                          child: Text(
                            'Lokasi SPKLU',
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
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding:
                              EdgeInsets.only(left: width * 0.05, top: 5.0),
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
                            padding:
                                EdgeInsets.only(left: width * 0.02, top: 5.0),
                            // ignore: prefer_const_constructors
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                isLoading
                                    ? Text(
                                        '${lokasiCharger[0]['nama_lokasi']}',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      )
                                    : Shimmer.fromColors(
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          height: 15,
                                          width: 110,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[50]!),
                                        Divider(
                                  height: 4,
                                  color: Colors.transparent,
                                ),
                                isLoading
                                    ? Text(
                                        '${lokasiCharger[0]['alamat_lokasi']}',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : Shimmer.fromColors(
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          height: 15,
                                          width: 200,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[50]!)
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
                          padding:
                              EdgeInsets.only(left: width * 0.05, top: 20.0),
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
                          padding:
                              EdgeInsets.only(left: width * 0.05, top: 5.0),
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
                                  Icons.charging_station,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding:
                                EdgeInsets.only(left: width * 0.02, top: 5.0),
                            // ignore: prefer_const_constructors
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               isLoading
                                    ? Text(
                                        '${lokasiCharger[0]['nama_charger']}',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      )
                                    : Shimmer.fromColors(
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          height: 15,
                                          width: 110,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[50]!),
                                Divider(
                                  height: 4,
                                  color: Colors.transparent,
                                ),
                                isLoading
                                    ? Text(
                                        'Plug: ${lokasiCharger[0]['nama_pengisian']} - ${lokasiCharger[0]['max_kwh']} kW',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : Shimmer.fromColors(
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          height: 15,
                                          width: 130,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[50]!)
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
                          child: const Text(
                            'Nominal kWh',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
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
                            'Input jumlah kWh yang ingin anda beli pada form dibawah ini',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
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
                          child: const Text(
                            'kWh',
                            style: TextStyle(fontWeight: FontWeight.bold),
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
                          child: const Text(
                            'Estimasi Biaya',
                            style: TextStyle(
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
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
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
                    if (nominalKWH.text.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmPage(
                              nominal: nominalKWH.text, qrCode: widget.qrCode),
                        ),
                      );
                    } else {
                      dangerNull(context);
                    }
                  },
                  child: const Text('Next', style: TextStyle(fontSize: 16)),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  AppBar appbarApk(BuildContext context) {
    return AppBar(
      leading: BackButton(
        color: Color.fromRGBO(247, 247, 248, 1),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NavigationPage(),
            ),
          );
        },
      ),
      elevation: 1,
      bottomOpacity: 1,
      toolbarHeight: 70,
      centerTitle: true,
      backgroundColor: bluee,
      title: const Text(
        "Charging Input",
        style: TextStyle(color: Color.fromRGBO(247, 247, 248, 1)),
      ),
    );
  }
}
