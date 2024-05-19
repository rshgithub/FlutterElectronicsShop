
import 'package:flutter/material.dart';
import 'package:ft_e_buy/Models/product.dart';
import 'package:provider/provider.dart';

import '../../AppResource/app_colors.dart';
import '../../components/Custom/custom_textfield.dart';
import '../../components/my_appbar.dart';
import '../providers/admin_provider.dart';

class EditProduct extends StatelessWidget {
  Product product;
  EditProduct(this.product);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: MyAppBar(),
      body: Consumer<AdminProvider>(builder: (context, provider, w) {
        return SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: provider.updateProductKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      provider.pickImageForProduct();
                    },
                    child: Container(
                      height: 150,
                      width: 150,
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
                      child: provider.pickedProductImage == null
                          ? Image.network(
                        product.imgPath!,
                        fit: BoxFit.cover,
                      )
                          : Image.file(
                        provider.pickedProductImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomTextField
                    (
                    provider.productNameController,
                    'Product Name',((product.prodName!)),
                    TextInputType.name,false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  CustomTextField
                    (
                    provider.productDescController,
                    'Product Desc',((product.prodDesc!)),
                    TextInputType.text,false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField
                    (
                    provider.productPriceController,
                    'Product Price',((product.prodPrice.toString()!)),
                    TextInputType.number,false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField
                    (
                    provider.productDiscountPriceController,
                    'Product Discount Price', ((product.prodDiscountPrice.toString()!)),
                    TextInputType.number,false,

                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        provider.updateProduct(product);
                      },
                      child: const Text(
                        'Update Product',
                        style: TextStyle(fontSize: 17),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainBrown,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),

                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

