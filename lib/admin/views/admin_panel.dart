import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ft_e_buy/admin/views/add_new_category.dart';
import 'package:ft_e_buy/admin/views/add_product.dart';
import 'package:ft_e_buy/admin/views/display_products.dart';
import 'package:provider/provider.dart';

import '../../AppResource/app_colors.dart';
import '../../app_routers/app_routers.dart';
import '../../components/UserProfileComponent/section_divider.dart';
import '../../components/my_appbar.dart';
import '../../constants.dart';
import '../../providers/auth_provider.dart';
import '../../views/auth/screens/UserProfile/user_profile.dart';
import 'display_categories.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Column(
            children: [
              SizedBox(height: 20,),
              Row(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 10,
                    child: SizedBox(
                        width: 300,
                        height: 300,
                        child: Image.asset("assets/images/image3.png")),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
          userInfo(
              "Add Category",
              Icon(Icons.category,
                  color: AppColors.mainBrown, size: 30.00),
              context,
                  () {
                    AppRouter.navigateToScreen(AddNewCategory());
                  }),
          SectionDivider(),
          userInfo(
              "display all categories",
              Icon(Icons.category_outlined,
                  color: AppColors.mainBrown, size: 30.0),
              context,
                  () {
                    AppRouter.navigateToScreen(DisplayCategories());
                  }),
         ],
      ),
    );
  }
}
