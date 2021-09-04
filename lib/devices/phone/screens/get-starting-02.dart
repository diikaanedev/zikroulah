import 'package:flutter/material.dart';
import 'package:zikroulah/devices/phone/widgets/card-get-starting-02-widget-phone.dart';
import 'package:zikroulah/utils/constant-by-dii.dart';

class GetStarting02Screen extends StatefulWidget {
  @override
  _GetStarting02ScreenState createState() => _GetStarting02ScreenState();
}

class _GetStarting02ScreenState extends State<GetStarting02Screen> {
  late ConstantByDii cons;
  late Size size;

  @override
  void initState() {
    super.initState();
    setState(() {
      cons = ConstantByDii();
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: .0, elevation: 0, backgroundColor: cons.blanc()),
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
          ),
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: size.height,
                width: size.width,
                child: CardGetStarting02Widget(),
              ))
        ],
      ),
    );
  }
}
