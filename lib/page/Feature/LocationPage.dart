// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutetr_spklu/page/Feature/HistoryPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:google_fonts/google_fonts.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _Locationpage();
}

const Color blue = Color.fromRGBO(0, 125, 251, 1);
const Color white = Color.fromRGBO(247, 247, 248, 1);
const Color bg = Color.fromRGBO(240, 239, 244, 1);
const Color text = Color.fromRGBO(48, 48, 244, 1);

class _Locationpage extends State<LocationPage> {
  final LocalStorage storage = new LocalStorage('localstorage_app');
  late List _lokasiData = [];
  late String? lengthData;
  bool _isLoading = false;
  String urllucu = 'https://www.google.com/maps/search/?api=1&query=';

  @override
  void initState() {
    super.initState();
    _fetchLokasiData();
  }

  Future<void> _fetchLokasiData() async {
    final api_token = storage.getItem('api_token');
    final response = await http.get(Uri.parse(
        'http://spklu.solusi-rnd.tech/api/data-lokasi?token=$api_token'));

    if (response.statusCode == 200) {
      setState(() {
        _lokasiData = jsonDecode(response.body);
        _isLoading = true;
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
          "Location",
          style: TextStyle(color: Color.fromRGBO(247, 247, 248, 1)),
        ),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                " Locations",
              ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: _isLoading
                      ? Column(
                          children: [
                            for (var data in _lokasiData)
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                child: widgetHistory(
                                  context,
                                  data['nama_lokasi'],
                                  data['alamat_lokasi'],
                                  data['jumlah'],
                                  data['url_arah'],
                                ),
                              )
                          ],
                        )
                      : Shimmer.fromColors(
                          child: Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 6.5,
                                width: MediaQuery.of(context).size.width / 1.15,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(16)),
                              ),
                              Divider(),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 6.5,
                                width: MediaQuery.of(context).size.width / 1.15,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(16)),
                              ),
                              Divider(),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 6.5,
                                width: MediaQuery.of(context).size.width / 1.15,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(16)),
                              ),
                              Divider(),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 6.5,
                                width: MediaQuery.of(context).size.width / 1.15,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(16)),
                              ),
                            ],
                          ),
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!)),
            ],
          ),
        ),
      ),
    );
  }
}

Widget widgetHistory(
        context, namaLokasi, alamatLokasi, jumlahChargerBox, urlArah) =>
    Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(const Radius.circular(10)),
          child: Container(
            height: MediaQuery.of(context).size.height / 6.5,
            color: white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 15,
                  color: blue,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.16,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              namaLokasi,
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                          child: Container(
                        height: 10,
                      )),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on, size: 22, color: blue),
                          Flexible(
                            child: Text(
                              alamatLokasi,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: black70,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                          child: Container(
                        height: 10,
                      )),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.charging_station_rounded,
                                  size: 22, color: blue),
                              Text(
                                '$jumlahChargerBox Charger Box',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: black70,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.1,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: blue,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.gps_fixed,
                                          color: white,
                                        ),
                                        Text(
                                          'Direction',
                                          style:
                                              GoogleFonts.inter(color: white),
                                        )
                                      ],
                                    ),
                                    onPressed: () async {
                                      if (await canLaunch(urlArah)) {
                                        await launch(urlArah);
                                      } else {
                                        throw 'Tidak dapat membuka $urlArah';
                                      }
                                    }),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
