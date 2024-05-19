import 'package:flutter/material.dart';
import 'package:ft_e_buy/Models/product.dart';
import 'package:ft_e_buy/helpers/auth_helper.dart';
import 'package:ft_e_buy/views/auth/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import '../../../../../../components/already_have_an_account_acheck.dart';
import '../../../../../../constants.dart';
import '../../../../../../providers/auth_provider.dart';
import '../../AppResource/app_colors.dart';
import '../../Sizing/size_config.dart';
import '../Custom/custom_pass_textfield.dart';
import '../Custom/custom_textfield.dart';
import '../../views/auth/screens/authentaication/signup_screen.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;

    return Consumer<AuthProvider>(builder: (context, provider, x) {
      return Column(
        children: [
          SizedBox(
            height: 20,
          ),
          CustomTextField(provider.loginEmailController, 'Email','',  TextInputType.emailAddress, true,Icons.person),
          SizedBox(
            height: 20,
          ),
          CustomTextField(provider.loginPasswordController, 'login', '', TextInputType.visiblePassword, true,Icons.lock),
          SizedBox(
            height: 20,
          ),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () {
                provider.login();
                },
              child: const Text("LOG IN"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainBrown,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: (width <= 550)
                    ? const EdgeInsets.symmetric(horizontal: 100, vertical: 20)
                    : EdgeInsets.symmetric(
                        horizontal: width * 0.2, vertical: 25),
                textStyle: TextStyle(fontSize: (width <= 550) ? 13 : 17),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      );
    });
  }
}
