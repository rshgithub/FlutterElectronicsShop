import 'package:flutter/material.dart';
import 'package:ft_e_buy/AppResource/app_colors.dart';
import 'package:ft_e_buy/views/auth/screens/UserProfile/user_profile.dart';

class MyAppBar extends StatelessWidget implements  PreferredSizeWidget {
  Color? _backgroundColor;
  MyAppBar([this._backgroundColor]);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      backgroundColor: _backgroundColor == null ? Colors.white : _backgroundColor,
      title: Text("E-buy" , style: TextStyle( color: AppColors.mainBrown , fontSize: 25 , fontWeight: FontWeight.bold , fontStyle: FontStyle.normal)),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: AppColors.mainBrown),
        onPressed: () =>  Navigator.pop(context)
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => AppBar().preferredSize;
}
