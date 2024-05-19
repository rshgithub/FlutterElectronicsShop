import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../AppResource/app_colors.dart';
import '../../constants.dart';

class CustomTextField extends StatefulWidget {

  TextEditingController controller;
  String label;
  IconData? icon ;
  String content;
  TextInputType? keyboardType;
  bool? validate ;

  CustomTextField(this.controller, this.label , this.content , this.keyboardType , this.validate , [ this.icon]);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();

}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    FocusNode myFocusNode = new FocusNode();

    return TextFormField(

      validator: widget.validate == true ? (x) {
        if (x == null || x.isEmpty) {
          return "required field";
        }
      } : (x) {},
      focusNode: myFocusNode,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textInputAction: TextInputAction.done,
      cursorColor: AppColors.mainBrown,
      decoration: InputDecoration(
        labelText: widget.label,
          labelStyle: TextStyle(
              color: myFocusNode.hasFocus ?Colors.white :  AppColors.mainBrown),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder:OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.mainBrown, width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: widget.icon == null ? Icon(Icons.circle , color: AppColors.mainBrown,) : Icon(widget.icon , color: AppColors.mainBrown,) ,
        ),
      ),
    );
  }
}
