import 'package:flutter/material.dart';


class SearchInput extends StatelessWidget {
  final String placeholder;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final bool secure;
  final IconData? icon;
  final FocusNode? focusNode;
  final void Function(String value)? onChanged;
  const SearchInput({super.key, required this.placeholder, this.focusNode, this.controller, this.secure = false, this.inputType, this.onChanged, this.icon});


  @override
  Widget build(BuildContext context) {
      Widget leftIcon() {
    if (icon == null){
      return const SizedBox(
        width: 0,
      );}
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Icon(
        icon,
        size: 20,
        color: Colors.grey,
      ),
    );
  }
    return Container(
      padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(
                      color: Color.fromRGBO(107, 119, 154, 0.1),
                      width: 1,
                      style: BorderStyle.solid,
                    )
        ),
      child: Row(

        children: <Widget>[
          leftIcon(),
      Expanded(child:     TextField(
          controller: controller,
          
          focusNode: focusNode,
          obscureText: secure,
          keyboardType: inputType,
          onChanged: onChanged,
        decoration: InputDecoration.collapsed(hintText: placeholder,
         ),
      ))
        ],
      ),
    );
  }
}