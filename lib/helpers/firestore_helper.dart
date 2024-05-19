import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ft_e_buy/Models/app_user.dart';
import 'package:ft_e_buy/Models/product.dart';

import '../Models/category.dart';

class FirestoreHelper {
  FirestoreHelper._();

  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  createNewUser(AppUser appUser) async {
    firestore.collection('users').doc(appUser.id).set(appUser.toMap());
  }

  Future<AppUser> getUserFromFirestore(String id) async {
    DocumentSnapshot<Map<String, dynamic>> document =
        await firestore.collection('users').doc(id).get();

    Map<String, dynamic>? data = document.data();

    AppUser appUser = AppUser.fromMap(data!);
    return appUser;
  }

  Future<bool?> updateUserInfo(AppUser appUser) async {
    await firestore.collection('users').doc(appUser.id).update(appUser.toMap());
  }

  // admin functions
  Future<String> createNewCategory(Category category) async {
    DocumentReference<Map<String, dynamic>> document =
        await firestore.collection('categories').add(category.toMap());
    return document.id;
  }

  // ----------------------------------------------------------------------------

  Future<List<Category>?> getAllCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> catsSnapshot =
          await firestore.collection('categories').get();
      List<Category> categories = catsSnapshot.docs.map((doc) {
        Category category = Category.fromMap(doc.data());
        category.id = doc.id;
        return category;
      }).toList();
      return categories;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  //// for admin
  // categories

  Future<String?> addNewCategory(Category category) async {
    try {
      DocumentReference<Map<String, dynamic>> categoryDocument =
          await firestore.collection('categories').add(category.toMap());

      return categoryDocument.id;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<bool> deleteCategoey(String catId) async {
    try {
      await firestore.collection('categories').doc(catId).delete();
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool?> updateCategory(Category category) async {
    try {
      await firestore
          .collection('categories')
          .doc(category.id)
          .update(category.toMap());

      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  // products

  Future<String?> addNewProduct(Product product) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
          await firestore
              .collection('categories')
              .doc(product.prodCatId)
              .collection("products") // the subCollection
              .add(product.toMap());
      return documentReference.id;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<List<Product>?> getAllCategoryProducts(String catId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection('categories')
          .doc(catId)
          .collection('products')
          .get();
      return querySnapshot.docs.map((e) {
        Product product = Product.fromMap(e.data());
        product.id = e.id;
        return product;
      }).toList();
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<bool> deleteProduct(Product product) async {
    try {
      await firestore
          .collection('categories')
          .doc(product.prodCatId)
          .collection('products')
          .doc(product.id)
          .delete();
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool?> updateProduct(Product product) async {
    try {
      await firestore
          .collection('categories')
          .doc(product.prodCatId)
          .collection('products')
          .doc(product.id)
          .update(product.toMap());
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }


  //-------------------

  Future<String?> addProductToWishlist(Product product , String userId) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
      await firestore
          .collection('users')
          .doc(userId)
          .collection("wishlist") // the subCollection
          .add(product.toMap());
      return documentReference.id;
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<List<Product>?> getAllUserWishlist(String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('wishlist')
          .get();
      return querySnapshot.docs.map((e) {
        Product product = Product.fromMap(e.data());
        product.id = e.id;
        return product;
      }).toList();
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<bool> removeWishlistProduct(Product product , String userId) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('wishlist')
          .doc(product.id)
          .delete();
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }
}
