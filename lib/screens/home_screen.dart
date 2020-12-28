import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
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
  /// file to store image
  File pickedImage;

  bool isImage = false;

  Future pickImage() async {
    var tempStorage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = tempStorage;
      isImage = true;
    });
  }

  Future takeImage() async {
    var tempStorage = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      pickedImage = tempStorage;
      isImage = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: kColor,
        body: SingleChildScrollView(
          child: Container(
            height: SizeConfig.blockSizeVertical * 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                isImage
                    ? Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(pickedImage), fit: BoxFit.cover),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1,
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal * 40,
                  child: FlatButton(
                  //  onPressed: pickImage, TODO:
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
                        Expanded(child: InkWell(onTap:(){
                          Get.to(ScanScreen());
                        },child: Center(child: Text('Scan Text'))))
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
                    onPressed: pickImage,
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
                        Expanded(child: InkWell(onTap:(){
                          Get.to(TranslateScreen());
                        },child: Center(child: Text('Translation'))))
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
                    onPressed: pickImage,
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
                                child: InkWell(
                          onTap: () {
                            Get.to(SettingScreen());
                          },
                          child: Text(
                            'Settings',
                            style: TextStyle(color: Colors.black),
                          ),
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
