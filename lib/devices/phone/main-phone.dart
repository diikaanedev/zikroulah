import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zikroulah/devices/phone/screens/artiste-abonnement-screen-phone.dart';
import 'package:zikroulah/devices/phone/screens/artiste-screen-phone.dart';
import 'package:zikroulah/devices/phone/screens/chargement-screen-phone.dart';
import 'package:zikroulah/devices/phone/screens/get-starting-02.dart';
import 'package:zikroulah/devices/phone/screens/get-starting-screen.dart';
import 'package:zikroulah/devices/phone/screens/home-screen-phone.dart';
import 'package:zikroulah/devices/phone/screens/song-screen.dart';
import 'package:zikroulah/devices/phone/screens/tarikha-screen.dart';
import 'package:zikroulah/main.dart';

MaterialApp mainPhone() => MaterialApp(
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Abel'),
      routes: {
        '/': (constext) => StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) =>
                  snapshot.hasData ? HomeScreenPhone() : GetStartingScreen(),
            ),
        '/chargement': (constext) => ChargementScreenPhone(),
        '/tarikha': (constext) => TarikhaScreen(titleTarikha: appState.tarikha),
        // '/artiste': (constext) => ArtisteScreen(artiste: appState.artiste),
        // '/song': (constext) => SongScreen(
        //       songModel: appState.song,
        //     ),
        '/artiste-abonnement': (context) => ArtisteAbonnementScreenPhone(),
        '/get-starting-02': (context) => GetStarting02Screen(),
      },
    );
