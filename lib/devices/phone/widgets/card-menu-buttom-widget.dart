import 'package:flutter/material.dart';
import 'package:zikroulah/utils/constant-by-dii.dart';

class CardMenuButtomWidget extends StatefulWidget {
  @override
  _CardMenuButtomWidgetState createState() => _CardMenuButtomWidgetState();
}

class _CardMenuButtomWidgetState extends State<CardMenuButtomWidget> {
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
    return Positioned(
        bottom: size.height * .04,
        left: size.width * .1,
        child: Container(
          height: size.height * .07,
          width: size.width * .8,
          child: Row(
            children: [
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.popAndPushNamed(context, '/'),
                child: Container(
                  height: 30,
                  width: 80,
                  child: Image.asset('assets/images/logo zikroula-blanc.png',
                      fit: BoxFit.cover),
                ),
              ),
              Spacer(),
              Icon(
                Icons.person,
                color: cons.blanc().withOpacity(.5),
                size: 30,
              ),
              Spacer(),
            ],
          ),
          decoration: BoxDecoration(
              color: cons.vert(), borderRadius: BorderRadius.circular(30)),
        ));
  }
}
