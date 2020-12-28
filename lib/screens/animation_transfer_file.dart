import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:text_recognition_app/screens/scanedFiles_screen.dart';
import 'package:text_recognition_app/utilities/size_config.dart';
import 'package:text_recognition_app/utilities/styles.dart';

// ignore: must_be_immutable
class AnimationTransferScreen extends StatefulWidget {
  File pickedImage;

  AnimationTransferScreen({this.pickedImage});

  @override
  _AnimationTransferScreenState createState() =>
      _AnimationTransferScreenState();
}

class _AnimationTransferScreenState extends State<AnimationTransferScreen> {
  bool isLoading = true;
  String scannedText = '';

  Future readText() async {
    setState(() {
      isLoading = true;
    });
    if (widget.pickedImage == null) {
      SweetAlert.show(context,
          title: "You didn't pick any image",
          subtitle: "your scan text won't work",
          style: SweetAlertStyle.error);
      Get.back();
    } else {
      FirebaseVisionImage img =
          FirebaseVisionImage.fromFile(widget.pickedImage);
      TextRecognizer recognizerText = FirebaseVision.instance.textRecognizer();
      VisionText readText = await recognizerText.processImage(img);
      for (TextBlock block in readText.blocks) scannedText += block.text + "\n";
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    readText();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: kColor,
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            isLoading == false
                ? CircularPercentIndicator(
                    radius: 120.0,
                    lineWidth: 5.0,
                    animation: true,
                    percent: 1,
                    center: new Text(
                      "Done!",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.blockSizeHorizontal * 7,
                          color: Colors.white),
                    ),
                    footer: Text("Text scan is 100% complete",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.blockSizeHorizontal * 4.5)),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.yellow,
                  )
                : SizedBox(),
            isLoading == true
                ? Center(
                    child: Text("Analyzing text layout...",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.blockSizeHorizontal * 4.5)),
                  )
                : SizedBox(),
            isLoading == true
                ? Center(
                    child: Text("Please be patient",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: SizeConfig.blockSizeHorizontal * 4)),
                  )
                : SizedBox(),
            isLoading == true
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Center(
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.yellow))),
                  )
                : SizedBox(),
            isLoading == true
                ? Center(
                    child: Text("This may take a while",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: SizeConfig.blockSizeHorizontal * 4)),
                  )
                : SizedBox(),
            isLoading == false
                ? Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 8.0),
                      width: SizeConfig.blockSizeHorizontal * 40,
                      child: FlatButton(
                        onPressed: () {
                          Get.off(ScannedFilesScreen(scannedText: scannedText));
                        },
                        color: kYellowColor,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: SizeConfig.blockSizeHorizontal * 10,
                              child: Icon(Icons.image),
                            ),
                            Expanded(child: Center(child: Text('See Results')))
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            Center(
                child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(
                  color: Colors.pink,
                ),
              ),
              color: Colors.pink,
              onPressed: () {
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  "X  Cancel",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )),
          ]),
        ),
      ),
    );
  }
}
