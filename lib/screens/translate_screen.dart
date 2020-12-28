import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_recognition_app/utilities/size_config.dart';
import 'package:text_recognition_app/utilities/styles.dart';

class TranslateScreen extends StatefulWidget {
  @override
  _TranslateScreenState createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String dropdownValue1 = 'English';
  String dropdownValue2 = 'English';
  List<String> supportedLanguages = ['English', 'French', 'Spanish', '中国(China)'];
  TextEditingController _textEditingController1 ;
  TextEditingController _textEditingController2 ;

  @override
  void initState() {
     _textEditingController1 =TextEditingController();
     _textEditingController2 =TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController1.clear();
    _textEditingController2.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      key: _scaffoldKey,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          child: Icon(Icons.translate ),
          backgroundColor: Color(0xff01B0CD),
        ),
        backgroundColor: kColor,
        appBar: AppBar(
          backgroundColor: kColor,
          centerTitle: true,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xff01B0CD),
                ),
                height: 40,
                width: SizeConfig.blockSizeHorizontal * 70,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade300,
                              ),
                              height: 25,
                              child: Center(
                                child: DropdownButton<String>(
                                  value: dropdownValue1,
                                  iconSize: 24,
                                  elevation: 0,
                                  dropdownColor: Colors.white,
                                  underline: SizedBox(),
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                  onChanged: (String newValue) async {
                                    setState(() {
                                      dropdownValue1 = newValue;
                                    });
                                  },
                                  items: supportedLanguages
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: Text(value),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.yellow, shape: BoxShape.circle),
                          child: Center(
                              child: Icon(
                            Icons.compare_arrows_sharp,
                            size: 22,
                          )),
                        ),
                      ),
                      Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade300,
                              ),
                              height: 25,
                              child: Center(
                                child: DropdownButton<String>(
                                  value: dropdownValue2,
                                  iconSize: 24,
                                  elevation: 0,
                                  dropdownColor: Colors.white,
                                  underline: SizedBox(),
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                  onChanged: (String newValue) async {
                                    setState(() {
                                      dropdownValue2 = newValue;
                                    });
                                  },
                                  items: supportedLanguages
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: Text(value),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ))),
                    ],
                  ),
                ),
              )),
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Get.back();
              }),
          title: Text("Translate", style: GoogleFonts.poppins()),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Container(
              height: SizeConfig.blockSizeVertical * 82,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: SizeConfig.blockSizeVertical * 36,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: dropdownValue1+"..."
                        ),
                        maxLines: 20,
                      ),
                    ),
                    Container(
                      height: SizeConfig.blockSizeVertical * 36,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                            hintText: "Translation"
                        ),
                        maxLines: 20,
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
