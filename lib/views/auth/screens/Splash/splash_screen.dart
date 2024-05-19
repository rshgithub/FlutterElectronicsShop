import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ft_e_buy/AppResource/app_colors.dart';
import 'package:ft_e_buy/app_routers/app_routers.dart';
import 'package:ft_e_buy/providers/auth_provider.dart';
import 'package:ft_e_buy/views/auth/screens/onboarding/onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
          builder: (context, provider , x ) {
            return Container(
              color: Colors.white,
              width: double.infinity,
              child: SafeArea(
                child: Center(
                  child: const Text("E-buy",
                      style: TextStyle(fontSize: 70,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Mulish' ,
                          color: AppColors.mainBrown,
                          wordSpacing: 1.5)),
                ),
              ),
            );
          }
      ),
    );
  }

}
