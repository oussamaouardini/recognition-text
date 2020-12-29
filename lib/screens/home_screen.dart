import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:text_recognition_app/screens/scan_screen.dart';
import 'package:text_recognition_app/screens/settings_screen.dart';
import 'package:text_recognition_app/screens/translate_screen.dart';
import 'package:text_recognition_app/utilities/size_config.dart';
import 'package:text_recognition_app/utilities/styles.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: kColor,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: SizeConfig.blockSizeVertical * 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/images/logo.png",
                    height: SizeConfig.blockSizeVertical * 25),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                Text('WELCOME',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: SizeConfig.blockSizeHorizontal * 9)),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                Text('Import an image to be converted',
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: SizeConfig.blockSizeHorizontal * 4)),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1,
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal * 40,
                  child: FlatButton(
                    onPressed: () {
                      Get.to(ScanScreen());
                    },
                    color: kYellowColor,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 10,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Icon(Icons.image),
                          ),
                        ),
                        Expanded(
                            child: Center(
                                child: Text(
                          'Scan Text',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1,
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal * 40,
                  child: FlatButton(
                    onPressed: () {
                      Get.to(TranslateScreen(
                        textToTranslate: null,
                      ));
                    },
                    color: kYellowColor,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 10,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Icon(Icons.translate),
                          ),
                        ),
                        Expanded(
                            child: Center(
                                child: Text(
                          'Translation',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1,
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal * 40,
                  child: FlatButton(
                    onPressed: () {
                      Get.to(SettingScreen());
                    },
                    color: kYellowColor,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 10,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Icon(Icons.settings),
                          ),
                        ),
                        Expanded(
                            child: Center(
                                child: Text(
                          'Settings',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
