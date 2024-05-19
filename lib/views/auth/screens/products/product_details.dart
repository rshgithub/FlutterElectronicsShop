
import 'dart:ui';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:ft_e_buy/Models/product.dart';
import 'package:ft_e_buy/components/my_appbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../AppResource/app_colors.dart';
import '../../../../providers/auth_provider.dart';

class ProductDetails extends StatelessWidget {
  Product product;

  ProductDetails(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightenBrown,
      appBar: MyAppBar(),
      body: Consumer<AuthProvider>(builder: (context, provider, x) {
        return Column(
          children: [
            Stack(children: [
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .35,
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
              // Container(
              //   margin: EdgeInsets.only(top: 20, left: 330),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(50),
              //       color: Color(0xFFFCF0F0)),
              //   width: 40,
              //   height: 40,
              //   child: Center(
              //     child: FavoriteButton(
              //       iconSize: 35,
              //       isFavorite: false,
              //       valueChanged: (_isFavorite) {
              //         print('Is Favorite : $_isFavorite');
              //       },
              //     ),
              //   ),
              // ),
            ]),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    padding:
                    const EdgeInsets.only(top: 40, right: 14, left: 14),
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 300,
                                child: Text(
                                  product.prodName!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              IconButton(onPressed: () async {

                                (product.prodDiscountPrice! == 0) ?
                                Share.share(
                                    "Hey check this " + product.prodName! +
                                        " it's only \$" +
                                        product.prodPrice.toString()! + " At "
                                        +
                                        " https://play.google.com/store/apps/details?id=" +
                                        "E-buy" + "App") :
                                Share.share(
                                    "Hey check this " + product.prodName! +
                                        " it's only \$" +
                                        product.prodDiscountPrice.toString()! +
                                        " After SALE !! , At "
                                        +
                                        " https://play.google.com/store/apps/details?id=" +
                                        "E-buy" + "App");
                              },
                                  icon: Icon(
                                    Icons.share, color: AppColors.mainBrown,
                                    size: 30,)),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(),
                          Text(
                            "Prices",
                            style: GoogleFonts.poppins(
                              fontSize: 30,
                              color: AppColors.mainBrown,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.monetization_on_outlined,
                                color: Colors.green,
                                size: 30,
                              ),
                              Text(
                                product.prodPrice!.toString(),
                                style: (product.prodDiscountPrice! == 0)
                                    ? const TextStyle(
                                  fontSize: 25,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w400,
                                )
                                    : TextStyle(
                                  fontSize: 25,
                                  height: 0.9,
                                  //line height 90% of actual height
                                  color: Colors.green,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              (product.prodDiscountPrice! == 0)
                                  ? const SizedBox()
                                  : Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 5, left: 10, right: 10),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.local_fire_department_sharp,
                                      color: Colors.red,
                                      size: 25,
                                    ),
                                    Text(
                                      product.prodDiscountPrice!
                                          .toString(),
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "Description",
                            style: GoogleFonts.poppins(
                              fontSize: 30,
                              color: AppColors.mainBrown,
                            ),
                          ),
                          Text(
                            product.prodDesc!,
                            style: GoogleFonts.poppins(
                              fontSize: 25,
                              color: Colors.blueGrey,
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: 400,
                            height: 50,
                            child: ElevatedButton.icon(
                              onPressed: () { provider.addToWishList(product);},
                              icon: Icon(Icons.favorite_border),
                              label: const Text(
                                "Add To Wishlist",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Mulish',
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.mainBrown,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: AppColors.mainBrown,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}