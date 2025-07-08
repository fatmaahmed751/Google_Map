import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/Theme/theme_model.dart';
import '../core/Theme/theme_provider.dart';

class ThemeClass extends ThemeModel{

  static ThemeModel of(BuildContext context) => Provider.of<ThemeProvider>(context,listen: false).appTheme;


  static List<Color> get backgroundGradiant => const [
    const Color(0xff2890b2),
   // Color.fromRGBO(33, 89, 115, 1),
    Color.fromRGBO(63, 106, 217, 0.5),

  ];

  ThemeClass.lightTheme({
    super.isDark = false,
    super.background = const Color(0xffFAFAFA),
    super.primaryColor = const Color(0xff215973),
    super.mainSecondary = const Color(0xff2890b2),
    super.secondary = const Color(0xffE89A4F),
    super.labelColor = const Color(0xffCFD2D1),
    super.mainBlack = const Color(0xff0F1010),
    super.secondaryBlackColor = const Color(0xff5A605F),
    super.waiting = const Color(0xffE6E7E7),
    super.cancel = const Color(0xffC93939),
    super.success = const Color(0xffD7F1F6),
    super.containerColor = const Color(0xffF2FBFD),
    super.hintText =  const Color(0xff5a605f),
    super.textFieldBackground = const Color(0xffFFFFFF),
    super.successState =const Color(0xff249663),


  });

  ThemeClass.darkTheme({
    super.isDark = true,
    super.background = const Color(0xff181818),
    super.primaryColor = const Color(0xff6AAFCC),
    super.mainSecondary = const Color(0xff2890b2),
    super.secondary = const Color(0xffE89A4F),
    super.success = const Color(0xffD7F1F6),
    super.waiting = const Color(0xff1ae6e7e7),
    super.cancel = const Color(0xffB84545),
  super.containerColor = const Color(0xff1E1F1F),
    super.labelColor = const Color(0xff3D403F),
    super.mainBlack = const Color(0xffD8DADA),
    super.secondaryBlackColor = const Color(0xffACB0B0),
    super.hintText =  const Color(0xff999E9D),
    super.textFieldBackground = const Color(0xff1A1A1A),
    super.successState =const Color(0xff249663),
  });
}
class BackGroundClass {

  static List<Color> get backgroundGradiant => const [
    Color.fromRGBO(241, 128, 107, 0.19),
    Color.fromRGBO(236, 174, 114, 0.28),
    Color.fromRGBO(244, 201, 150, 0.23),
    Color.fromRGBO(163, 114, 80, 0.25),
    Color.fromRGBO(210, 199, 238, 0.22),
    Color.fromRGBO(254, 242, 205, 0.69),
  ];

}