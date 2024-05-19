import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../AppResource/app_colors.dart';
import '../../constants.dart';

class CustomPassTextField extends StatefulWidget {
  TextEditingController controller;
  String label;
  IconData icon;

  CustomPassTextField(
    this.controller,
    this.label,
    this.icon,
  );

  @override
  State<CustomPassTextField> createState() => _CustomPassTextFieldState();
}

class _CustomPassTextFieldState extends State<CustomPassTextField> {
  @override
  Widget build(BuildContext context) {


    FocusNode myFocusNode = new FocusNode();

    bool _showPassword = true;
    void _PasswordVisibility() {
      setState(() {
        _showPassword = !_showPassword;
      });
    }

    return TextFormField(
      validator: (x) {
        if (x == null || x.isEmpty) {
          return "required field";
        }
      },
      focusNode: myFocusNode,
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      cursorColor: AppColors.mainBrown,
      obscureText: _showPassword,
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: TextStyle(
            color: myFocusNode.hasFocus ? Colors.white : AppColors.mainBrown),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.mainBrown, width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Icon(
            widget.icon,
            color: AppColors.mainBrown,
          ),
        ),
        fillColor: Colors.white,
        helperText: widget.label == 'signup'
            ? "* must contain special character & not less than 6 characters"
            : '',
        helperStyle: TextStyle(color: Colors.red),
        suffixIcon: IconButton(
          icon: Icon(_showPassword == false
              ? Icons.visibility
              : Icons.visibility_off),
          onPressed: () {
            setState(
              () {
                _PasswordVisibility();
              },
            );
          },
        ),
        alignLabelWithHint: false,
        filled: true,
      ),
    );
  }
}
