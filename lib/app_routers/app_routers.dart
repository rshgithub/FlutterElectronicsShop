import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ft_e_buy/AppResource/app_colors.dart';
import 'package:ft_e_buy/Models/category.dart';
import 'package:ft_e_buy/Models/product.dart';
import 'package:provider/provider.dart';

import '../admin/providers/admin_provider.dart';
import '../providers/auth_provider.dart';

class AppRouter {
  static GlobalKey<NavigatorState> navKey = GlobalKey();

  static showLoaderDialog() {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: navKey.currentContext!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static hideLoadingDialog() {
    navKey.currentState!.pop();
  }

  static showCustomDialog(String content) {
    showDialog(
        context: navKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            content: Text(content,
                style: TextStyle(fontSize: 20, color: AppColors.mainBrown)),
            actions: [
              TextButton(
                  onPressed: navKey.currentState!.pop!,
                  child: Text('OK', style: TextStyle(fontSize: 15))),
            ],
          );
        });
  }

  static showWarningLogOutDialog() {
    showDialog(
        context: navKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            content: Text("Are you sure you want to log out ?",
                style: TextStyle(fontSize: 20, color: AppColors.mainBrown)),
            actions: [
              TextButton(
                  onPressed: navKey.currentState!.pop!,
                  child: Text('Cancel', style: TextStyle(fontSize: 15))),
              TextButton(
                  onPressed: () =>
                      Provider.of<AuthProvider>(context, listen: false)
                          .signOut(),
                  child: Text("Log Out",
                      style: TextStyle(color: Colors.red, fontSize: 15)))
            ],
          );
        });
  }

  static showWarningDeleteCategoryDialog(Category category) {
    showDialog(
        context: navKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            content: Text("Are you sure you want to delete this category ?",
                style: TextStyle(fontSize: 20, color: AppColors.mainBrown)),
            actions: [
              TextButton(
                  onPressed: navKey.currentState!.pop!,
                  child: Text('Cancel', style: TextStyle(fontSize: 15))),
              TextButton(
                  onPressed: () {
                    Provider.of<AdminProvider>(context, listen: false)
                        .deleteCategory(category);
                    navKey.currentState!.pop!;
                  },
                  child: Text("Delete",
                      style: TextStyle(color: Colors.red, fontSize: 15)))
            ],
          );
        });
  }

  static showWarningDeleteProductDialog(Product product) {
    showDialog(
        context: navKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            content: Text("Are you sure you want to delete this product ?",
                style: TextStyle(fontSize: 20, color: AppColors.mainBrown)),
            actions: [
              TextButton(
                  onPressed: navKey.currentState!.pop!,
                  child: Text('Cancel', style: TextStyle(fontSize: 15))),
              TextButton(
                  onPressed: () {
                    Provider.of<AdminProvider>(context, listen: false)
                        .deleteProduct(product);

                  },
                  child: Text("Delete",
                      style: TextStyle(color: Colors.red, fontSize: 15)))
            ],
          );
        });
  }

  static showWarningWishlistRemoveProductDialog(Product product) {
    showDialog(
        context: navKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            content: Text(
                "Are you sure you want to remove this product from your wishlist?",
                style: TextStyle(fontSize: 20, color: AppColors.mainBrown)),
            actions: [
              TextButton(
                  onPressed: navKey.currentState!.pop!,
                  child: Text('Cancel', style: TextStyle(fontSize: 15))),
              TextButton(
                  onPressed: () {navKey.currentState!.pop!;
                    Provider.of<AuthProvider>(context, listen: false)
                        .removeProductFromWishlist(product);
                  },
                  child: Text("Delete",
                      style: TextStyle(color: Colors.red, fontSize: 15)))
            ],
          );
        });
  }

  static navigateToScreen(Widget widget) {
    navKey.currentState!.push(MaterialPageRoute(builder: ((context) {
      return widget;
    })));
  }

  static navigateAndReplaceScreen(Widget widget) {
    navKey.currentState!.pushReplacement(MaterialPageRoute(builder: ((context) {
      return widget;
    })));
  }
}
