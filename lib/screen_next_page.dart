import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';

class ScreenNextPage extends StatefulWidget {
  const ScreenNextPage({super.key});

  @override
  State<ScreenNextPage> createState() => _ScreenNextPageState();
}

class _ScreenNextPageState extends State<ScreenNextPage> {
  // Constantly listen to internet connection availability
  late StreamSubscription subscription;

  // Check if the device is connected or not
  var isDeviceConnected = false;

  // Keep track of alert box (check if it is open or not)
  bool isAlertBox = false;

  @override
  void initState() {
    super.initState();
    getConnectivity();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void getConnectivity() {
    subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) async {
      bool isConnected = await InternetConnectionChecker().hasConnection;
      setState(() {
        isDeviceConnected = isConnected;
      });
      if (!isConnected && !isAlertBox) {
        //showAlertDialog(context);
      }
    });
  }

  // void showAlertDialog(BuildContext context) {
  //   // Set up the button
  //   Widget okButton = TextButton(
  //     child: Text("OK"),
  //     onPressed: () async {
  //       Navigator.pop(context, 'Cancel');
  //       setState(() {
  //         isAlertBox = false;
  //       });
  //       bool isConnected = await InternetConnectionChecker().hasConnection;
  //       if (!isConnected) {
  //         showAlertDialog(context);
  //         setState(() {
  //           isAlertBox = true;
  //         });
  //       }
  //     },
  //   );

  //   // Set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     title: Text("No internet"),
  //     content: Text("Bad network connection"),
  //     actions: [
  //       okButton,
  //     ],
  //   );

  //   // Show the dialog
  //   // showDialog(
  //   //   context: context,
  //   //   builder: (BuildContext context) {
  //   //     return alert;
  //   //   },
  //   // ).then((_) {
  //   //   setState(() {
  //   //     isAlertBox = false;
  //   //   });
  //   // });

  //   setState(() {
  //     isAlertBox = true;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isDeviceConnected ? 'Internet Connectivity' : 'Bad Network Connection'),
      ),
      body: Center(
        child: isDeviceConnected
            ?Lottie.asset('assets/images/Animation - 1714725933185 (2).json')
            : Lottie.asset('assets/images/Animation - 1718354318145.json'),
      ),
    );
  }
}
