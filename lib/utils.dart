import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyle(double size, [Color? color, FontWeight? fw]) {
  return GoogleFonts.montserrat(
    fontSize: size, 
    color: color, 
    fontWeight: fw,
    
  );
}

TextStyle textStyleDecorated(
  double size, {
  Color? color,
  FontWeight? fw,
  TextDecoration? decoration,
  Color? decorationColor,
  double? decorationThickness,
}) {
  return GoogleFonts.montserrat(
    fontSize: size,
    color: color,
    fontWeight: fw,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationThickness: decorationThickness,
  );
}



List selectableTimes = [
  "300", 
  "600",
  "900",
  "1200",
  "1500",
  "1800",
  "2100",
  "2400",
  "2700",
  "3000",
  "3300",
  "3600",
  "3900",
  "4200",
  "4500",
  "4800",
  "5100",
  "5400"

];

Color renderColor(String currentState){
  if (currentState == "FOCUS") {
    return Colors.redAccent;
  } else if (currentState == "LONGBREAK") {
    return Colors.greenAccent;
  } else {
    return Colors.lightBlueAccent;
  }
}