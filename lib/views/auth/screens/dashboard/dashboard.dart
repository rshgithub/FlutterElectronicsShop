
import 'package:flutter/material.dart';
import 'package:ft_e_buy/AppResource/app_colors.dart';
import 'package:ft_e_buy/views/auth/screens/UserProfile/user_profile.dart';
import 'package:ft_e_buy/views/auth/screens/contact/contact_us.dart';
import 'package:ft_e_buy/views/auth/screens/home/home_screen.dart';
import '../../../../components/HomescreenTapBar/custom_animated_bottom_bar.dart';
import '../UserProfile/user_wishlist.dart';

class MyDashBoard extends StatefulWidget {

  @override
  _MyDashBoardState createState() => _MyDashBoardState();
}

class _MyDashBoardState extends State<MyDashBoard> {
  int _currentIndex = 0;

  final _inactiveColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: getBody(),
        bottomNavigationBar: _buildBottomBar()
    );
  }

  Widget _buildBottomBar(){
    return CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
          activeColor: AppColors.mainBrown,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.person),
          title: Text('Profile'),
          activeColor: Colors.blue,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        // BottomNavyBarItem(
        //   icon: Icon(Icons.favorite),
        //   title: Text('Wishlist'),
        //   activeColor: Colors.pinkAccent,
        //   inactiveColor: _inactiveColor,
        //   textAlign: TextAlign.center,
        // ),
        BottomNavyBarItem(
          icon: Icon(Icons.connect_without_contact),
          title: Text(
            'Contact Us ',
          ),
          activeColor: Colors.lightGreen,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }


  Widget getBody() {
    List<Widget> pages = [
      HomeScreen(),
      UserProfile(),
      // UserWishList(),
      ContactUsScreen(),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }


}