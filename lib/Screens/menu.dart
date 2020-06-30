import 'package:algolizzzer/Screens/Divide&Conquer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:algolizzzer/Configuration/constants.dart';
import 'package:algolizzzer/Screens/BruteForce.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width / 1.5,
      color: Colors.white,
      child: Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              ),
              Image.asset(
                'images/logo.png',
                width: 150,
              ),
              SizedBox(
                height: 100,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.08)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return BruteForce();
                      }));
                    },
                    child: Text("BRUTE FORCE",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.redAccent)),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DivideandConquer();
                      }));
                    },
                    child: Text(
                      'DIVIDE & CONQUER',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.redAccent),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
