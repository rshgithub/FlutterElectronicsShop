import 'dart:developer';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ft_e_buy/AppResource/app_colors.dart';
import 'package:ft_e_buy/app_routers/app_routers.dart';
import 'package:ft_e_buy/components/my_appbar.dart';
import 'package:ft_e_buy/views/auth/screens/UserProfile/user_wishlist.dart';
import 'package:provider/provider.dart';
import '../../../../admin/views/admin_panel.dart';
import '../../../../components/Custom/custom_profile_font.dart';
import '../../../../components/UserProfileComponent/section_divider.dart';
import '../../../../providers/auth_provider.dart';
import 'edit_user_info_screen.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(AppColors.lightBrown),
      body: Consumer<AuthProvider>(builder: (context, provider, c) {
        return provider.currentLoggedUser == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                width: double.infinity,
                child: ListView(
                  children: [
                    Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            height: 290,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    AppColors.lightBrown,
                                    AppColors.mainBrown
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  stops: [0.2, 0.6, 1]),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Container(
                                    child: provider.currentLoggedUser!.imageUrl == null
                                            ? const CircleAvatar(
                                                radius: 70.0,
                                                backgroundImage: AssetImage(
                                                    "assets/images/dress.png"))
                                            : CircleAvatar(
                                                radius: 60.0,
                                                backgroundImage: NetworkImage(
                                                  provider.currentLoggedUser!
                                                      .imageUrl!,
                                                )),
                                    decoration: BoxDecoration(
                                        // image: DecorationImage(image: provider.currentLoggedUser!.imageUrl == null
                                        //     ?  CircleAvatar(
                                        //     radius: 70.0,
                                        //     backgroundImage: AssetImage(
                                        //         "assets/images/dress.png") )as ImageProvider
                                        //     : NetworkImage(
                                        //   provider.currentLoggedUser!
                                        //       .imageUrl!,
                                        // )),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: AppColors.adminBrown,
                                            width: 2)),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomProfileFont(
                                  provider.currentLoggedUser!
                                      .userName!,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomProfileFont(
                                  provider.currentLoggedUser!
                                      .userEmail!,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomProfileFont(
                                  provider.currentLoggedUser!
                                      .userAddress!,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ]),
                    // userInfo(
                    //     "My Orders",
                    //     Icon(Icons.shopping_basket_rounded,
                    //         color: AppColors.mainBrown, size: 30.00),
                    //     context, () {
                    //   log(
                    //     provider.currentLoggedUser!
                    //         .userName!,
                    //   );
                    // }),
                    // SectionDivider(),
                    // userInfo(
                    //     "Favourites",
                    //     Icon(Icons.favorite,
                    //         color: AppColors.mainBrown, size: 30.0),
                    //     context,
                    //     () {}),
                    const SectionDivider(),
                    userInfo(
                        "Wish List",
                        const Icon(Icons.favorite,
                            color: AppColors.mainBrown, size: 30.0),
                        context, () {
                      Provider.of<AuthProvider>(context, listen: false)
                          .getAllUserWishlist();
                      AppRouter.navigateToScreen(UserWishList());
                    }),
                    const SectionDivider(),
                    userInfo(
                        "Edit User Profile",
                        const Icon(Icons.settings,
                            color: AppColors.mainBrown, size: 30.0),
                        context, () {
                      AppRouter.navigateToScreen(EditUserInfoScreen());
                    }),
                    const SectionDivider(),
                    userInfo(
                        "Log Out",
                        const Icon(Icons.logout,
                            color: AppColors.mainBrown, size: 30.0),
                        context, () {
                      AppRouter.showWarningLogOutDialog();

                    }),
                    const SectionDivider(),
                    Provider.of<AuthProvider>(context)
                                .currentLoggedUser!
                                .isAdmin! ==
                            true
                        ? userInfo(
                            "ADMIN PANEL",
                            const Icon(Icons.private_connectivity,
                                color: AppColors.mainBrown, size: 30.0),
                            context, () {
                            AppRouter.navigateToScreen(AdminPanel());
                          })
                        : SizedBox(),
                  ],
                ),
              );
      }),
    );
  }
}

Widget userInfo(
    String name, Icon icon, BuildContext context, void Function() onPressed) {
  return Column(
    children: [
      OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor:
              name == "ADMIN PANEL" ? AppColors.adminBrown : Colors.white,
          side: const BorderSide(
            width: 0.0,
            color: Colors.transparent,
            style: BorderStyle.solid,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
          child: Row(
            children: [
              icon,
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF393939),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
