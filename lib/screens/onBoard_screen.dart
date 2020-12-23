import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_recognition_app/screens/home_screen.dart';
import 'package:text_recognition_app/utilities/size_config.dart';
import 'package:text_recognition_app/utilities/styles.dart';



class OnBoardScreen extends StatefulWidget {
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal * 1.3),
      height: SizeConfig.blockSizeVertical * 1.1,
      width: isActive
          ? SizeConfig.blockSizeHorizontal * 7
          : SizeConfig.blockSizeHorizontal * 5,
      decoration: BoxDecoration(
        color: isActive ? kDotColor :  Color(0xff99DDC8),
        borderRadius: BorderRadius.all(
            Radius.circular(SizeConfig.blockSizeHorizontal * 1)),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: SizeConfig.blockSizeVertical * 80,
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () async {
                              SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                              await prefs.setBool('seen', true);
                              Get.offAll(MyHomePage());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Skip >",style: GoogleFonts.roboto(
                                  fontSize: SizeConfig.blockSizeHorizontal*4.5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade600
                                ) ,),
                              ],
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(
                                SizeConfig.blockSizeHorizontal * 10)),
                            child: Image(
                              image: AssetImage(
                                'assets/images/1.png',
                              ),
                              fit: BoxFit.cover,
                              height: SizeConfig.blockSizeVertical * 40,
                              width: SizeConfig.blockSizeHorizontal * 80,
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 4,
                          ),
                          Text(
                            'Scan Images Fast & Easy',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: kTitleStyle,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Text(
                              'Turn your photographs of text into an editable and searchable text with just a few clicks.',
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              style: kSubtitleStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () async {
                              SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                              await prefs.setBool('seen', true);
                              Get.offAll(MyHomePage());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Skip >",style: GoogleFonts.roboto(
                                    fontSize: SizeConfig.blockSizeHorizontal*4.5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade600
                                ) ,),
                              ],
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(
                                SizeConfig.blockSizeHorizontal * 10)),
                            child: Image(
                              image: AssetImage(
                                'assets/images/2.png',
                              ),
                              fit: BoxFit.cover,
                              height: SizeConfig.blockSizeVertical * 40,
                              width: SizeConfig.blockSizeHorizontal * 80,
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 4,
                          ),
                          Text(
                            'Translate to over 6 supported languages',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: kTitleStyle,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Text(
                              'Having difficulty translating words from printed posts? Once you have scanned an image, we can translate it for you.',
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              style: kSubtitleStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () async {
                              SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                              await prefs.setBool('seen', true);
                              Get.offAll(MyHomePage());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Skip >",style: GoogleFonts.roboto(
                                    fontSize: SizeConfig.blockSizeHorizontal*4.5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade600
                                ) ,),
                              ],
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(
                                SizeConfig.blockSizeHorizontal * 10)),
                            child: Image(
                              image: AssetImage(
                                'assets/images/3.png',
                              ),
                              fit: BoxFit.cover,
                              height: SizeConfig.blockSizeVertical * 40,
                              width: SizeConfig.blockSizeHorizontal * 80,
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 4,
                          ),
                          Text(
                            'Copy, share and export to pdf or document format',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: kTitleStyle,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Text(
                              'It\s easy to share or export to pdf or docs format without the need to copying and pasting to external word processing program.',
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              style: kSubtitleStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
              Expanded(
                child: InkWell(
                  onTap: _currentPage != _numPages - 1? () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }:()async{
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setBool('seen', true);
                    Get.offAll(MyHomePage());
                  },
                  child: _currentPage != _numPages - 1?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:100.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: kDotColor,
                                border: Border.all(
                                  color: kDotColor,
                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(30.0))),
                            child: Center(
                              child: Text(
                                'NEXT',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.blockSizeHorizontal * 6,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ):
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:70.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 50.0,
                            decoration: BoxDecoration(
                                color: kDotColor,
                                border: Border.all(
                                  color: kDotColor,
                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(30.0))),
                            child: Center(
                              child: Text(
                                'SCAN IMAGE NOW',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.blockSizeHorizontal * 6,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}