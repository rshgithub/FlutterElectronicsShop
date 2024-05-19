import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ft_e_buy/components/my_appbar.dart';
import 'package:ft_e_buy/components/product_card.dart';
import 'package:provider/provider.dart';
import '../../../../providers/auth_provider.dart';
class CategoryProducts extends StatefulWidget {

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Consumer<AuthProvider>(
        builder: (context, provider, w) {
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
                childAspectRatio: 1 / 1.3,
                crossAxisSpacing: 2.5,
              ),
              itemBuilder: (context, index) {
                return ProductCard(provider.allProducts![index]);
              });
        },
      ),
    );
  }

}