import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:text_recognition_app/utilities/size_config.dart';
import 'package:text_recognition_app/utilities/styles.dart';
import 'package:translator/translator.dart';

class TranslateScreen extends StatefulWidget {
  final textToTranslate;

  TranslateScreen({this.textToTranslate});

  @override
  _TranslateScreenState createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String dropdownValue1 = 'Automatic';
  String dropdownValue2 = 'English';
  List<String> sourceLanguages = [
    'Automatic',
    'English',
    'العربية(arabic)',
    'Russian',
    'French',
    'Spanish',
    '中国(Chinese)'
  ];
  List<String> supportedLanguages = [
    'English',
    'العربية(arabic)',
    'Russian',
    'French',
    'Spanish',
    '中国(Chinese)'
  ];
  TextEditingController _textEditingController1;
  TextEditingController _textEditingController2;
  bool loading = false;
  bool collapse1 = false;

  /// Map of language Codes
  Map<String, String> langCode = {
    'Automatic': 'auto',
    'English': 'en',
    'العربية(arabic)': 'ar',
    'French': 'fr',
    'Spanish': 'es',
    'Russian': 'ru',
    '中国(Chinese)': 'zh-tw'
  };

  /// Function of translation
  void translate() async {
    try {
      setState(() {
        loading = true;
      });
      final translator = GoogleTranslator();
      final input = _textEditingController1.text;
      var translation = await translator.translate(input,
          from: langCode[dropdownValue1], to: langCode[dropdownValue2]);
      setState(() {
        loading = false;
        _textEditingController2.text = translation.text;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  /// Function of sharing & copy text
  void copyShare(String text) {
    try {
      final RenderBox box = context.findRenderObject();
      Share.share("$text",
          subject: "Scanned Results",
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    } catch (e) {}
  }

  @override
  void initState() {
    _textEditingController1 = TextEditingController();
    _textEditingController2 = TextEditingController();

    /// Initialise the text
    if (widget.textToTranslate != null) {
      _textEditingController1.text = widget.textToTranslate;
    }
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
            translate();
          },
          child: loading == false
              ? Icon(Icons.translate)
              : CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
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
                width: SizeConfig.blockSizeHorizontal * 80,
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
                                  items: sourceLanguages
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
              height: SizeConfig.blockSizeVertical * 90,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "$dropdownValue1",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            child: Row(
                              children: [
                                IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(Icons.copy),
                                    onPressed: () {
                                      copyShare(_textEditingController1.text);
                                    }),
                                IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(Icons.share),
                                    onPressed: () {
                                      copyShare(_textEditingController1.text);
                                    }),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(collapse1 == true
                                      ? Icons.keyboard_arrow_down
                                      : Icons.keyboard_arrow_up),
                                  onPressed: () {
                                    setState(() {
                                      collapse1 = !collapse1;
                                    });
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: collapse1 == false
                          ? SizeConfig.blockSizeVertical * 25
                          : SizeConfig.blockSizeVertical * 0,
                      child: TextFormField(
                        controller: _textEditingController1,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: dropdownValue1 + "..."),
                        maxLines: 25,
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "$dropdownValue2",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            child: Row(
                              children: [
                                IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(Icons.copy),
                                    onPressed: () {
                                      copyShare(_textEditingController2.text);
                                    }),
                                IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(Icons.share),
                                    onPressed: () {
                                      copyShare(_textEditingController2.text);
                                    }),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      height: collapse1 == false
                          ? SizeConfig.blockSizeVertical * 36
                          : SizeConfig.blockSizeVertical * 62,
                      child: TextFormField(
                        readOnly: true,
                        controller: _textEditingController2,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Translation"),
                        maxLines: collapse1 == false ? 20 : 30,
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
