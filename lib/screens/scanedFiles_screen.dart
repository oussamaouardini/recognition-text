import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class ScannedFilesScreen extends StatefulWidget {
  @override
  _ScannedFilesScreenState createState() => _ScannedFilesScreenState();
}

class _ScannedFilesScreenState extends State<ScannedFilesScreen> with SingleTickerProviderStateMixin {
  /*bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this,duration:
    Duration(milliseconds: 500))
                           ..addListener(() {
                             setState(() {});
                           });
    _animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.00, 1.00,curve: Curves.linear),
    ));
    _translateButton = Tween<double>(begin: _fabHeight, end: -14.0).
    animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.00, 0.75,
          curve: _curve ),
    ));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate(){
    if(!isOpened){
      _animationController.forward();
    }else{
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget add(){
    return Container(
      child: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Add',child:Icon(Icons.add),
      ),
    );
  }
  Widget image(){
    return Container(
      child: FloatingActionButton(
        onPressed: (){},
        tooltip: 'image',child:Icon(Icons.image),
      ),
    );
  }

  Widget inbox(){
    return Container(
      child: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Inbox',child:Icon(Icons.inbox),
      ),
    );
  }

  Widget toggle(){
    return Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(icon: AnimatedIcons.menu_close, progress: _animateIcon),
      ),
    );
  }*/


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,

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
                onTap: () => print('FIRST CHILD')
            ),
            SpeedDialChild(
              child: Icon(Icons.share),
              backgroundColor: Colors.blue,
              label: 'Share',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => print('SECOND CHILD'),
            ),
            SpeedDialChild(
              child: Icon(Icons.copy),
              backgroundColor: Colors.green,
              label: 'Copy',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => print('THIRD CHILD'),
            ),
          ],
        ),
      ),
    );
  }
}
