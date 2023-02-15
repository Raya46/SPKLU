import 'package:flutetr_spklu/page/Feature/HistoryPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final topCover = screenHeight / 6;
    final profile = screenWidth / 6;
    final topProfile = topCover - profile;
    final bottom = profile * 1.5;
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
        const BuildContent()
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Text(
          'Rafael Lorenzo',
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
