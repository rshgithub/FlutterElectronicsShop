import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ft_e_buy/AppResource/app_colors.dart';

class CustomProfileFont extends StatelessWidget {

  String text ;
  CustomProfileFont(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      // provider.currentLoggedUser!.userName!,
      text ,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.normal,
        color: AppColors.mainBrown,
        fontFamily: 'Mulish',
      ),
    );
  }
}
