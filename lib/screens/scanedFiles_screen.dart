import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:text_recognition_app/utilities/size_config.dart';
import 'package:text_recognition_app/utilities/styles.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class ScannedFilesScreen extends StatefulWidget {
  String scannedText;

  ScannedFilesScreen({this.scannedText});

  @override
  _ScannedFilesScreenState createState() => _ScannedFilesScreenState();
}

class _ScannedFilesScreenState extends State<ScannedFilesScreen>
    with SingleTickerProviderStateMixin {



  /// Map de give IconData to the drop down item icon
  Map<String, IconData> iconDropDown = {
    'Save': Icons.save,
    'Text Settings': Icons.settings,
  };
  String dropdownValue = 'Save';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      key: _scaffoldKey,
      child: Scaffold(
        backgroundColor: kColor,
        appBar: AppBar(
          backgroundColor: kColor,
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: SizeConfig.blockSizeHorizontal * 30,
                  child: FlatButton(
                    height: 30.0,
                    onPressed: () {
                      Get.off(ScannedFilesScreen());
                    },
                    color: kYellowColor,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Icon(Icons.translate),
                        ),
                        Expanded(child: Center(child: Text('Translate')))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Get.back();
              }),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: DropdownButton<String>(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                iconSize: 24,
                elevation: 0,
                dropdownColor: Colors.white,
                underline: SizedBox(),
                style: TextStyle(color: Colors.grey,
                    fontWeight: FontWeight.bold),
                onChanged: (String newValue) async {
                  setState(() {
                    dropdownValue = newValue;
                  });
                  print(newValue);
                },
                items: <String>['Save', 'Text Settings']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          iconDropDown[value],
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:4.0),
                          child: Text(value),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            )
          ],
          title: Text("Scan Results", style: GoogleFonts.poppins()),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Container(
              height: SizeConfig.blockSizeVertical * 90,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(20))),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${widget.scannedText}",
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                  ),
                ],
              )),
        ),
        floatingActionButton: SpeedDial(
          // both default to 16
          marginRight: 18,
          marginBottom: 20,
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          // this is ignored if animatedIcon is non null
          // child: Icon(Icons.add),
          visible: true,
          // If true user is forced to close dial manually
          // by tapping main button and overlay is not rendered.
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          onOpen: () => print('OPENING DIAL'),
          onClose: () => print('DIAL CLOSED'),
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
                child: Icon(Icons.picture_as_pdf),
                backgroundColor: Colors.red,
                label: 'PDF',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () => print('FIRST CHILD')),
            SpeedDialChild(
              child: Icon(Icons.share),
              backgroundColor: Colors.green,
              label: 'Share',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: (){
                final RenderBox box = context.findRenderObject();
                Share.share("${widget.scannedText}",
                    subject: "Scanned Results",
                    sharePositionOrigin:
                    box.localToGlobal(Offset.zero) &
                    box.size);
              },
            )
          ],
        ),
      ),
    );
  }
}
