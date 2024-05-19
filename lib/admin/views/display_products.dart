import 'package:flutter/material.dart';
import 'package:ft_e_buy/Models/category.dart';
import 'package:ft_e_buy/admin/views/add_product.dart';
import 'package:ft_e_buy/components/admin_product_card.dart';
import 'package:ft_e_buy/components/product_card.dart';
import 'package:provider/provider.dart';
import '../../AppResource/app_colors.dart';
import '../../app_routers/app_routers.dart';
import '../providers/admin_provider.dart';

class DisplayProducts extends StatelessWidget {
  Category category;

  DisplayProducts(this.category);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("All " + category.catName! + " Products",
            style: TextStyle(
                color: AppColors.mainBrown,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal)),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                AppRouter.navigateToScreen(AddNewProduct(category.id!));
              },
              icon: Icon(
                Icons.add,
                color: AppColors.mainBrown,
              ))
        ],
      ),
      body: Consumer<AdminProvider>(builder: (context, provider, w) {
        return provider.allProducts == null
            ? const Center(
                child: Text('No Products Found'),
              )
            : GridView.builder(
                shrinkWrap: false,
                itemCount: provider.allProducts!.length,
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
                  return AdminProductCard(
                      provider.allProducts![index]); //, () {});
                });
      }),
    );
  }
}
