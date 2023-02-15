import 'package:flutetr_spklu/NavigationPage.dart';
import 'package:flutetr_spklu/global/color.dart';
import 'package:flutetr_spklu/page/Feature/LocationPage.dart';
import 'package:flutetr_spklu/page/Main/DashboardPage.dart';
import 'package:flutetr_spklu/page/Payment/ConfirmPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const ChargingInputPage());
}

class ChargingInputPage extends StatelessWidget {
  const ChargingInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Pengisian kWh',
      home: ChargingInputScreen(),
    );
  }
}

class ChargingInputScreen extends StatefulWidget {
  const ChargingInputScreen({super.key});

  @override
  State<ChargingInputScreen> createState() => _ChargingInputScreenState();
}

class _ChargingInputScreenState extends State<ChargingInputScreen> {
  final nominalKWH = TextEditingController();
  String estimasiBiaya = "0";

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
                            child: const Text(
                              'Jl. Cikunir Raya No.689, RT.002/RW.015, Jaka Mulya, Kec. Bekasi Sel., Kota Bks, Jawa Barat 17146',
                              style: TextStyle(
                                fontSize: 13,
                              ),
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
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Column(
                              children: [
                                Container(
                                  transform:
                                      Matrix4.translationValues(-9.0, 0.0, 0.0),
                                  child: const Text(
                                    'Delta DC City Charger',
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: width * 0.02),
                                  child: const Text(
                                    'Plug: B.CC52 - 180 kW DC',
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ConfirmPage()));
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
        leading: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    // ignore: prefer_const_constructors
                    NavigationPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(-1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 500),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        bottomOpacity: 0,
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          "Charging Input",
          style: TextStyle(color: Color.fromRGBO(247, 247, 248, 1)),
        ),
      );
  }
}
