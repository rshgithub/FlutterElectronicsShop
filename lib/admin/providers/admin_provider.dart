import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ft_e_buy/admin/views/display_categories.dart';
import 'package:ft_e_buy/admin/views/display_products.dart';
import 'package:image_picker/image_picker.dart';

import '../../Models/category.dart';
import '../../Models/product.dart';
import '../../app_routers/app_routers.dart';
import '../../helpers/firestore_helper.dart';
import '../../helpers/storage_helper.dart';

class AdminProvider extends ChangeNotifier {
  AdminProvider() {
    getAllCategories();
  }

  File? pickedCategoryImage;
  File? pickedProductImage;

  List<Category>? allCategories;
  List<Product>? allProducts;


  GlobalKey<FormState> categoryFormKey = GlobalKey();
  GlobalKey<FormState> productFormKey = GlobalKey();
  GlobalKey<FormState> updateCatKey = GlobalKey();
  GlobalKey<FormState> updateProductKey = GlobalKey();

  // category controllers
  TextEditingController catNameController = TextEditingController();

  // product controllers
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDiscountPriceController =
      TextEditingController();

  // categories ----------------------------------------

  pickImageForCategory() async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xfile != null) {
      pickedCategoryImage = File(xfile.path);
      notifyListeners();
    }
  }

  getAllCategories() async {
    allCategories = await FirestoreHelper.firestoreHelper.getAllCategories();
    notifyListeners();
  }

  getAllCategoryProducts(Category category) async {
    allProducts = await FirestoreHelper.firestoreHelper
        .getAllCategoryProducts(category.id!);
    notifyListeners();
  }

  pickImageForProduct() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedProductImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  createNewCategory() async {
    if (pickedCategoryImage != null) {
      AppRouter.showLoaderDialog();
      // 2- upload image to firebase storage and get its url
      String imageUrl = await StorageHelper.storageHelper
          .uploadImage("categories_images", pickedCategoryImage!);

      Category category =
          Category(catImg: imageUrl, catName: catNameController.text);

      String? id =
          await FirestoreHelper.firestoreHelper.createNewCategory(category);

      AppRouter.hideLoadingDialog();
      if (id != null) {
        category.id = id;
        allCategories?.add(category);
        notifyListeners();
        AppRouter.showCustomDialog('The category has been successfully added');
        log('The category has been successfully added');
      } else {
        AppRouter.showCustomDialog('some error occured while adding category');
        log('some error occured while adding category');
      }
      pickedCategoryImage = null;
      catNameController.clear();
    }
  }

  deleteCategory(Category category) async {
    bool deleteSuccess =
        await FirestoreHelper.firestoreHelper.deleteCategoey(category.id!);
    if (deleteSuccess) {
      allCategories!.remove(category);
      notifyListeners();
      AppRouter.showCustomDialog('The category has been successfully deleted');
      log('The category has been successfully deleted');
    } else {
      AppRouter.showCustomDialog('some error occured while deleting category');
      log('some error occured while deleting category');
    }
  }



  updateCategory(Category category) async {
    AppRouter.showLoaderDialog();
    if (pickedCategoryImage != null) {
      String imageUrl = await StorageHelper.storageHelper
          .uploadImage("cats_images", pickedCategoryImage!);
      category.catImg = imageUrl;
    }

      Category newCategory = Category(
          id: category.id,
          catImg: category.catImg,
          catName: catNameController.text.isEmpty
              ? category.catName
              : catNameController.text);

      bool? isUpdated =
      await FirestoreHelper.firestoreHelper.updateCategory(newCategory);

      if (isUpdated != null && isUpdated) {

        int index = allCategories!.indexOf(category);
        allCategories![index] = newCategory;
        pickedCategoryImage = null;
        catNameController.clear();
        notifyListeners();
        AppRouter.navigateAndReplaceScreen(DisplayCategories());
        AppRouter.showCustomDialog('success Your category has been updated');
        log('success Your category has been updated');
      } else {
        AppRouter.showCustomDialog('some error occured while updating category');
        log('some error occured while updating category');
      }
    productNameController.clear();
    productDescController.clear();
  }
  // product ----------------------------------------

  addNewProduct(String catId) async {
    if (pickedProductImage != null) {
      AppRouter.showLoaderDialog();
      String imageUrl = await StorageHelper.storageHelper
          .uploadImage("products_images", pickedProductImage!);

      Product product = Product(
          imgPath: imageUrl,
          prodName: productNameController.text,
          prodDesc: productDescController.text,
          prodPrice: double.parse(productPriceController.text),
          prodDiscountPrice: double.parse(productDiscountPriceController.text),
          prodCatId: catId);

      String? id = await FirestoreHelper.firestoreHelper.addNewProduct(product);

      AppRouter.hideLoadingDialog();
      if (id != null) {
        product.id = id;
        allProducts?.add(product);
        notifyListeners();
        AppRouter.showCustomDialog('Success Your Product has been added');
        log('success Your Product has been added');
      } else {
        AppRouter.showCustomDialog(
            'some error occured while updating category');
        log('some error occured while updating category');
      }
      productNameController.clear();
      productDescController.clear();
      productPriceController.clear();
      productDiscountPriceController.clear();
      pickedProductImage = null;
    }
  }

  updateProduct(Product product) async {

    AppRouter.showLoaderDialog();
    if (pickedProductImage != null) {
      String imageUrl = await StorageHelper.storageHelper
          .uploadImage("products_images", pickedProductImage!);
      product.imgPath = imageUrl;
    }

    Product newProduct = Product(
      id: product.id,
      imgPath: product.imgPath,
      prodName: productNameController.text.isEmpty
          ? product.prodName
          : productNameController.text,
      prodDesc: productDescController.text.isEmpty
          ? product.prodDesc
          : productDescController.text,
      prodPrice: productPriceController.text.isEmpty
          ? product.prodPrice
          : double.parse(productPriceController.text),
      prodDiscountPrice: productDiscountPriceController.text.isEmpty
          ? product.prodDiscountPrice
          : double.parse(productDiscountPriceController.text),
    );

    bool? isUpdated =
        await FirestoreHelper.firestoreHelper.updateProduct(newProduct);


    if (isUpdated != null && isUpdated) {
      int index = allProducts!.indexOf(product);
      allProducts![index] = newProduct;
      notifyListeners();
      AppRouter.showCustomDialog('The product has been successfully updated');
      log('The product has been successfully updated');
    } else {
      AppRouter.showCustomDialog('some error occured while updating product');
      log('some error occured while updating product');
    }
  }

  deleteProduct(Product product) async {
    AppRouter.showLoaderDialog();
    bool deleteSuccess =
        await FirestoreHelper.firestoreHelper.deleteCategoey(product.id!);
    if (deleteSuccess) {
      allProducts!.remove(product);
      notifyListeners();
      log('The product has been successfully deleted');
    } else {
      log('some error occured while deleting product');
    }
  }



}
