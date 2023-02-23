import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutetr_spklu/global/color.dart';
import 'package:flutetr_spklu/page/Payment/StatusPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmPage extends StatefulWidget {
  const ConfirmPage({
    Key? key,
    required this.estimasiBiaya,
  }) : super(key: key);

  final String estimasiBiaya;

  @override
  State<ConfirmPage> createState() =>
      _ConfirmPageState(estimasiBiaya: estimasiBiaya);
}

class _ConfirmPageState extends State<ConfirmPage> {
   _ConfirmPageState({
    required this.estimasiBiaya,
  }) : super();

  final String estimasiBiaya;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final height = constraints.maxHeight;
      final width = constraints.maxWidth;
      return Scaffold(
        backgroundColor: bg,
        appBar: AppBar(
          leading: const BackButton(color: Color.fromRGBO(247, 247, 248, 1)),
          elevation: 1,
          bottomOpacity: 1,
          toolbarHeight: 70,
          centerTitle: true,
          backgroundColor: blue,
          title: Text(
            "Cost Details",
            style: GoogleFonts.inter(
                color: Color.fromRGBO(247, 247, 248, 1),
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          color: Colors.grey[200],
          // padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  width: width,
                  color: blue15,
                  child: Container(
                    margin: const EdgeInsets.all(20.0),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(10)),
                      child: Container(
                        width: width,
                        color: blue,
                        child: Container(
                          padding: EdgeInsets.all(width * 0.05),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Text(
                                'Total Estimated cost',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              Text(
                                'Rp $estimasiBiaya ',
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: white,
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Your Balance",
                            style: TextStyle(fontSize: 16),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.credit_card_rounded),
                              Text(
                                "Rp 312.590",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: blue15,
                              onPrimary: blue,
                              onSurface: blue),
                          child: Text("Refresh"),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  margin: EdgeInsets.all(20),
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(20)),
                    child: Container(
                      width: width,
                      color: white,
                      child: Container(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Detail Biaya",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total kWh dibeli",
                                    style: TextStyle(color: Colors.black38),
                                  ),
                                  Text("30 kWh",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Biaya Kwh",
                                    style: TextStyle(color: Colors.black38),
                                  ),
                                  Text("Rp 73.232",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Biaya PPJ",
                                    style: TextStyle(color: Colors.black38),
                                  ),
                                  Text("Rp 1.202",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Biaya PPN",
                                    style: TextStyle(color: Colors.black38),
                                  ),
                                  Text("Rp 0",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Biaya Materai",
                                    style: TextStyle(color: Colors.black38),
                                  ),
                                  Text("Rp 0",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Biaya Admin",
                                    style: TextStyle(color: Colors.black38),
                                  ),
                                  Text("Rp 550",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: white,
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(fontSize: 16),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Rp 80.590",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        width: width * 0.3,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blue,
                          ),
                          child: Text("Next"),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StatusPage(),
                                ));
                            // AwesomeDialog(
                            //   context: context,
                            //   dialogType: DialogType.warning,
                            //   width: width,
                            //   buttonsBorderRadius: const BorderRadius.all(
                            //     Radius.circular(2),
                            //   ),
                            //   dismissOnTouchOutside: false,
                            //   dismissOnBackKeyPress: true,
                            //   onDismissCallback: (type) {
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //       SnackBar(
                            //         content: Text('Dismissed by $type'),
                            //       ),
                            //     );
                            //   },
                            //   headerAnimationLoop: false,
                            //   animType: AnimType.bottomSlide,
                            //   title: 'INFO',
                            //   desc:
                            //       'This Dialog can be dismissed touching outside',
                            //   // showCloseIcon: true,
                            //   btnCancelOnPress: () {},
                            // ).show();
                          },
                        ),
                        //     AnimatedButton(
                        //   text: 'Next',
                        //   pressEvent: () {
                        //     AwesomeDialog(
                        //       context: context,
                        //       dialogType: DialogType.warning,
                        //       width: width ,
                        //       buttonsBorderRadius: const BorderRadius.all(
                        //         Radius.circular(2),
                        //       ),
                        //       dismissOnTouchOutside: false,
                        //       dismissOnBackKeyPress: true,
                        //       onDismissCallback: (type) {
                        //         ScaffoldMessenger.of(context).showSnackBar(
                        //           SnackBar(
                        //             content: Text('Dismissed by $type'),
                        //           ),
                        //         );
                        //       },
                        //       headerAnimationLoop: false,
                        //       animType: AnimType.bottomSlide,
                        //       title: 'INFO',
                        //       desc:
                        //           'This Dialog can be dismissed touching outside',
                        //       // showCloseIcon: true,
                        //       btnCancelOnPress: () {},
                        //     ).show();
                        //   },
                        // ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
