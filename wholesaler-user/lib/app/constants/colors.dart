import 'package:flutter/material.dart';

class MyColors {
  static const primary = Color(0xFFFFC846);
  static const secondaryColor = Color(0xFFB7B5B5);
  static const white = Color(0xFFFFFFFF);
  static const accentColor = Color(0xFFFFE800);
  static const pink = Color(0xFFFF97A6);
  static const flower = Color(0xFFFDCEB9);
  static const bloom = Color(0xFFFC8C64);
  static const header = Color(0xFFFFFFFF);
  static const onHeader = Color(0xFF000000);

  static const splashColor = Color.fromRGBO(22, 107, 154, 0.06);
  static const textPrimary = Color(0xFF0E5880);
  static const bgCard = Color(0xFFB3CDDD);
  static const onPrimary = Color(0xFFEDD8BE);
  static const background = Color(0xFFFFFFFF);
  static const background2 = Color(0xFFE4E5E5);

  static const icon = Color(0xFF1E2329);

  static const red = Color(0xFFFF433E);
  static const link = Color(0xFF166B9A);
  static const success = Color(0xFF0AA450);
  static const divider = Color(0xFFE4E5E5);
  static const subTitle = Color(0xFF4F5661);
  static const desc = Color(0xFF7C8799);
  static const desc2 = Color(0xFFB3B4B6);

  static const black = Color(0xFF000000);
  static const black1 = Color(0xFF535353); // Ex: product title
  static const black2 = Color(0xFF1A1311);
  static const black3 = Color(0xFF101010);
  static const black4 = Color(0xFF2E2E2E);
  static const black5 = Color(0xFF303030);

  static const grey1 = Color(0xFFEFEFEF);
  static const grey2 = Color(0xFF999999);
  static const grey3 = Color(0xFFF6F6F6);
  static const grey4 = Color(0xFFD0CFCF);
  static const grey5 = Color(0xFFFBFBFB);
  static const grey6 = Color(0xFFE5E5E5);
  static const grey7 = Color(0xFFF8F8F8);
  static const grey8 = Color(0xFFAEAEAE);
  static const grey9 = Color(0xFF707070);
  static const grey10 = Color(0xFFA4A4A4);
  static const grey11 = Color(0xFFCCCCCC);
  static const grey12 = Color(0xFFEFEFEF);
  static const grey13 = Color(0xFFCECECE);

  static const orange1 = Color(0xFFFFD83A);
  static const orange2 = Color(0xFFFFD153);
  static const orange3 = Color(0xFFFFC400);
  static const orange4 = Color(0xFFFFB300);

  static const bgArc = Color(0xFFF5F5F5);
  static const header2 = Color(0xFFF5F5F5);
  static const green = Color(0xFF0AA450);

  static const secondary = Color(0xFFFFDF00);
  static const textSecondary = Color(0xFFFFDF00);
  static const onSecondary = Color(0xFF1E2329);
  static const borderSecondary = Color(0xFFCFB503);

  static const disable = Color(0xFFF5F5F7);
  static const bgBottomNavigation = Color(0xFFFEFEFE);

  // static const unselectedItemColor = Color(0xFFAEAEAE);
  // static const selectedItemColor = Color(0xFF000000);

  // Number Widget Colors
  static const List numberColors = [
    Color(0xFFFFC846),
    Color(0xFF9695B2),
    Color(0xFFA26008),
    Color(0xFFFFB300),
    Color(0xFFFFE800),
    Color(0xFF9695B2),
    Color(0xFFA26008),
    Color(0xFFFFB300),
    Color(0xFFFFE800),
    Color(0xFF9695B2),
    Color(0xFFA26008),
    Color(0xFFFFB300),
    Color(0xFFA26008),
    Color(0xFFFFB300),
    Color(0xFFFFE800),
    Color(0xFF9695B2),
    Color(0xFFA26008),
    Color(0xFFFFB300),
    Color(0xFFA26008),
    Color(0xFFFFB300),
    Color(0xFFFFE800),
    Color(0xFF9695B2),
    Color(0xFFA26008),
    Color(0xFFFFB300),
  ];
}

extension ColorShades on Color {
  Color darker() {
    const int darkness = 10;
    int r = (red - darkness).clamp(0, 255);
    int g = (green - darkness).clamp(0, 255);
    int b = (blue - darkness).clamp(0, 255);
    return Color.fromRGBO(r, g, b, 1);
  }
}
