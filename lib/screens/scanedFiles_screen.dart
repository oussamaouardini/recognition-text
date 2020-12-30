import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:share/share.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:text_recognition_app/models/ScanResult.dart';
import 'package:text_recognition_app/screens/translate_screen.dart';
import 'package:text_recognition_app/utilities/size_config.dart';
import 'package:text_recognition_app/utilities/styles.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

// ignore: must_be_immutable
class ScannedFilesScreen extends StatefulWidget {
  String scannedText;
  Function callback;

  /// this function to refresh the savedScans after saving
  ScannedFilesScreen({this.scannedText, this.callback});

  @override
  _ScannedFilesScreenState createState() => _ScannedFilesScreenState();
}

class _ScannedFilesScreenState extends State<ScannedFilesScreen>
    with SingleTickerProviderStateMixin {

  String errorText = "";
  String dropdownValue = 'Save';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _textEditingController = TextEditingController();
  bool isDark;

  @override
  void initState() {
    isDark = Get.isDarkMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      key: _scaffoldKey,
      child: Scaffold(
        backgroundColor: isDark? kDarkModeLight :kColor,
        appBar: AppBar(
          backgroundColor: isDark? kDarkMode :kColor,
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
                      Get.to(TranslateScreen(
                        textToTranslate: widget.scannedText,
                      ));
                    },
                    color: kYellowColor,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Icon(Icons.translate, color: Colors.black),
                        ),
                        Expanded(child: Center(child: Text('Translate',style: TextStyle(color: Colors.black),)))
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
                Get.back(result: [false]);
              }),
          actions: [
            IconButton(
              onPressed: (){
                Alert(
                    context: context,
                    title: "Save File",
                    style: AlertStyle(
                      titleStyle: TextStyle(
                        color: isDark?Colors.white:Colors.black
                      )
                    ),
                    content: Column(
                      children: <Widget>[
                        TextField(
                          controller: _textEditingController,
                          onChanged: (value) {
                            value.length > 3
                                ? errorText = ''
                                : errorText =
                            "title length must be longer 3 characters";
                          },
                          decoration: InputDecoration(
                              icon: Icon(Icons.text_fields),
                              labelText: 'title',
                              errorMaxLines: 1,
                              errorText: errorText,
                            errorStyle: TextStyle(color: Colors.red)
                          ),
                        ),
                      ],
                    ),
                    buttons: [
                      DialogButton(
                        onPressed: errorText == ""
                            ? () {

                            if(_textEditingController.text.length>3){
                              ScanResult.save(
                                  "${_textEditingController.text}",
                                  widget.scannedText);
                              _textEditingController.clear();
                              this.widget.callback();
                              Navigator.pop(context);
                            }


                        }
                            : null,
                        color:Colors.grey,
                        child: Text(
                          "Save",
                          style:
                          TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    ]).show();
              },
              icon:Icon(
                Icons.save,
              ),
            ),

          ],
          title: Text("Scan Results", style: GoogleFonts.poppins()),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Container(
              height: SizeConfig.blockSizeVertical * 90,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: isDark? kDarkModeLight :Colors.white,
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
                labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                labelBackgroundColor: Colors.grey,
                onTap: () async {
                  try {
                    final pdf = pw.Document();
                    pdf.addPage(pw.Page(
                        pageFormat: PdfPageFormat.a4,
                        build: (pw.Context context) {
                          return pw.Center(
                            // Todo: add a font to the pdf
                            child: pw.Text("Hello World",
                                style: pw.TextStyle(
                                    font: pw.Font.helvetica(),
                                    color: PdfColor.fromInt(22))),
                          ); // Center
                        }));
                    final output = await getTemporaryDirectory();
                    var fileNme = "${DateTime.now().toString()}.pdf";
                    final file = File("${output.path}/$fileNme");
                    await file.writeAsBytes(pdf.save());
                    await Printing.sharePdf(
                        bytes: pdf.save(), filename: '$fileNme');
                  } catch (Exception) {
                    print(Exception);
                    SweetAlert.show(context,
                        title: "Opps",
                        subtitle: "An error occured please try again!!!",
                        style: SweetAlertStyle.error);
                  }
                }),
            SpeedDialChild(
              child: Icon(Icons.share),
              backgroundColor: Colors.green,
              label: 'Share',
              labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
              labelBackgroundColor: Colors.grey,
              onTap: () {
                final RenderBox box = context.findRenderObject();
                Share.share("${widget.scannedText}",
                    subject: "Scanned Results",
                    sharePositionOrigin:
                        box.localToGlobal(Offset.zero) & box.size);
              },
            )
          ],
        ),
      ),
    );
  }
}
