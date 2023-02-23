// import 'package:flutetr_spklu/page/Payment/ChargingInputPage.dart';
// import 'package:flutetr_spklu/page/Payment/ConfirmPage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// class ScanQR extends StatefulWidget {
//   const ScanQR({super.key});

//   @override
//   State<ScanQR> createState() => _ScanQRState();
// }

// class _ScanQRState extends State<ScanQR> {
//   String _scanBarcode = '';

//   Future<void> scanQR() async {
//     String barcodeScanRes;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//           '#ff6666', 'cancel', true, ScanMode.QR);
//       print(barcodeScanRes);
//       if (barcodeScanRes == '-1') {
//         // ignore: use_build_context_synchronously
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) =>  ChargingInputPage(),
//             ));
//       } else {
//         // ignore: use_build_context_synchronously
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const ConfirmPage(),
//             ));
//       }
//     } on PlatformException {
//       barcodeScanRes = 'Failed to get platform version.';
//     }
//     if (!mounted) return;

//     setState(() {
//       _scanBarcode = barcodeScanRes;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScanQR();
//   }
// }
