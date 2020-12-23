import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:text_recognition_app/utilities/size_config.dart';

Color kTitleStyleTextColor = Color(0xff343434);
Color kSubtitleStyleTextColor = Color(0xffC2C2CC);
Color kDotColor = Color(0xff00c4e6);
Color kColor = Color(0xff00c4e6);
Color kYellowColor = Color(0xffFFF12C);
Color kTextColor = Color(0xff00c4e6);
Color kActiveTabColor = Color(0xff015B6C);
Color kTabListColor = Color(0xff015E6F);
Color kUnselectedTabColor = Color(0xff0E99AE);

final kTitleStyle = GoogleFonts.sansita(
  textStyle: TextStyle(
    color: kTitleStyleTextColor,
    fontSize: SizeConfig.blockSizeHorizontal * 6.5,
    fontWeight: FontWeight.bold
  )
);

final kSubtitleStyle = GoogleFonts.montserrat(
  textStyle: TextStyle(
    color: Colors.grey.shade500,
    fontSize: SizeConfig.blockSizeHorizontal * 4,
  )
);