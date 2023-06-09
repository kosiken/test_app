import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/debug.dart';

enum TextTypes { body, header, small, banner, emphasis, button }

class AppTypography extends StatelessWidget {
  final TextAlign textAlign;
  final bool bold;
  final TextTypes type;
  final double? height;
  final String body;
  final double? customSize;
  final Color color;
  final TextOverflow? overflow;
  final int? maxLines;


  const AppTypography(this.body,
      {this.textAlign = TextAlign.left,
      this.bold = false,
      this.type = TextTypes.body,
      Key? key,
      this.color = Colors.black,
      this.customSize,
      this.overflow,
      this.maxLines,
      this.height})

      : super(key: key);

  TextStyle _generateTextStyle() {
    double size = 0;
    switch (type) {
      case TextTypes.small:
        size = 10;
        break;
      
      case TextTypes.emphasis:
        size = 12;
        break;

      case TextTypes.body:
        size = 14;
        break;
      case TextTypes.button:
          size = 12;
      break;
      case TextTypes.header:
        size = 20;
        break;
      case TextTypes.banner:
        size = 26;
        break;

      default:
        Debug.log("Undefined size '$type' found \n ");
        size = 12;
        break;

  
    }
    if(customSize != null) {
      size = customSize!;
    }

    return TextStyle(
        fontSize: size,
        fontWeight: (bold || size > 16)
            ? FontWeight.w800
            : (type == TextTypes.button)
                 ? FontWeight.w700
                : FontWeight.normal,
        decoration: TextDecoration.none,
        color: this.color,
        letterSpacing: 0.1,
        
        overflow: overflow,
      
        height: height);
  }

  Widget build(BuildContext context) {
    TextStyle textStyle = _generateTextStyle();
    return Text(
      body,
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
      
      style: GoogleFonts.lato(
        textStyle: textStyle,
      ),
      textAlign: this.textAlign,
    );
  }

  static TextStyle getDefaultStyle() {
    return GoogleFonts.lato(
      textStyle:  TextStyle(
          letterSpacing: 0.1,)
    );
  }
}
