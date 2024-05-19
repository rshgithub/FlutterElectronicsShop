import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../AppResource/app_colors.dart';
import '../../Models/category.dart';
import '../../components/Custom/custom_textfield.dart';
import '../../components/my_appbar.dart';
import '../providers/admin_provider.dart';

class EditCategory extends StatelessWidget {
  Category category;

  EditCategory(this.category);

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
              key: provider.updateCatKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      provider.pickImageForCategory();
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
                      child: provider.pickedCategoryImage == null
                          ? Image.network(
                              category.catImg!,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              provider.pickedCategoryImage!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    provider.catNameController,
                    ((category.catName!)),
                    'Category Name',
                    TextInputType.name,false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        bool isValid =
                            provider.updateCatKey.currentState!.validate();
                        if (isValid) {
                          provider.updateCategory(category);
                        }
                      },
                      child: const Text(
                        'Edit Category',
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
