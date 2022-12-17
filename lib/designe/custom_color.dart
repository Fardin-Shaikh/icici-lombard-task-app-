import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class customcolor {
  static const orange = const Color(0xffEC6608);
  static const orangelight = const Color(0xffFCAD43);
  static const pink = const Color(0xffFF5858);
  static const taborange = const Color(0xffEC660829);
  static const ligthgrey = const Color(0xffB6B4B4);
  static const darkgrey = const Color(0xff969494);
  static const blue = const Color(0xff005B76);
  static const white = const Color(0xffffffff);
  static const textheadlinecolor = const Color(0xff333333);
  static const greybackgroundcolor = const Color(0xff444444);
  static const greentext = const Color(0xff82BF65);
  static const yellowtext = const Color(0xffFFBB34);
  static const redtext = const Color(0xffFF5858);
  static const skyblue = const Color(0xff1A9CFF);
  static const textlightblack = const Color(0xff333333);
  static const circularYellow = const Color(0xffFFBB34);
  static const circularGreen = const Color(0xff82BF65);
  static const circularRed = const Color(0xffFF5858);
  // mycolors
  static const Color chip_back = Color.fromRGBO(255, 228, 175, 1.000);
  static const Color chip_forground = Color.fromRGBO(255,187,52,1.000);
  static const Color Ice_blur = Color.fromRGBO(172, 188, 203, 1.000);
  static const Color black = Color.fromARGB(255, 0, 0, 0);
  static const Color morang_light = Color.fromRGBO(247, 220, 203, 1.000);
  static const Color morang_dark = Color.fromRGBO(217, 101, 20, 1.000);
  static const Color back_white = Color.fromRGBO(250, 250, 250, 1.000);
  static const Color dark_grey_icons = Color.fromRGBO(51, 51, 51, 1.000);
  static const Color blue_textbutton = Color.fromRGBO(36, 160, 255, 1.000);
  static const Color green_chip_back = Color.fromRGBO(215,234,205,1.000);
  static const Color green_chip_front = Color.fromRGBO(130,191,101,1.000);
  static const Color red_chip_back = Color.fromRGBO(255,201,201,1.000);
  static const Color red_chip_front = Color.fromRGBO(255,88,88,1.000);

}

class textstyleclass {
  static TextStyle heading(BuildContext context) {
    return TextStyle(
      color: customcolor.blue,
      fontWeight: FontWeight.w700,
      fontSize: ResponsiveFlutter.of(context).fontSize(4),
    );
  }

  static TextStyle subtitle(BuildContext context) {
    return TextStyle(
      height: 1.5,
      color: customcolor.ligthgrey,
      fontWeight: FontWeight.normal,
      fontSize: ResponsiveFlutter.of(context).fontSize(1.5),
    );
  }

  static TextStyle normal_bold(BuildContext context) {
    return TextStyle(
      // height: 1,
      fontWeight: FontWeight.bold,
      fontSize: ResponsiveFlutter.of(context).fontSize(2.2),
    );
  }

  static TextStyle text_button(BuildContext context) {
    return TextStyle(
      color: customcolor.blue_textbutton,
      fontWeight: FontWeight.w500,
      fontSize: ResponsiveFlutter.of(context).fontSize(2),
    );
  }
}

class AppFonts {
  static String bold = "Muli-Bold";
  static String semibold = "Muli-SemiBold";
  static String normal = "Muli";
}
