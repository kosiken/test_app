import 'package:flutter/material.dart';
import 'package:test_app/constants/colors.dart';
import 'package:test_app/widgets/opacity_feedback.dart';
import 'package:test_app/widgets/typography.dart';
import 'package:unicons/unicons.dart';


abstract class Clickable extends StatelessWidget {
  final void Function() onTheClick;
  final bool loading = false;

  @protected
  const Clickable({required this.onTheClick, Key? key, loading})
      : super(key: key);

  void onClick() {
    if (loading) return;
    onTheClick();
  }
}

class Button extends Clickable {
  final String child;

  /// the color of the buttons borders
  final Color color;
  final bool disabled;
  final IconData? icon;
  final Color textColor;
  final BorderRadius borderRadius;
  final double iconSize;
  final Color? iconColor;
  final EdgeInsets padding;
  final bool bordered;

  const Button(
      {key,
      required void Function() onClick,
      loading = false,
      required this.child,
      this.color = teal,
      this.textColor = Colors.white,
      this.borderRadius = const BorderRadius.all(Radius.circular(5)),
      this.disabled = false,
      this.iconSize = 20,
      this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      this.iconColor,
      this.bordered = false,
      this.icon})
      : super(key: key, onTheClick: onClick, loading: loading);

  @override
  Widget build(BuildContext context) {
    return OpacityFeedback(onClick: onClick,

    child: Container(
      padding: padding,
      alignment: Alignment.center,
      
    
      decoration: BoxDecoration(
          color: bordered ? Colors.transparent : color,
        borderRadius: borderRadius,
        border: bordered ? Border.all(color: color, width: 1, ) : null
      ),
      child: Row(
        children: [
         if(icon != null) Padding(padding: const EdgeInsets.only(right: 5), child: Icon(icon, color: iconColor ?? (bordered ? color : textColor), size: iconSize,),),
          AppTypography(
                   child,
                    color: bordered ? color :  textColor,
                    type: TextTypes.button,
                    
          )
        ],
      ),
    ), );
  }
}

class AppIconButton extends Clickable {
  final IconData icon;
  final String? text;
  final double iconSize;
  final Color color;
  final Color? backgroundColor;

  const AppIconButton({
    key,
      required void Function() onClick,
      loading = false,
    required this.icon,
    this.iconSize = 20,
    this.color = Colors.black,
    this.text,
    this.backgroundColor,
  }): super(key: key, onTheClick: onClick, loading: loading);


 Widget renderText() {
  return Positioned(
    top: 0,
    right: -2,
    child: Container(
          
          padding: const EdgeInsets.all(2),
          constraints: const BoxConstraints(minHeight: 20, minWidth: 20),
          decoration: const BoxDecoration(
            color: pink,
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
          child: Center(child: AppTypography(text!, color: Colors.white, type:  TextTypes.small, bold: true,)),
        ));
 }

  @override
  Widget build(BuildContext context) {
    return OpacityFeedback(
      onClick: onClick,
      child: Stack(
      clipBehavior: Clip.none,
      children: [
       Container(
        padding: backgroundColor == null ? const EdgeInsets.all(2) : const EdgeInsets.all(10),
       
              decoration: BoxDecoration(
           color: backgroundColor ?? Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        child:  Icon(icon,  color: color, size: iconSize),
       ),
        if(text != null )  renderText()
      ],
    ));
  }

}