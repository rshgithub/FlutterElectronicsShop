import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ft_e_buy/admin/views/add_product.dart';
import 'package:ft_e_buy/admin/views/display_products.dart';
import 'package:ft_e_buy/admin/views/edit_category.dart';
import 'package:ft_e_buy/app_routers/app_routers.dart';
import 'package:provider/provider.dart';

import '../AppResource/app_colors.dart';
import '../Models/category.dart';
import '../admin/providers/admin_provider.dart';

class AdminCategoryCard extends StatelessWidget {
  Category category;

  AdminCategoryCard(this.category);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 390,
      width: 150,
      margin: EdgeInsets.only(left: 50, top: 20, right: 50, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 9,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            width: 270,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 2,
                color: AppColors.mainBrown,
              ),
            ),
            child: Image.network(
              category.catImg!,
              fit: BoxFit.cover,
            ),
            // Icon(icon , size: 24, color: Colors.black),
          ),
          SizedBox(
            width: 20,
          ),
          Text(category.catName!, // category.catName! ,
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Mulish',
                  color: AppColors.mainBrown,
                  wordSpacing: 1.5)),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 280,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox.fromSize(
                  size: Size(65, 65),
                  child: ClipOval(
                    child: Material(
                      color: AppColors.lightenBrown,
                      child: InkWell(
                        splashColor: AppColors.lightBrown,
                        onTap: () {
                          Provider.of<AdminProvider>(context, listen: false)
                              .addNewProduct(category.id!);
                          AppRouter.navigateToScreen(
                              AddNewProduct(category.id!));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.add_circle,
                              size: 24,
                              color: AppColors.mainBrown,
                            ),
                            // <-- Icon
                            Text("Add",
                                style: TextStyle(color: AppColors.mainBrown)),
                            // <-- Text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox.fromSize(
                  size: Size(65, 65),
                  child: ClipOval(
                    child: Material(
                      color: AppColors.lightenBrown,
                      child: InkWell(
                        splashColor: AppColors.lightBrown,
                        onTap: () {
                          AppRouter.navigateToScreen(EditCategory(category));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.edit_outlined,
                              size: 24,
                              color: AppColors.mainBrown,
                            ),
                            // <-- Icon
                            Text("Edit",
                                style: TextStyle(color: AppColors.mainBrown)),
                            // <-- Text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox.fromSize(
                  size: Size(65, 65),
                  child: ClipOval(
                    child: Material(
                      color: AppColors.lightenBrown,
                      child: InkWell(
                        splashColor: AppColors.lightBrown,
                        onTap: () {
                          Provider.of<AdminProvider>(context, listen: false)
                              .getAllCategoryProducts(category);
                          AppRouter.navigateToScreen(DisplayProducts(category));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.phonelink_rounded,
                              size: 24,
                              color: AppColors.mainBrown,
                            ),
                            // <-- Icon
                            Text("Products",
                                style: TextStyle(color: AppColors.mainBrown)),
                            // <-- Text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox.fromSize(
                  size: Size(65, 65),
                  child: ClipOval(
                    child: Material(
                      color: AppColors.lightenBrown,
                      child: InkWell(
                        splashColor: AppColors.lightBrown,
                        onTap: () {
                          AppRouter.showWarningDeleteCategoryDialog(category);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.delete_forever,
                              size: 24,
                              color: AppColors.mainBrown,
                            ),
                            // <-- Icon
                            Text("Delete",
                                style: TextStyle(color: AppColors.mainBrown)),
                            // <-- Text
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
