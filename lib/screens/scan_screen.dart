import 'dart:io';
import 'dart:ui';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:text_recognition_app/screens/animation_transfer_file.dart';
import 'package:text_recognition_app/screens/scanedFiles_screen.dart';
import 'package:text_recognition_app/utilities/size_config.dart';
import 'package:text_recognition_app/utilities/styles.dart';


class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  /// file to store image
  File pickedImage;
  bool isImage = false;
  bool isList = true;


  Future pickImage() async {
    var tempStorage = await ImagePicker.pickImage(source: ImageSource.gallery);

    if(tempStorage!= null){
      setState(() {
        pickedImage = tempStorage;
        isImage = true;
      });
      Get.to(AnimationTransferScreen(pickedImage:pickedImage,));
    //  Get.to(AnimationTransferScreen());
    }


  }


  @override
  Widget build(BuildContext context) {
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
                            color: Colors.white,
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
                                          child: Icon(Icons.camera_alt),
                                        ),
                                      ),
                                      Expanded(
                                          child: Center(
                                              child:
                                                  Text('TAKE A PICTURE')))
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
                                          child: Icon(Icons.image),
                                        ),
                                      ),
                                      Expanded(
                                          child: Center(
                                              child: Text('GALLERY')))
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
          backgroundColor: kColor,
          elevation: 0.0,
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
            Get.back();
          }),
          actions: [
            IconButton(icon: isList==true?Icon(Icons.view_list):Icon(Icons.grid_view), onPressed: () {
              setState(() {
                isList=!isList;
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
              Tab(child: Text("My Scans")),
              Tab(child: Text("Documents")),
            ],
            isScrollable: false,
          ),
        ),
        body: TabBarView(
          children: [
            /// My Scan
            isList?ListView(children: [
              Container(
                margin: const EdgeInsets.only(left:8.0,right:8.0,top:8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: kTabListColor,
                    borderRadius: BorderRadius.circular(15.0)),
                height: SizeConfig.blockSizeVertical * 13,
                child: InkWell(
                  onTap: (){
                    Get.to(ScannedFilesScreen());
                  },
                  child: Row(
                    children: [
                      Image.asset("assets/images/1.png",width: SizeConfig.blockSizeHorizontal*30,fit: BoxFit.fill,),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hello this is title ",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.white,
                                      fontSize: SizeConfig.blockSizeHorizontal*4.5,
                                      fontWeight: FontWeight.bold
                                  ),
                                  maxLines: 1),
                              Text(
                                "27/12/2021",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left:8.0,right:8.0,top:8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: kTabListColor,
                    borderRadius: BorderRadius.circular(15.0)),
                height: SizeConfig.blockSizeVertical * 13,
                child: InkWell(
                  onTap: (){
                    Get.to(ScannedFilesScreen());
                  },
                  child: Row(
                    children: [
                      Image.asset("assets/images/1.png",width: SizeConfig.blockSizeHorizontal*30,fit: BoxFit.fill,),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hello this is title ",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.white,
                                      fontSize: SizeConfig.blockSizeHorizontal*4.5,
                                      fontWeight: FontWeight.bold
                                  ),
                                  maxLines: 1),
                              Text(
                                "27/12/2021",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]
            ):
            GridView.count(
              crossAxisCount: 2,
              children: [
                InkWell(
                  onTap: (){
                    Get.to(ScannedFilesScreen());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: kTabListColor,
                        borderRadius: BorderRadius.circular(15.0)),
                    margin: EdgeInsets.all(8.0),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 5,
                            child: Image.asset("assets/images/1.png",fit: BoxFit.fill,
                              width: double.infinity,),

                          ),

                          Flexible(
                            flex: 1,
                            child: Text("Hello this is title",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white,
                                    fontSize: SizeConfig.blockSizeHorizontal*4,
                                  fontWeight: FontWeight.bold
                                ),
                                maxLines: 1),
                          ),
                          Flexible(
                            flex: 1,
                            child: Text(
                              "27/12/2021",
                              style: TextStyle(color: Colors.white),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Get.to(ScannedFilesScreen());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: kTabListColor,
                        borderRadius: BorderRadius.circular(15.0)),
                    margin: EdgeInsets.all(8.0),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 5,
                            child: Image.asset("assets/images/1.png",fit: BoxFit.fill,
                              width: double.infinity,),

                          ),

                          Flexible(
                            flex: 1,
                            child: Text("Hello this is title",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white,
                                    fontSize: SizeConfig.blockSizeHorizontal*4,
                                    fontWeight: FontWeight.bold
                                ),
                                maxLines: 1),
                          ),
                          Flexible(
                            flex: 1,
                            child: Text(
                              "27/12/2021",
                              style: TextStyle(color: Colors.white),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Get.to(ScannedFilesScreen());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: kTabListColor,
                        borderRadius: BorderRadius.circular(15.0)),
                    margin: EdgeInsets.all(8.0),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 5,
                            child: Image.asset("assets/images/1.png",fit: BoxFit.fill,
                              width: double.infinity,),

                          ),

                          Flexible(
                            flex: 1,
                            child: Text("Hello this is title",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white,
                                    fontSize: SizeConfig.blockSizeHorizontal*4,
                                    fontWeight: FontWeight.bold
                                ),
                                maxLines: 1),
                          ),
                          Flexible(
                            flex: 1,
                            child: Text(
                              "27/12/2021",
                              style: TextStyle(color: Colors.white),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Get.to(ScannedFilesScreen());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: kTabListColor,
                        borderRadius: BorderRadius.circular(15.0)),
                    margin: EdgeInsets.all(8.0),

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 5,
                            child: Image.asset("assets/images/1.png",fit: BoxFit.fill,
                              width: double.infinity,),

                          ),

                          Flexible(
                            flex: 1,
                            child: Text("Hello this is title",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white,
                                    fontSize: SizeConfig.blockSizeHorizontal*4,
                                    fontWeight: FontWeight.bold
                                ),
                                maxLines: 1),
                          ),
                          Flexible(
                            flex: 1,
                            child: Text(
                              "27/12/2021",
                              style: TextStyle(color: Colors.white),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            /// My Scan
            Container(),
          ],
        ),
      ),
    ));
  }
}

class Modal {
  mainBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: SizeConfig.blockSizeVertical * 35,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                    color: Colors.white,
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
                                width: SizeConfig.blockSizeHorizontal * 3,
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
                        height: SizeConfig.blockSizeVertical * 1,
                      ),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 50,
                        child: FlatButton(
                          onPressed: () {},
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
                                  child: Icon(Icons.camera_alt),
                                ),
                              ),
                              Expanded(
                                  child: Center(
                                      child: Text('TAKE A PICTURE')))
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 50,
                        child: FlatButton(
                          onPressed: () {},
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
                                  child: Center(child: Text('GALLERY')))
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
  }
}
