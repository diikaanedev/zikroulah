import 'package:flutter/material.dart';
import 'package:statusbar/statusbar.dart';
import 'package:zikroulah/devices/phone/widgets/card-categorie-widget-phone.dart';
import 'package:zikroulah/devices/phone/widgets/card-menu-buttom-widget.dart';
import 'package:zikroulah/main.dart';
import 'package:zikroulah/utils/constant-by-dii.dart';

class HomeScreenPhone extends StatefulWidget {
  @override
  _HomeScreenPhoneState createState() => _HomeScreenPhoneState();
}

class _HomeScreenPhoneState extends State<HomeScreenPhone> {
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
    StatusBar.color(cons.blanc());
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cons.blanc(),
        elevation: 0,
        toolbarHeight: .0,
      ),
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            color: cons.blanc(),
          ),
          Positioned(
              child: Container(
            height: size.height * .05,
            width: size.width,
            color: cons.blanc(),
            child: Row(
              children: [
                SizedBox(
                  width: size.width * .05,
                ),
                Container(
                  width: size.height * .03,
                  height: size.height * .03,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.height * .05),
                      color: cons.vert()),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 16,
                      color: cons.blanc(),
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  'Zikroula',
                  style: TextStyle(
                      color: cons.vert(),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Icon(
                  Icons.more_vert_outlined,
                  color: cons.vert(),
                  size: 28,
                ),
                SizedBox(
                  width: size.width * .05,
                ),
              ],
            ),
          )),
          Positioned(
              top: size.height * .05,
              child: Container(
                height: size.height * .8,
                width: size.width,
                // color: cons.noir(),
                child: Column(
                  children: [
                    Spacer(),
                    Container(
                      height: size.height * .05,
                      width: size.width * .95,
                      child: Row(
                        children: [
                          SizedBox(
                            width: size.width * .03,
                          ),
                          Icon(
                            Icons.mic_sharp,
                            color: cons.vert(),
                          ),
                          Spacer(),
                          Text(
                            'Artistes, Titres , Playlist ...',
                            style: TextStyle(
                                color: cons.noir(),
                                fontSize: 16,
                                fontWeight: FontWeight.w200),
                          ),
                          Spacer(),
                          Icon(
                            Icons.search_outlined,
                            size: 24,
                            color: cons.noir(),
                          ),
                          SizedBox(
                            width: size.width * .07,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          // color: cons.vert(),
                          border: Border.all(color: cons.vert(), width: .8),
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    Spacer(),
                    Container(
                      height: size.height * .7,
                      width: size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.count(
                          crossAxisCount: 2,
                          physics: BouncingScrollPhysics(),
                          children: getListe(),
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              )),
          CardMenuButtomWidget()
        ],
      ),
    );
  }

  getListe() {
    List<Widget> liste = [];

    for (var item in appState.listeTarikha) {
      liste.add(
        Container(
          height: size.height * .25,
          width: size.width * .45,
          child: CardCategorieWidgetPhone(
            tarikhaModel: item,
          ),
        ),
      );
    }

    return liste;
  }
}
