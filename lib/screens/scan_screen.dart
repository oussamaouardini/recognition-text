import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:text_recognition_app/blocks/DBProvider_block.dart';
import 'package:text_recognition_app/controllers/scanResult_controller.dart';
import 'package:text_recognition_app/models/ScanResult.dart';
import 'package:text_recognition_app/screens/animation_transfer_file.dart';
import 'package:text_recognition_app/screens/my-documents_screen.dart';
import 'package:text_recognition_app/screens/scanedFiles_screen.dart';
import 'package:text_recognition_app/utilities/size_config.dart';
import 'package:text_recognition_app/utilities/styles.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  /// file to store image
  File pickedImage;
  bool isImage = false;
  bool isList = true;

  String errorText = "";
  TextEditingController _textEditingController = TextEditingController();

  bool isDark;

  Future pickImage() async {
    try {
      var tempStorage =
          await ImagePicker.pickImage(source: ImageSource.gallery);

      if (tempStorage != null) {
        setState(() {
          pickedImage = tempStorage;
          isImage = true;
        });
        Get.to(AnimationTransferScreen(
          pickedImage: pickedImage,
          callback: refresh,
        ));
      }
    } catch (e) {}
  }

  Future tackImage() async {
    try {
      var tempStorage = await ImagePicker.pickImage(source: ImageSource.camera);

      if (tempStorage != null) {
        setState(() {
          pickedImage = tempStorage;
          isImage = true;
        });
        Get.to(AnimationTransferScreen(
          pickedImage: pickedImage,
          callback: refresh,
        ));
      }
    } catch (e) {}
  }

  /// Function to initialise and fetch data
  Future initTables() async {
    ///create database table if it does not exist
    bool db = await SqLiteDB().exists("ScanResult");
    if (db == false) {
      try {
        ScanResult(null, null).createResultsTable();
      } catch (e) {}
    }
    _scanResultController.getResultScan();
    setState(() {});
  }

  void refresh() async {
    List<Map<String, dynamic>> temp =
        await _scanResultController.getResultScan();
    setState(() {
      _scanResultController.scanListData = temp;
    });
  }



  @override
  void initState() {
    isDark = Get.isDarkMode;
    initTables();
    super.initState();
  }

  final ScanResultController _scanResultController =
      Get.put(ScanResultController());

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    _scanResultController.getResultScan();
    SizeConfig().init(context);
    return SafeArea(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color(0xffFEF229),
          foregroundColor: Colors.black,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return Container(
                  height: SizeConfig.blockSizeVertical * 35,
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: <Widget>[
                      Positioned(
                        top: MediaQuery.of(context).size.height / 25,
                        left: 0,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: isDark?kDarkModeLight:Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 2 - 340,
                        left: 0.0,
                        child: Container(
                          width: SizeConfig.blockSizeHorizontal * 100,
                          height: SizeConfig.blockSizeVertical * 100,
                          child: SingleChildScrollView(
                              child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: SizeConfig.blockSizeHorizontal * 90,
                                  height: SizeConfig.blockSizeVertical * 5,
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 3,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                            child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.redAccent,
                                              fontSize: 14),
                                        )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                "Import an image to be converted",
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(color: Colors.grey)),
                              ),
                              SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1),
                              Container(
                                width: SizeConfig.blockSizeHorizontal * 50,
                                child: FlatButton(
                                  onPressed: tackImage,
                                  color: kYellowColor,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 10,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4.0),
                                          child: Icon(Icons.camera_alt, color:Colors.black),
                                        ),
                                      ),
                                      Expanded(
                                          child: Center(
                                              child: Text(
                                        'TAKE A PICTURE',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold, color:Colors.black),
                                      )))
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: SizeConfig.blockSizeHorizontal * 50,
                                child: FlatButton(
                                  onPressed: pickImage,
                                  color: kYellowColor,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 10,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4.0),
                                          child: Icon(Icons.image, color:Colors.black),
                                        ),
                                      ),
                                      Expanded(
                                          child: Center(
                                              child: Text('GALLERY',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold, color:Colors.black ))))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          icon: Icon(Icons.import_contacts_rounded),
          label: Text(
            'SCAN ∨',
            style: GoogleFonts.abel(fontWeight: FontWeight.bold),
          ),
        ),
        appBar: AppBar(
          backgroundColor: isDark? kDarkMode :kColor,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Get.back();
              }),
          actions: [
            IconButton(
                icon: !isList == true
                    ? Icon(Icons.view_list)
                    : Icon(Icons.grid_view),
                onPressed: () {
                  setState(() {
                    isList = !isList;
                  });
                }),
          ],
          centerTitle: true,
          title: Text('My Scans',
              style: GoogleFonts.montserrat(fontWeight: FontWeight.w500)),
          bottom: TabBar(
            indicatorColor: kActiveTabColor,
            labelColor: kActiveTabColor,
            unselectedLabelColor: kUnselectedTabColor,
            tabs: [
              Tab(
                  child: Text(
                "My Scans",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              Tab(
                  child: Text("Documents",
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            isScrollable: false,
          ),
        ),
        body: TabBarView(
          children: [
            /// My Scan
            isList
                ? _scanResultController.scanListData.length > 0
                    ? ListView.builder(
                        itemCount: _scanResultController.scanListData.length,
                        itemBuilder: (context, index) {
                          DateTime now = DateTime.parse(_scanResultController
                              .scanListData[index]['dateTime']
                              .toString());
                          String formattedDate =
                              DateFormat('yyyy-MM-dd – kk:mm').format(now);
                          int id =
                              _scanResultController.scanListData[index]['id'];
                          return Container(
                            margin: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 8.0),
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: kTabListColor,
                                borderRadius: BorderRadius.circular(15.0)),
                            height: SizeConfig.blockSizeVertical * 13,
                            child: InkWell(
                              onTap: () {
                                Get.to(ScannedFilesScreen(scannedText:_scanResultController
                                    .scanListData[index]['textScanned']));
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: SizeConfig.blockSizeHorizontal * 30,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.grey)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text('${_scanResultController
                                          .scanListData[index]['textScanned']}',
                                        maxLines: 20,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                        fontSize: 8.0,
                                        color: Colors.black
                                      ),),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 5.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    _scanResultController
                                                        .scanListData[index]
                                                            ['name']
                                                        .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: SizeConfig
                                                                .blockSizeHorizontal *
                                                            4.5,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    maxLines: 1),
                                                Text(
                                                  formattedDate,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Flexible(
                                                flex: 3,
                                                child: IconButton(
                                                    icon: Icon(
                                                      Icons.mode_edit,
                                                      color: Colors.green,
                                                    ),
                                                    onPressed: () {
                                                      _textEditingController
                                                              .text =
                                                          _scanResultController
                                                                  .scanListData[
                                                              index]['name'];
                                                      Alert(
                                                          context: context,
                                                          title: "Save File",
                                                          content: Column(
                                                            children: <Widget>[
                                                              TextField(
                                                                controller:
                                                                    _textEditingController,
                                                                onChanged:
                                                                    (value) {
                                                                  value.length >
                                                                          3
                                                                      ? errorText =
                                                                          ""
                                                                      : errorText =
                                                                          "title length must be longer 3 characters";
                                                                },
                                                                decoration: InputDecoration(
                                                                    icon: Icon(Icons
                                                                        .text_fields),
                                                                    labelText:
                                                                        'title',
                                                                    errorMaxLines:
                                                                        1,
                                                                    errorText:
                                                                        errorText),
                                                              ),
                                                            ],
                                                          ),
                                                          buttons: [
                                                            DialogButton(
                                                              onPressed:
                                                                  errorText ==
                                                                          ""
                                                                      ? () {
                                                                          ScanResult
                                                                              .update(
                                                                            id,
                                                                            "${_textEditingController.text}",
                                                                          );
                                                                          _textEditingController
                                                                              .clear();
                                                                          Navigator.pop(
                                                                              context);
                                                                          refresh();
                                                                        }
                                                                      : null,
                                                              color:Colors.grey,
                                                              child: Text(
                                                                "Save",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                            )
                                                          ]).show();
                                                    }),
                                              ),
                                              Flexible(
                                                flex: 3,
                                                child: IconButton(
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                    onPressed: () {
                                                      SweetAlert.show(context,
                                                          subtitle: "Do you want to delete this Record",
                                                          style: SweetAlertStyle.confirm,
                                                          showCancelButton: true, onPress: (bool isConfirm) {
                                                            if(isConfirm){
                                                              SweetAlert.show(context,subtitle: "Deleting...", style: SweetAlertStyle.loading);
                                                              new Future.delayed(Duration.zero,()async{
                                                                _scanResultController
                                                                    .deleteScan(id);
                                                                refresh();
                                                                SweetAlert.show(context,subtitle: "Success!", style: SweetAlertStyle.success);
                                                              });
                                                            }else{
                                                              SweetAlert.show(context,subtitle: "Canceled!", style: SweetAlertStyle.error);
                                                            }
                                                            // return false to keep dialog
                                                            return false;
                                                          });
                                                      refresh();
                                                    }),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : noItem()
                : _scanResultController.scanListData.length > 0
                    ? GridView.builder(
                        itemCount: _scanResultController.scanListData.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                (orientation == Orientation.portrait) ? 2 : 3),
                        itemBuilder: (BuildContext context, int index) {
                          DateTime now = DateTime.parse(_scanResultController
                              .scanListData[index]['dateTime']
                              .toString());
                          String formattedDate =
                              DateFormat('yyyy-MM-dd – kk:mm').format(now);
                          int id =
                          _scanResultController.scanListData[index]['id'];
                          return InkWell(
                            onTap: () {
                              Get.to(ScannedFilesScreen(scannedText:_scanResultController
                                  .scanListData[index]['textScanned']));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: kTabListColor,
                                  borderRadius: BorderRadius.circular(15.0)),
                              margin: EdgeInsets.symmetric(horizontal:6.0,vertical: 7.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      flex: 4,
                                      child: Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(color: Colors.grey)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text('${_scanResultController
                                              .scanListData[index]['textScanned']}',
                                            maxLines: 20,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 8.0,
                                                color: Colors.black
                                            ),),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                                              children: [
                                                Flexible(
                                                  flex: 3,
                                                  child: Text(
                                                      _scanResultController
                                                          .scanListData[index]['name']
                                                          .toString(),
                                                      overflow: TextOverflow.ellipsis,
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: SizeConfig
                                                              .blockSizeHorizontal *
                                                              4,
                                                          fontWeight: FontWeight.bold),
                                                      maxLines: 1),
                                                ),
                                                Flexible(
                                                  flex: 3,
                                                  child: Text(
                                                    "$formattedDate",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(color: Colors.white,fontSize: SizeConfig.blockSizeHorizontal*3.42),
                                                    maxLines: 2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Flexible(
                                                flex: 3,
                                                child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                    icon: Icon(
                                                      Icons.mode_edit,
                                                      color: Colors.green,
                                                    ),
                                                    onPressed: () {
                                                      _textEditingController
                                                          .text =
                                                      _scanResultController
                                                          .scanListData[
                                                      index]['name'];
                                                      Alert(
                                                          context: context,
                                                          title: "Save File",
                                                          content: Column(
                                                            children: <Widget>[
                                                              TextField(
                                                                controller:
                                                                _textEditingController,
                                                                onChanged:
                                                                    (value) {
                                                                  value.length >
                                                                      3
                                                                      ? errorText =
                                                                  ""
                                                                      : errorText =
                                                                  "title length must be longer 3 characters";
                                                                },
                                                                decoration: InputDecoration(
                                                                    icon: Icon(Icons
                                                                        .text_fields),
                                                                    labelText:
                                                                    'title',
                                                                    errorMaxLines:
                                                                    1,
                                                                    errorText:
                                                                    errorText),
                                                              ),
                                                            ],
                                                          ),
                                                          buttons: [
                                                            DialogButton(
                                                              onPressed:
                                                              errorText ==
                                                                  ""
                                                                  ? () {
                                                                ScanResult
                                                                    .update(
                                                                  id,
                                                                  "${_textEditingController.text}",
                                                                );
                                                                _textEditingController
                                                                    .clear();
                                                                Navigator.pop(
                                                                    context);
                                                                refresh();
                                                              }
                                                                  : null,
                                                              color:Colors.grey,
                                                              child: Text(
                                                                "Save",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                    20),
                                                              ),
                                                            )
                                                          ]).show();
                                                    }),
                                              ),
                                              Flexible(
                                                flex: 3,
                                                child: IconButton(
                                                    padding: EdgeInsets.zero,
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                    onPressed: () {
                                                      SweetAlert.show(context,
                                                          subtitle: "Do you want to delete this Record",
                                                          style: SweetAlertStyle.confirm,
                                                          showCancelButton: true, onPress: (bool isConfirm) {
                                                            if(isConfirm){
                                                              SweetAlert.show(context,subtitle: "Deleting...", style: SweetAlertStyle.loading);
                                                              new Future.delayed(Duration.zero,()async{
                                                                _scanResultController
                                                                    .deleteScan(id);
                                                                refresh();
                                                                SweetAlert.show(context,subtitle: "Success!", style: SweetAlertStyle.success);
                                                              });
                                                            }else{
                                                              SweetAlert.show(context,subtitle: "Canceled!", style: SweetAlertStyle.error);
                                                            }
                                                            // return false to keep dialog
                                                            return false;
                                                          });
                                                    }),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : noItem(),

            /// My Docuemnts
            MyDocumentScreen(),
          ],
        ),
      ),
    ));
  }

  Widget noItem() {
    return Container(
      width: double.infinity,
      color: isDark? kDarkModeLight :Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/noscan.png"),
          Text("Sorry",
              style: GoogleFonts.share(
                  color: Color(0xff045E91),
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeHorizontal * 15)),
          Text(
            "No Scan Saved",
            style: GoogleFonts.share(
                color: Color(0xff34759E),
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.blockSizeHorizontal * 7),
          ),
        ],
      ),
    );
  }
}


