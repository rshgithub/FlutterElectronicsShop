import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ft_e_buy/components/my_appbar.dart';
import 'package:ft_e_buy/components/product_card.dart';
import 'package:provider/provider.dart';
import '../../../../AppResource/app_colors.dart';
import '../../../../Models/product.dart';
import '../../../../components/HomescreenTapBar/custom_animated_bottom_bar.dart';
import '../../../../components/wishlist_product_card.dart';
import '../../../../providers/auth_provider.dart';
import '../UserProfile/user_profile.dart';

import 'package:ft_e_buy/views/auth/screens/contact/contact_us.dart';
import 'package:ft_e_buy/views/auth/screens/home/home_screen.dart';

class UserWishList extends StatefulWidget {

  @override
  State<UserWishList> createState() => _UserWishListState();
}

class _UserWishListState extends State<UserWishList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppColors.mainBrown),
            onPressed: () =>  Navigator.pop(context)
        ),
        backgroundColor: Colors.white,
        title: Text("All Wish List Products",
            style: TextStyle(
                color: AppColors.mainBrown,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal)),
        centerTitle: true,
      ),
      body: Consumer<AuthProvider>(builder: (context, provider, w) {
        return provider.allWishList == null
            ? const Center(
          child: Text('No Products in your wish list yet'),
        )
            : GridView.builder(
              shrinkWrap: false,
              itemCount: provider.allWishList!.length,
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.7,
                crossAxisSpacing: 2.5,
              ),
              itemBuilder: (context, index) {
                return WishlistProductCard(provider.allWishList![index]);
              });
        },
      ),
    );
  }


}