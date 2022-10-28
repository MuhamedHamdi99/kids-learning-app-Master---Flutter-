import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'getstart.dart';
import 'help.dart';
import 'login.dart';
import 'package:flutter/services.dart';


List<CameraDescription> cameras;

  Future <void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([

    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,

  ]);

  await Firebase.initializeApp();
  cameras= await availableCameras();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: Sizer(
        builder: (context,orientation,deviceType){
          return  MaterialApp(
            title: 'Kids_Learning',
            debugShowCheckedModeBanner: false,
            home: getstart(),
          );

        },

      ),
    );
  }
}
