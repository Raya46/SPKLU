import 'package:flutetr_spklu/NavigationPage.dart';
import 'package:flutetr_spklu/page/Main/DashboardPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    final Color blue = Color.fromRGBO(0, 125, 251, 1);
    final Color black = Color.fromRGBO(55, 63, 71, 1);
    final Color black70 = Color.fromRGBO(55, 63, 71, 0.7);
    final Color white = Color.fromRGBO(247, 247, 248, 1);
    final Color bg = Color.fromRGBO(240, 239, 244, 1);
    final Color text = Color.fromRGBO(48, 48, 244, 1);

    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final height = constraints.maxHeight;
      return Scaffold(
        backgroundColor: bg,
        appBar: AppBar(
          leading: BackButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NavigationPage()),
                );
              },
              color: Color.fromRGBO(247, 247, 248, 1)),
          elevation: 1,
          bottomOpacity: 1,
          toolbarHeight: 70,
          centerTitle: true,
          backgroundColor: blue,
          title: const Text(
            "Charging",
            style: TextStyle(color: Color.fromRGBO(247, 247, 248, 1)),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: Container(
                          width: width / 1.5,
                          height: width / 2.1,
                          child: Icon(
                            Icons.car_repair,
                            size: 120,
                            color: blue,
                          ),
                          // decoration: const BoxDecoration(
                          //   image: DecorationImage(
                          //     image: AssetImage("assets/images/car.png"),
                          //     fit: BoxFit.contain,
                          //   ),
                          // ),
                        ),
                      ),
                      Text(
                        'You Connected to Charger Box',
                        style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: (width * 0.15)),
                        child: Text(
                          'You can stop the charging with application or with your car ',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                              color: black70),
                        ),
                      ),
                    ]),
              ),
              Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: width * 0.04, vertical: width * 0.03),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          child: Container(
                            decoration: const BoxDecoration(boxShadow: [
                              BoxShadow(
                                  offset: Offset(2.0, 0.0),
                                  color: Colors.white,
                                  blurRadius: 0.5)
                            ]),
                            height: width / 5.5,
                            // width: width / 2,
                            // color: white,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      child: Container(
                                        padding: EdgeInsets.all(width * 0.01),
                                        color: blue,
                                        child: Icon(
                                          Icons.location_on,
                                          size: width * 0.1,
                                          color: white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'SPKLU POOL DAMRI KEMAYORAN',
                                        style: GoogleFonts.inter(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: black),
                                      ),
                                      Text(
                                        'Jl. Kran Raya Gg tets, 01-20,sahari Selata..',
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.inter(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: black70),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: width * 0.04),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          child: Container(
                            decoration: const BoxDecoration(boxShadow: [
                              BoxShadow(
                                  offset: Offset(2.0, 0.0),
                                  color: Colors.white,
                                  blurRadius: 0.5)
                            ]),
                            height: width / 5.5,
                            // width: width / 2,
                            // color: white,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      child: Container(
                                        padding: EdgeInsets.all(width * 0.01),
                                        color: blue,
                                        child: Icon(
                                          Icons.charging_station_rounded,
                                          size: width * 0.1,
                                          color: white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Delta DC City Charger',
                                        style: GoogleFonts.inter(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: black),
                                      ),
                                      Text(
                                        'Plug : B CCS2 - 180 kW DC',
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.inter(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: black70),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
              Expanded(
                flex: 3,
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    padding: const EdgeInsets.all(15),
                    color: blue,
                    height: height / 8.5,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "In Use",
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: white,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  "0.00 kWh",
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: white,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                        ),
                        Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Available",
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: white,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  "0.00 kWh",
                                  style: GoogleFonts.inter(
                                      // fontSize: 14,
                                      color: white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                        ),
                        VerticalDivider(
                          thickness: 2,
                          width: 20,
                          color: white,
                        ),
                        Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Charging Time",
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: white,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  "0.00 kWh",
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                        ),
                        Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Remaning Time",
                                  style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: white,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  "0.00 kWh",
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    color: white,
                    padding: const EdgeInsets.all(20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        width: width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blue,
                          ),
                          child: Text(
                            "Connecting",
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: white),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      );
    });
  }
}
