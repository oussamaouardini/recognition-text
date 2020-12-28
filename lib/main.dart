import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:text_recognition_app/screens/loading_screen.dart';
void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Text Recognition',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: LoadingScreen(),
     // home: AnimationTransferScreen(length: 20,),
    );
  }
}
