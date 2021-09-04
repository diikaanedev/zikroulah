import 'package:flutter/material.dart';
import 'package:zikroulah/devices/phone/widgets/card-get-starting-widget.dart';
import 'package:zikroulah/utils/constant-by-dii.dart';

class GetStartingScreen extends StatefulWidget {
  @override
  _GetStartingScreenState createState() => _GetStartingScreenState();
}

class _GetStartingScreenState extends State<GetStartingScreen> {
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
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //         image: AssetImage('assets/images/design getting1-01.png'),
            //         fit: BoxFit.cover)),
            // // child: CardGetStartingWidget(),
          ),
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: size.height,
                width: size.width,
                child: CardGetStartingWidget(),
              ))
        ],
      ),
    );
  }
}
