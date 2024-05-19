import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ft_e_buy/admin/views/add_product.dart';
import 'package:ft_e_buy/admin/views/display_products.dart';
import 'package:ft_e_buy/admin/views/edit_category.dart';
import 'package:ft_e_buy/app_routers/app_routers.dart';
import 'package:provider/provider.dart';

import '../AppResource/app_colors.dart';
import '../Models/category.dart';
import '../Models/product.dart';
import '../admin/providers/admin_provider.dart';
import '../admin/views/edit_product.dart';

class AdminProductCard extends StatelessWidget {
  Product product;

  AdminProductCard(this.product);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0xFFC1BFBF).withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(
                  0,
                  1,
                ),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                height: 150,
                width: double.infinity,
                child: Container(
                  margin: EdgeInsets.only(right: 10, left: 10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(product.imgPath!),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  width: 190,
                  child: Text(
                    product.prodName!, maxLines: 1,
                    style: const TextStyle(
                        fontSize: 25,
                        color: AppColors.mainBrown,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 5, top: 10, left: 5, right: 5),
                child: SizedBox(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.monetization_on_outlined,
                        color: Colors.green,
                        size: 20,
                      ),
                      Text(
                        product.prodPrice!.toString(),
                        style: (product.prodDiscountPrice! == 0)
                            ? const TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                                fontWeight: FontWeight.w400,
                              )
                            : const TextStyle(
                                fontSize: 20,
                                height: 0.9, //line height 90% of actual height
                                color: Colors.green,
                                decoration: TextDecoration.lineThrough,
                              ),
                      ),
                      (product.prodDiscountPrice! == 0)
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(
                                left: 10, right: 10),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.local_fire_department_sharp,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  Text(
                                    product.prodDiscountPrice!.toString(),
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 140,
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
                                AppRouter.navigateToScreen(EditProduct(product));
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
                                AppRouter.showWarningDeleteProductDialog(product);
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
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        )
      ],
    );
  }
}
