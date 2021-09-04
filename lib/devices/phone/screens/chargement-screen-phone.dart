import 'dart:async';

import 'package:flutter/material.dart';
import 'package:statusbar/statusbar.dart';
import 'package:zikroulah/utils/constant-by-dii.dart';

class ChargementScreenPhone extends StatefulWidget {
  @override
  _ChargementScreenPhoneState createState() => _ChargementScreenPhoneState();
}

class _ChargementScreenPhoneState extends State<ChargementScreenPhone> {
  late ConstantByDii cons;
  late Size size;
  @override
  void initState() {
    super.initState();
    setState(() {
      cons = ConstantByDii();
    });
    goHome();
  }

  void goHome() async {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.popAndPushNamed(context, '/');
    });
  }

  @override
  Widget build(BuildContext context) {
    StatusBar.color(cons.blanc());

    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: .0,
        backgroundColor: cons.blanc(),
        elevation: .0,
      ),
      body: Stack(
        children: [
          Container(
              height: size.height,
              width: size.width,
              color: cons.blanc(),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .25,
                  ),
                  Container(
                    height: size.height * .4,
                    width: size.width * .3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'))),
                  ),
                ],
              )),
          Positioned(
              top: size.height * .5,
              // left: size.width * .27,
              child: Container(
                width: size.width,
                child: Center(
                  child: Text(
                    'ZIKROULA',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: cons.vert()),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
