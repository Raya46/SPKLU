import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutetr_spklu/page/Payment/StatusPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dangerNull(context) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    width: MediaQuery.of(context).size.width / 1,
    buttonsBorderRadius: const BorderRadius.all(
      Radius.circular(2),
    ),
    dismissOnTouchOutside: false,
    dismissOnBackKeyPress: true,
    headerAnimationLoop: false,
    animType: AnimType.scale,
    title: 'ALERT',
    desc: '"Please enter the kwh value you want to buy"',
    btnCancelOnPress: () {},
  ).show();
}

// void openLoading(BuildContext context, [bool mounted = true]) async {
//       showDialog(
//           barrierDismissible: false,
//           context: context,
//           builder: (_) {
//             return Dialog(
//               // The background color
//               backgroundColor: Colors.white,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: const [
//                     // The loading indicator
//                     CircularProgressIndicator(),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     // Some text
//                     Text('Loading...')
//                   ],
//                 ),
//               ),
//             );
//           });
//       await Future.delayed(const Duration(seconds: 1));
//       if (!mounted) return;
//       Navigator.of(context).push(
//         MaterialPageRoute(builder: (context) => const StatusPage() )
//       );
// }


// confirmAlert(context) {
//   AnimatedButton(
//     text: 'Info Dialog fixed width and square buttons',
//     pressEvent: () {
//       AwesomeDialog(
//         context: context,
//         dialogType: DialogType.info,
//         borderSide: const BorderSide(
//           color: Colors.green,
//           width: 2,
//         ),
//         width: 280,
//         buttonsBorderRadius: const BorderRadius.all(
//           Radius.circular(2),
//         ),
//         dismissOnTouchOutside: true,
//         dismissOnBackKeyPress: false,
//         onDismissCallback: (type) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Dismissed by $type'),
//             ),
//           );
//         },
//         headerAnimationLoop: false,
//         animType: AnimType.bottomSlide,
//         title: 'INFO',
//         desc: 'This Dialog can be dismissed touching outside',
//         showCloseIcon: true,
//         btnCancelOnPress: () {},
//         btnOkOnPress: () {},
//       ).show();
//     },
//   );
// }
