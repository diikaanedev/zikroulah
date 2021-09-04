import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// ignore: unused_import
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:zikroulah/devices/laptop/main-laptop.dart';
import 'package:zikroulah/devices/phone/main-phone.dart';
import 'package:zikroulah/devices/phone/screens/get-starting-screen.dart';
import 'package:zikroulah/models/artiste-model.dart';
import 'package:zikroulah/models/song-model.dart';
import 'package:zikroulah/models/tarikha-model.dart';
import 'package:zikroulah/utils/constant-by-dii.dart';
import 'package:zikroulah/utils/get-type-device.dart';
import 'package:zikroulah/utils/type-device.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:statusbar/statusbar.dart' show StatusBar;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

late _MyAppState appState;

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() {
    appState = _MyAppState();
    return appState;
  }
}

double width = window.physicalSize.width;

class _MyAppState extends State<MyApp> {
  late DeviceType deviceType;
  late ConstantByDii cons;
  late TarikhaModel tarikha;
  late List<TarikhaModel> listeTarikha;
  late ArtisteModel artiste;
  late SongModel song;

  @override
  void initState() {
    super.initState();
    print(width);
    setState(() {
      deviceType = getDeviceType(width);
      cons = ConstantByDii();
      listeTarikha = [
        TarikhaModel(
            name: 'Coran', urlTof: 'assets/images/coran.png', listeArtiste: []),
        TarikhaModel(
            name: 'Layene',
            urlTof: 'assets/images/layene.png',
            listeArtiste: []),
        TarikhaModel(
            name: 'Mouride',
            urlTof: 'assets/images/mouride.png',
            listeArtiste: []),
        TarikhaModel(
            name: 'Tidiane',
            urlTof: 'assets/images/tidiane.png',
            listeArtiste: []),
        TarikhaModel(
            name: 'Niassene',
            urlTof: 'assets/images/niassene.png',
            listeArtiste: []),
        TarikhaModel(
            name: 'Khadre',
            urlTof: 'assets/images/khadre.png',
            listeArtiste: []),
      ];
    });
    StatusBar.color(cons.vert());
  }

  @override
  Widget build(BuildContext context) =>
      deviceType == DeviceType.LATOP ? mainLaptop() : mainPhone();
}
