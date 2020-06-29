import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Screens/homepage.dart';

void main() {
  runApp(Algolizzer());
}

class Algolizzer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    );
  }
}
