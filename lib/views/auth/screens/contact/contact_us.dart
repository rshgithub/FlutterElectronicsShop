import 'package:flutter/material.dart';
import 'package:ft_e_buy/AppResource/app_colors.dart';
import 'package:ft_e_buy/components/my_appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../constants.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      Expanded(
                        flex: 10,
                        child: SizedBox(
                            width: 300,
                            height: 300,
                            child: Image.asset("assets/images/contact.png")),
                      ),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(height: defaultPadding),
                ],
              ),

              contactButton("call Us" , Icons.call , context , () {launchUrl(Uri( scheme: 'tel', path: "0592215966",)); }),
              contactButton("Our Site" , Icons.pageview_rounded , context , () {launchUrl(Uri(scheme: 'https', host: 'www.bti.ps')); }),
              contactButton("Our Facebook" , Icons.facebook , context , () { launchUrl(Uri(scheme: 'fb', host: 'page', path: '/iug.bti'),);}),
              contactButton("Send Us Email" , Icons.email , context , () { launchUrl(Uri(  scheme: 'mailto', path:'bti@iugaza.edu.ps'),);}),
              contactButton("Send Us SMS" , Icons.sms , context , ()  {launchUrl(Uri( scheme: 'sms', path: "0592215966",)); }),


            ],
          ),
        ),
      ),
    );
  }
}


Widget contactButton(String buttonText, IconData icon, context , void Function()? onPressed ) {
  return Container(
    width: 300,
    height: 50,
    margin: EdgeInsets.all(7),
    child: Material(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      child: InkWell(
        onTap: onPressed,
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [AppColors.mainBrown, AppColors.adminBrown]),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          height: 48,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 48.0,
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 23.0,
                ),
              ),

              Expanded(
                child: Center(
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontFamily: 'Mulish',
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    ),
  );
}