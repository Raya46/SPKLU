import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutetr_spklu/page/Feature/HistoryPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
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
                  "2 Locations",
                ),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: widgetHistory(context)),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: widgetHistory(context)),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: widgetHistory(context)),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: widgetHistory(context)),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: widgetHistory(context)),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: widgetHistory(context)),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: widgetHistory(context)),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: widgetHistory(context)),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: widgetHistory(context)),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: widgetHistory(context)),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: widgetHistory(context)),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: widgetHistory(context)),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: widgetHistory(context)),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: widgetHistory(context)),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: widgetHistory(context)),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: widgetHistory(context)),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: widgetHistory(context)),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: widgetHistory(context)),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: widgetHistory(context)),
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
                  width: MediaQuery.of(context).size.width / 1.15,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "SPKLU Cikunir",
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: black),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on, size: 22, color: blue),
                          Text('Jl cikunir raya no.1 Bekasi,Indonesia ',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: black70))
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.charging_station_rounded,
                                  size: 22, color: blue),
                              Text('2 Charger Box',
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: black70)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.2,
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
                                      Icon(
                                        Icons.gps_fixed,
                                        color: white,
                                      ),
                                      Text(
                                        'Direction',
                                        style: GoogleFonts.inter(color: white),
                                      )
                                    ],
                                  ),
                                  onPressed: () {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      width:
                                          MediaQuery.of(context).size.width / 1,
                                      buttonsBorderRadius:
                                          const BorderRadius.all(
                                        Radius.circular(2),
                                      ),
                                      dismissOnTouchOutside: false,
                                      dismissOnBackKeyPress: true,
                                      headerAnimationLoop: false,
                                      animType: AnimType.scale,
                                      title: 'INFO',
                                      desc:
                                          'This Dialog can be dismissed touching outside',
                                      btnCancelOnPress: () {},
                                    ).show();
                                  },
                                ),
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
