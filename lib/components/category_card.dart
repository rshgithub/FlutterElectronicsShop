import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ft_e_buy/providers/auth_provider.dart';
import 'package:ft_e_buy/views/auth/screens/products/category_products.dart';
import 'package:provider/provider.dart';

import '../AppResource/app_colors.dart';
import '../Models/category.dart';
import '../app_routers/app_routers.dart';

class CategoryCard extends StatelessWidget {
  Category category;

  CategoryCard(this.category);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<AuthProvider>(context, listen: false)
            .getAllCategoryProducts(category.id!);
        AppRouter.navigateToScreen(CategoryProducts());
      },
      child: Container(
        height: 170,
        width: 200,
        padding: EdgeInsets.only(left: 5),
        margin: EdgeInsets.only(left: 15, top: 20, right: 15, bottom: 5),
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
        child: Row(
          children: [
            Container(
              width: 160,
              height: 160,
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
            SizedBox(width: 20,),
            Text(category.catName!, // category.catName! ,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Mulish',
                    color: AppColors.mainBrown,
                    wordSpacing: 1.5)),
          ],
        ),
      ),
    );
    //
    //
    // Padding(
    //   padding: const EdgeInsets.all(25.0),
    //   child: Container(
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(12),
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.grey.withOpacity(0.5),
    //           spreadRadius: 5,
    //           blurRadius: 7,
    //           offset: Offset(0, 3),
    //         ),
    //       ],
    //     ),
    //     child: Row(
    //       children: [
    //         Container(
    //           child:Image.asset(
    //             imgPath,
    //             fit: BoxFit.cover,
    //           ),
    //           // Icon(icon , size: 24, color: Colors.black),
    //           padding: const EdgeInsets.all(12),
    //         ),
    //         Container(
    //           decoration: const BoxDecoration(
    //               color: Colors.black,
    //               borderRadius: BorderRadius.only(
    //                   bottomRight: Radius.circular(12),
    //                   bottomLeft: Radius.circular(12))),
    //           child: Text(title),
    //           padding: const EdgeInsets.all(12),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
