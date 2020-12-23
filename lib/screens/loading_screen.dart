import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_recognition_app/screens/home_screen.dart';
import 'package:text_recognition_app/screens/onBoard_screen.dart';
import 'package:text_recognition_app/utilities/size_config.dart';
import 'package:text_recognition_app/utilities/styles.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    navigate();
    super.initState();
  }
  void navigate()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool seen = preferences.getBool("seen");
    seen==true?Get.offAll(MyHomePage()): Get.offAll(OnBoardScreen());
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: kColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo.png",height: SizeConfig.blockSizeVertical*25),
              CupertinoActivityIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
