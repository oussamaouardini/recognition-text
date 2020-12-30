import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_recognition_app/utilities/size_config.dart';
import 'package:text_recognition_app/utilities/styles.dart';

class SettingScreen extends StatefulWidget {
  Function callback;

  SettingScreen({this.callback});

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
        child: Scaffold(
          backgroundColor: isDark? kDarkModeLight:Colors.white,
      appBar: AppBar(
        backgroundColor: isDark
            ? kDarkMode
            : kDotColor ,
        elevation: 0.0,
        title: Text("Settings",style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Theme: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: SizeConfig.blockSizeHorizontal*4),),
            Container(
              margin: EdgeInsets.all(8),
              width: double.infinity,
              height: SizeConfig.blockSizeVertical * 20,
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                        onTap: (){
                          Get.changeTheme(ThemeData.light());
                          setState(() {
                            isDark = false;
                          });
                          this.widget.callback(isDark);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Container(
                                width:double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue,width: 3)
                                ),
                                child: Image.asset("assets/images/light.png"),
                              ),
                              !isDark? Positioned(top:-12, right:-5,child: Icon(Icons.check,color: Colors.green,size: SizeConfig.blockSizeHorizontal*15,)):SizedBox(),
                            ],
                          ),
                        ),
                      )),
                  Expanded(
                      child: InkWell(
                        onTap: (){
                          Get.changeTheme(ThemeData.dark());
                          setState(() {
                            isDark = true;
                          });
                          this.widget.callback(isDark);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Container(
                                width:double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue,width: 3)
                                ),
                                child: Image.asset("assets/images/dark.png"),
                              ),
                              isDark? Positioned(top:-12, right:-5,child: Icon(Icons.check,color: Colors.green,size: SizeConfig.blockSizeHorizontal*15,)):SizedBox(),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
