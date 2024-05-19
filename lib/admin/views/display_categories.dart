
import 'package:flutter/material.dart';
import 'package:ft_e_buy/admin/views/add_new_category.dart';
import 'package:ft_e_buy/components/admin_category_card.dart';
import 'package:provider/provider.dart';

import '../../AppResource/app_colors.dart';
import '../../app_routers/app_routers.dart';
import '../providers/admin_provider.dart';

class DisplayCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('All Categories',
            style: TextStyle(
                color: AppColors.mainBrown,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal)),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                AppRouter.navigateToScreen(AddNewCategory());
              },
              icon: Icon(
                Icons.add,
                color: AppColors.mainBrown,
              ))
        ],
      ),
      body: Consumer<AdminProvider>(builder: (context, provider, w) {
        return provider.allCategories == null
            ? const Center(
          child: Text('No Categories Found'),
        )
            : ListView.builder(
                itemCount: provider.allCategories!.length,
                itemBuilder: (context, index) {
                  return AdminCategoryCard(provider.allCategories![index]);
                });
      }),
    );
  }
}
