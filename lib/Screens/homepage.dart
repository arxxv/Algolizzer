import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import '../Configuration/constants.dart';
import 'package:algolizzzer/Screens/BruteForce.dart';
import 'info.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      backgroundColor: kbackgndColor,
      image: Image.asset("images/logo.png"),
      loaderColor: kbackgndColor,
      photoSize: 100,
      navigateAfterSeconds: Menu(),
    );

//      MaterialApp(
//        debugShowCheckedModeBanner: false,
//        home: Scaffold(
//          backgroundColor: kbackgndColor,
//          body: Container(
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.symmetric(horizontal: 80),
//                  child: Container(
//                    child: Image(
//                      image: AssetImage("images/logo.png"),
//                    ),
//                  ),
//                ),
//                SizedBox(
//                  height: 20,
//                ),
//                Text(
//                  "Algolizzer",
//                  style: TextStyle(
//                    color: Colors.white60,
//                    fontSize: 50,
//                    fontWeight: FontWeight.bold,
//                  ),
//                )
//              ],
//            ),
//          ),
//        ));
  }
}
