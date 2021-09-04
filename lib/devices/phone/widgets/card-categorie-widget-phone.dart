import 'package:flutter/material.dart';
import 'package:zikroulah/main.dart';
import 'package:zikroulah/models/tarikha-model.dart';
import 'package:zikroulah/utils/constant-by-dii.dart';

class CardCategorieWidgetPhone extends StatefulWidget {
  final TarikhaModel tarikhaModel;

  const CardCategorieWidgetPhone({Key? key, required this.tarikhaModel})
      : super(key: key);

  @override
  _CardCategorieWidgetPhoneState createState() =>
      _CardCategorieWidgetPhoneState();
}

class _CardCategorieWidgetPhoneState extends State<CardCategorieWidgetPhone> {
  late ConstantByDii cons;
  @override
  void initState() {
    super.initState();
    setState(() {
      cons = ConstantByDii();
    });
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: () {
            appState.setState(() {
              appState.tarikha = widget.tarikhaModel;
            });
            Navigator.pushNamed(context, '/tarikha');
          },
          child: Stack(
            children: [
              Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                color: cons.blanc(),
              ),
              Positioned(
                  // top: constraints.maxHeight * .03,
                  left: constraints.maxWidth * .1,
                  child: Container(
                    height: constraints.maxHeight * .85,
                    width: constraints.maxWidth * .8,
                    decoration: BoxDecoration(
                        // color: cons.vert(),
                        image: DecorationImage(
                            image: AssetImage(widget.tarikhaModel.urlTof),
                            fit: BoxFit.fill)),
                  )),
              Positioned(
                  top: constraints.maxHeight * .72,
                  left: constraints.maxWidth * .01,
                  child: Container(
                    height: constraints.maxHeight * .15,
                    width: constraints.maxWidth,
                    child: Center(
                      child: Text(
                        widget.tarikhaModel.name,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      );
}
