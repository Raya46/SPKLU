import 'package:flutetr_spklu/page/Payment/ChargingInputPage.dart';
import 'package:flutetr_spklu/page/Payment/ConfirmPage.dart';
import 'package:flutetr_spklu/page/Feature/HistoryPage.dart';
import 'package:flutetr_spklu/page/Main/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'page/Main/DashboardPage.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentTab = 0;
  final List<Widget> screens = [
    // const HomePage(),
    const DashboardPage(),
    const HistoryPage(),
    const ChargingInputPage(),
    // const ConfirmPage(),
    const ProfilePage(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const DashboardPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.electric_bolt,
          size: 24.0,
        ),
        onPressed: () {
          modalBottomSheet(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = const DashboardPage();
                        currentTab = 0;
                      });
                    },
                    minWidth: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          size: 24.0,
                          color: currentTab == 0 ? blue : black70,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                              color: currentTab == 0 ? blue : black70),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = const ProfilePage();
                    currentTab = 1;
                  });
                },
                minWidth: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      size: 24.0,
                      color: currentTab == 1 ? blue : black70,
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(color: currentTab == 1 ? blue : black70),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> modalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: white,
        shape: const RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        // backgroundColor: white,
        context: context,
        builder: (context) {
          final screenHeight = MediaQuery.of(context).size.height;
          final screenWidth = MediaQuery.of(context).size.width;
          // ignore: avoid_unnecessary_containers
          return SizedBox(
            height: screenHeight / 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              // mainAxisSize: MainAxisSize.,
              children: [
                Divider(
                  indent: 150,
                  endIndent: 150,
                  height: 20,
                  thickness: 4,
                  color: black,
                ),
                Container(
                  margin: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                onPrimary: black,
                                elevation: 0),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ChargingInputPage()),
                              );
                            },
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.charging_station_rounded,
                                    color: blue,
                                  ),
                                ),
                                Text("SPKLU Charging",
                                    style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: black))
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                onPrimary: black,
                                elevation: 0),
                            onPressed: () {},
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.home_filled,
                                    color: blue,
                                  ),
                                ),
                                Text("Home Charging",
                                    style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: black))
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
