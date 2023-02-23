import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutetr_spklu/page/Feature/HistoryPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var format = NumberFormat.currency(locale: 'id', symbol: 'Rp');
  final LocalStorage storage = new LocalStorage('localstorage_app');
  late List _userData = [];
  late String sisaSaldo = "";
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

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final topCover = screenHeight / 6;
    final profile = screenWidth / 6;
    final topProfile = topCover - profile;
    final bottom = profile * 1.5;
    //API

    return Scaffold(
      backgroundColor: bg,
      appBar: MainAppbar(),
      body: ListView(children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: BuildTop(
              bottom: bottom,
              topCover: topCover,
              screenWidth: screenWidth,
              topProfile: topProfile,
              profile: profile),
        ),
        BuildContent(userData: _userData)
      ]),
    );
  }

  AppBar MainAppbar() {
    return AppBar(
      elevation: 0,
      bottomOpacity: 0,
      toolbarHeight: 70,
      centerTitle: true,
      backgroundColor: blue,
      title: const Text(
        "Profile",
        style: TextStyle(color: Color.fromRGBO(247, 247, 248, 1)),
      ),
    );
  }
}

class BuildContent extends StatelessWidget {
  const BuildContent({
    Key? key,
    required List userData,
  })  : _userData = userData,
        super(key: key);

  final List _userData;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        if (_userData.isNotEmpty)
          Text(
            '${_userData[0]['name']}',
            style: GoogleFonts.inter(
                fontSize: 24, color: black, fontWeight: FontWeight.bold),
          ),
        Text(
          'rl.lorenzo.256@gmail.com',
          style: GoogleFonts.inter(
              fontSize: 18, color: black70, fontWeight: FontWeight.normal),
        ),
        Text(
          '+62891023497197',
          style: GoogleFonts.inter(
              fontSize: 18, color: black70, fontWeight: FontWeight.normal),
        )
      ]),
    );
  }
}

class BuildTop extends StatelessWidget {
  const BuildTop({
    Key? key,
    required this.topCover,
    required this.screenWidth,
    required this.topProfile,
    required this.profile,
    required this.bottom,
  }) : super(key: key);

  final double topCover;
  final double screenWidth;
  final double topProfile;
  final double profile;
  final double bottom;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          height: topCover,
          width: screenWidth,
          color: blue,
        ),
        Profile(topProfile: topProfile, profile: profile, bottom: bottom),
      ],
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({
    Key? key,
    required this.topProfile,
    required this.profile,
    required this.bottom,
  }) : super(key: key);

  final double topProfile;
  final double profile;
  final double bottom;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topProfile,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: blue,
            width: 10.0,
          ),
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          radius: profile,
          backgroundColor: white,
          backgroundImage: const NetworkImage(
              'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80'),
        ),
      ),
    );
  }
}
