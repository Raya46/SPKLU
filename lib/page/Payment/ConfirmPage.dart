import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutetr_spklu/global/color.dart';
import 'package:flutetr_spklu/page/Payment/StatusPage.dart';
import 'package:flutetr_spklu/page/Payment/widget/alertPay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:intl/intl.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class ConfirmPage extends StatefulWidget {
  ConfirmPage({
    Key? key,
    required this.nominal,
    required this.qrCode,
  }) : super(key: key);
  final String nominal;
  final String qrCode;
  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  final client = MqttServerClient('104.248.156.51', '');
  bool isConnected = false;
  var format = NumberFormat.currency(locale: 'id', symbol: 'Rp');
  final LocalStorage storage = new LocalStorage('localstorage_app');
  late List dataTarif = [];
  late List _userData = [];
  late String sisaSaldo = "";
  late String totalBiaya = "";
  late String biayakWh = "";
  late String biayaPPJ = "";
  late String biayaPPN = "";
  late String biayaMaterai = "";
  late String biayaAdmin = "";

  @override
  void initState() {
    super.initState();
    connect();
    _fetchDataTarif();
    _fetchDataUser();
  }

  Future<void> connect() async {
    final clientID = 'spklu-${DateTime.now().millisecondsSinceEpoch}';
    client.logging(on: false);
    client.setProtocolV311();
    client.keepAlivePeriod = 20;
    client.connectTimeoutPeriod = 2000;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    final connectMessage = MqttConnectMessage()
        .withClientIdentifier('Mqtt_MyClientUniqueId')
        .withWillTopic(
            'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    print('Connection to MQTT Server....');
    client.connectionMessage = connectMessage;

    try {
      await client.connect("ali", "1234");
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }
  }

  Future<void> subscribe(String topic) async {
    String payload;
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      client.subscribe(topic, MqttQos.atMostOnce);
      client.updates!
          .listen((List<MqttReceivedMessage<MqttMessage>>? messages) {
        final receivedMessage = messages![0].payload as MqttPublishMessage;
        payload = MqttPublishPayload.bytesToStringAsString(
            receivedMessage.payload.message);
        messages.forEach((MqttReceivedMessage<MqttMessage> message) {
          final String topic = message.topic;
        });
        if (topic == "SPKLU/Intek/Cikunir/Feedback/AC") {
          if (payload == "1") {
            postTransaksi();
            
          }
        }
      });
    } else {
      print('Client not connected');
    }
  }

  Future<void> publish(String topic, String message) async {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
  }

  void onDisconnected() {
    print("Disconnected to MQTT server");
    setState(() {
      isConnected = false;
    });
  }

  void onConnected() {
    print("Connected to MQTT server");
    setState(() {
      isConnected = true;
    });
    subscribe("SPKLU/Intek/Cikunir/Feedback/AC");
  }

  Future<void> _fetchDataUser() async {
    final id = storage.getItem('id');
    final api_token = storage.getItem('api_token');
    final response = await http.get(Uri.parse(
        'http://spklu.solusi-rnd.tech/api/users?token=$api_token&id=$id'));

    if (response.statusCode == 200) {
      setState(() {
        _userData = jsonDecode(response.body);
        sisaSaldo = format.format(int.parse(_userData[0]['sisa_saldo']));
      });
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  Future<void> _fetchDataTarif() async {
    final api_token = storage.getItem('api_token');
    final response = await http.get(Uri.parse(
        'http://spklu.solusi-rnd.tech/api/data-tarif?token=$api_token'));
    if (response.statusCode == 200) {
      setState(() {
        dataTarif = jsonDecode(response.body);

        totalBiaya = ((int.parse(widget.nominal) *
                    int.parse(dataTarif[0]['tarif_perkwh'])) +
                int.parse(dataTarif[0]['tarif_ppj']) +
                int.parse(dataTarif[0]['tarif_ppn']) +
                int.parse(dataTarif[0]['tarif_admin']) +
                int.parse(dataTarif[0]['tarif_materai']))
            .toStringAsFixed(0);

        biayakWh = (int.parse(dataTarif[0]['tarif_perkwh'])).toStringAsFixed(0);

        biayaPPJ = dataTarif[0]['tarif_ppj'];
        biayaPPN = dataTarif[0]['tarif_ppn'];
        biayaMaterai = dataTarif[0]['tarif_materai'];
        biayaAdmin = dataTarif[0]['tarif_admin'];
      });
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  Future<void> postTransaksi() async {
    final api_token = storage.getItem('api_token');
    final id = storage.getItem('id');
    final apiUrl = 'http://spklu.solusi-rnd.tech/api/transaksi';
    final headers = {'Content-Type': 'application/json'};
    final body = {
      'id_user': id,
      'qrcode': widget.qrCode,
      'nominal': widget.nominal,
      'costkwh': biayakWh,
      'ppj': biayaPPJ,
      'ppn': biayaPPN,
      'materai': biayaMaterai,
      'admin': biayaAdmin,
      'token': api_token,
    };

    http
        .post(Uri.parse(apiUrl), headers: headers, body: jsonEncode(body))
        .then((response) {
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const StatusPage(),
          ),
        );
      } else {
        print('Failed, status code: ${response.statusCode}');
      }
    }).catchError((error) {
      print('Terjadi error: $error');
    });
  }

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
          title: const Text(
            "Cost Details",
            style: TextStyle(color: Color.fromRGBO(247, 247, 248, 1)),
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
                            children: [
                              const Text(
                                'Total Estimated Cost',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              if (dataTarif.isNotEmpty)
                                Text(
                                  'Rp ${totalBiaya.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.')}',
                                  style: GoogleFonts.chakraPetch(
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
                          const Text(
                            "Your Balance",
                            style: TextStyle(fontSize: 16),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.credit_card_rounded),
                              if (dataTarif.isNotEmpty)
                                Text(
                                  "${sisaSaldo}",
                                  style: GoogleFonts.chakraPetch(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
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
                          onPressed: () {
                            _fetchDataUser();
                          },
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
                              "Cost Details",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total kWh dibeli",
                                  style: TextStyle(color: Colors.black38),
                                ),
                                if (dataTarif.isNotEmpty)
                                  Text("${widget.nominal} kWh",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Biaya Kwh",
                                  style: TextStyle(color: Colors.black38),
                                ),
                                if (dataTarif.isNotEmpty)
                                  Text(
                                      "Rp ${biayakWh.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.')}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Biaya PPJ",
                                  style: TextStyle(color: Colors.black38),
                                ),
                                if (dataTarif.isNotEmpty)
                                  Text(
                                      "Rp ${biayaPPJ.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.')}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Biaya PPN",
                                  style: TextStyle(color: Colors.black38),
                                ),
                                if (dataTarif.isNotEmpty)
                                  Text(
                                      "Rp ${biayaPPN.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.')}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Biaya Materai",
                                  style: TextStyle(color: Colors.black38),
                                ),
                                if (dataTarif.isNotEmpty)
                                  Text(
                                      "Rp ${biayaMaterai.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.')}",
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Biaya Admin",
                                  style: TextStyle(color: Colors.black38),
                                ),
                                if (dataTarif.isNotEmpty)
                                  Text(
                                      "Rp ${biayaAdmin.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.')}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
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
                          const Text(
                            "Total",
                            style: TextStyle(fontSize: 16),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (dataTarif.isNotEmpty)
                                Text(
                                  "Rp ${totalBiaya.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.')}",
                                  style: GoogleFonts.chakraPetch(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: width * 0.3,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blue,
                          ),
                          child: const Text("Pay"),
                          onPressed: () {
                            confirmAlert(context).show();
                          },
                        ),
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

  AwesomeDialog confirmAlert(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      width: MediaQuery.of(context).size.width / 1,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: true,
      headerAnimationLoop: false,
      animType: AnimType.scale,
      title: 'Confirm',
      desc: '"Please enter the kwh value you want to buy"',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        publish("SPKLU/Intek/Cikunir/Status/AC", "1");
      },
    );
  }

  @override
  void dispose() {
    client.disconnect();
    super.dispose();
  }
}
