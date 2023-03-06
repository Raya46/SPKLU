// ignore_for_file: sort_child_properties_last

import 'dart:convert';

import 'package:flutetr_spklu/page/Feature/HistoryPage.dart';
import 'package:flutetr_spklu/page/Feature/LocationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as http;
// import 'ChargingInputPage.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  runApp(const DashboardPage());
}

Future hideBar() async =>
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Dashboard',
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var format = NumberFormat.currency(locale: 'id', symbol: 'Rp');
  final LocalStorage storage = new LocalStorage('localstorage_app');
  late List _userData = [];
  late String sisaSaldo = "";
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _fetchDataUser();
  }

  Future<void> _fetchDataUser() async {
    final id = storage.getItem('id');
    final api_token = storage.getItem('api_token');
    final response = await http.get(Uri.parse(
        'http://spklu.solusi-rnd.tech/api/users?token=$api_token&id=$id'));

    if (response.statusCode == 200) {
      setState(() {
        isLoading = true;
        _userData = jsonDecode(response.body);
        sisaSaldo = format.format(int.parse(_userData[0]['sisa_saldo']));
        print(sisaSaldo);
        // _lokasiData.forEach((item) {
        //   print(item['id']);
        //   print(item['kode_lokasi']);
        //   print(item['nama_lokasi']);
        //   print(item['alamat_lokasi']);
        //   print(item['url_arah']);
        //   print(item['jumlah']);
        // });
      });
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double heightCard;
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        if (height > 700) {
          heightCard = height * 0.30;
        } else {
          print(width);
          heightCard = height * 0.35;
        }

        return DefaultTabController(
          length: 2,
          child: SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const TitleSPKLU(),
                    const YourBalance(),
                    Container(
                      transform: Matrix4.translationValues(0.0, -90.0, 0.0),
                      padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.wallet,
                            color: Colors.white,
                          ),
                          Container(
                            width: 5,
                          ),
                          isLoading
                              ? Text(
                                  sisaSaldo,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Shimmer.fromColors(
                                  child: Container(
                                    height: 22,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  baseColor: Color.fromRGBO(0, 125, 251, 1),
                                  highlightColor:
                                      Color.fromRGBO(86, 179, 255, 1))
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          transform: Matrix4.translationValues(0.0, -60.0, 0.0),
                          padding: const EdgeInsets.all(15.0),
                          height: heightCard,
                          width: double.infinity,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 7.0,
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      isLoading
                                          ? Container(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Hi, ${_userData[0]['name']}',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )
                                          : Row(
                                            children: [
                                              Shimmer.fromColors(
                                                  child: Container(
                                                    alignment: Alignment.topLeft,
                                                    height: 32,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5)),
                                                  ),
                                                  baseColor: Colors.grey[300]!,
                                                  highlightColor: Colors.grey[50]!),
                                            ],
                                          ),
                                      Container(
                                        height: 15,
                                      ),
                                      Card(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey,
                                                width: 0.1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 18,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: IconButton(
                                              onPressed: () {
                                                print("Home Charging");
                                              },
                                              iconSize: 40.0,
                                              icon: const Icon(Icons
                                                  .maps_home_work_outlined),
                                              color: const Color.fromRGBO(
                                                  0, 125, 251, 1),
                                            ),
                                          ),
                                          Expanded(child: Container()),
                                          IconButton(
                                            onPressed: () {
                                              hideBar();
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .push(
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      const LocationPage(),
                                                ),
                                              );
                                            },
                                            iconSize: 40.0,
                                            icon: const Icon(Icons.map_sharp),
                                            color: const Color.fromRGBO(
                                                0, 125, 251, 1),
                                          ),
                                          Expanded(child: Container()),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 13.0),
                                            child: IconButton(
                                              onPressed: () {
                                                print("Topup Balance");
                                              },
                                              iconSize: 40.0,
                                              icon: const Icon(
                                                  Icons.add_card_rounded),
                                              color: const Color.fromRGBO(
                                                  0, 125, 251, 1),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            alignment: Alignment.center,
                                            width: 70,
                                            child: const Text(
                                              'Home Charging',
                                              style: TextStyle(),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Expanded(child: Container()),
                                          Container(
                                            alignment: Alignment.center,
                                            width: 70,
                                            child: const Text(
                                              'SPKLU Location',
                                              style: TextStyle(),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Expanded(child: Container()),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            alignment: Alignment.center,
                                            width: 70,
                                            child: const Text(
                                              'Topup Balance',
                                              style: TextStyle(),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          transform: Matrix4.translationValues(0.0, -70.0, 0.0),
                          padding: const EdgeInsets.all(15.0),
                          height: 500,
                          width: double.infinity,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 7.0,
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      const Text(
                                        'SPKLU ENERGY CONSUMPTION',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Container(
                                        height: 7,
                                      ),
                                      const Text(
                                        'Today',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 100, 99, 99),
                                        ),
                                      ),
                                      Container(
                                        height: 7,
                                      ),
                                      const Text(
                                        '02 February 2023',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 100, 99, 99),
                                        ),
                                      ),
                                      Container(
                                        height: 20,
                                      ),
                                      const Text(
                                        '0.00 kWh',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 18, 50, 97),
                                        ),
                                      ),
                                      Container(
                                        height: 13,
                                      ),
                                      Card(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey,
                                                width: 0.5,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width: width * 0.55,
                                        height: height * 0.055,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          color: const Color.fromRGBO(
                                              0, 125, 251, 1),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: width * 0.03, right: 1.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                ElevatedButton(
                                                  onPressed: () {},
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          shadowColor: Colors
                                                              .transparent),
                                                  child: const Text(
                                                    'Weekly',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(),
                                                ),
                                                Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0)),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: width * 0.25,
                                                    height: height * 0.15,
                                                    child: const Text(
                                                      'Monthly',
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 125, 251, 1),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TitleSPKLU extends StatelessWidget {
  const TitleSPKLU({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(0, 125, 251, 1),
      ),
      padding: const EdgeInsets.only(left: 20.0, top: 10.0),
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // SizedBox(
          //   height: 20,
          // ),
          const Text(
            'SPKLU Intek',
            style: TextStyle(
              fontSize: 26,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(
                    builder: (_) => const HistoryPage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
                size: 30,
              )),
        ],
      ),
    );
  }
}

class YourBalance extends StatelessWidget {
  const YourBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0.0, -90.0, 0.0),
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 20.0, top: 20.0),
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          const Text(
            'Your balance',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
