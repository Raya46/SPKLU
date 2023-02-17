import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

MobileScannerController cameraController =
    MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates);

bool start = true;

@override
Widget build(BuildContext context) {
  return NewWidget();
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Scanner'),
      ),
      body: MobileScanner(
        fit: BoxFit.contain,
        controller: MobileScannerController(
            detectionSpeed: start? DetectionSpeed.normal : DetectionSpeed.noDuplicates
            ),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          final Uint8List? image = capture.image;
            start = false;
          for (final barcode  in barcodes) {
            Alert(context, barcode).show();
            debugPrint('Barcode found! ${barcode.rawValue}');
          }
        },
      ),
    );
  }

  AwesomeDialog Alert(BuildContext context, Barcode barcode) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      width: MediaQuery.of(context).size.width,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: true,
      onDismissCallback: (type) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Barcode found! ${barcode.rawValue}'),
          ),
        );
      },
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'INFO',
      desc: 'Barcode found! ${barcode.rawValue}',
      // showCloseIcon: true,
      btnCancelOnPress: () {},
    );
  }
}
