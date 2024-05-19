import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ft_e_buy/Models/app_user.dart';
import 'package:ft_e_buy/Models/product.dart';
import 'package:ft_e_buy/helpers/auth_helper.dart';
import 'package:ft_e_buy/helpers/firestore_helper.dart';
import 'package:ft_e_buy/views/auth/screens/UserProfile/user_profile.dart';
import 'package:ft_e_buy/views/auth/screens/authentaication/login_screen.dart';
import 'package:ft_e_buy/views/auth/screens/authentaication/signup_screen.dart';
import 'package:ft_e_buy/views/auth/screens/dashboard/dashboard.dart';
import 'package:ft_e_buy/views/auth/screens/onboarding/onboarding_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/category.dart';
import '../app_routers/app_routers.dart';
import '../helpers/auth_helper.dart';
import '../helpers/storage_helper.dart';
import '../views/auth/screens/home/home_screen.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    checkUser();
    getAllCategories();
  }

  String app_name = 'E-buy';
  AppUser? currentLoggedUser;

  late User loggedUser;

  // login
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  // register
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerUserNameController = TextEditingController();
  TextEditingController registerUserAddressController = TextEditingController();
  TextEditingController registerPhoneNumController = TextEditingController();

  // user profile
  TextEditingController profileUserNameController = TextEditingController();
  TextEditingController profilePhoneController = TextEditingController();
  TextEditingController profileUserAddressController = TextEditingController();
  TextEditingController profileEmailController = TextEditingController();

  login() async {
    String? userId = await AuthHelper.authHelper
        .login(loginEmailController.text.trim(), loginPasswordController.text);
    if (userId != null) {
      getUserFromFirestore(userId);
      AppRouter.navigateAndReplaceScreen(MyDashBoard());
      loginEmailController.clear();
      loginPasswordController.clear();
    } else {
      AppRouter.showCustomDialog(
          'some error occured while logging in , please check all fields');
    }
  }

  register() async {
    bool isSuccess = await AuthHelper.authHelper.signup(
        registerEmailController.text.trim(), registerPasswordController.text);
    log(isSuccess.toString());

    if (isSuccess) {
      getUserFromAuth();
      AppUser appUser = AppUser(
          id: loggedUser.uid,
          userName: registerUserNameController.text,
          userAddress: registerUserAddressController.text,
          userEmail: registerEmailController.text,
          userPhone: registerPhoneNumController.text.trim(),
          isAdmin: false);

      FirestoreHelper.firestoreHelper.createNewUser(appUser);
      User? user = AuthHelper.authHelper.checkUser();
      getUserFromFirestore(user!.uid);
      AppRouter.navigateAndReplaceScreen(LoginScreen());
      registerUserNameController.clear();
      registerUserAddressController.clear();
      registerEmailController.clear();
      registerPhoneNumController.clear();
      registerPasswordController.clear();
    } else {
      AppRouter.showCustomDialog(
          'some error occured while registering , please check all fields');
    }
  }

  signOut() async {
    AuthHelper.authHelper.signOut();
    AppRouter.navigateAndReplaceScreen(LoginScreen());
  }

  getUserFromAuth() {
    loggedUser = AuthHelper.authHelper.checkUser();
  }

  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool('first_time');
  }

  checkUser() async {
    await Future.delayed(const Duration(milliseconds: 1500));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool('first_time');

    User? user = AuthHelper.authHelper.checkUser();
    if (user == null) {
      if (firstTime != null && !firstTime) {
        // Not first time

        log("sec");
        AppRouter.navigateAndReplaceScreen(LoginScreen());
      } else {
        // First time
        log("first");
        prefs.setBool('first_time', false);
        AppRouter.navigateAndReplaceScreen(OnboardingScreen());
      }
    } else {
      getUserFromFirestore(user.uid);
      AppRouter.navigateAndReplaceScreen(MyDashBoard());
    }
  }

  getUserFromFirestore(String id) async {
    currentLoggedUser =
        await FirestoreHelper.firestoreHelper.getUserFromFirestore(id);
    currentLoggedUser!.id = id;
    profileUserNameController.text = currentLoggedUser!.userName ?? '';
    profilePhoneController.text = currentLoggedUser!.userPhone ?? '';
    profileUserAddressController.text = currentLoggedUser!.userAddress ?? '';
    profileEmailController.text = currentLoggedUser!.userEmail ?? '';
    notifyListeners();
  }

  updateUserImage() async {
    AppRouter.showLoaderDialog();
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      String imageUrl =
          await StorageHelper.storageHelper.uploadImage("users_images", file);

      currentLoggedUser!.imageUrl = imageUrl;
      await FirestoreHelper.firestoreHelper.updateUserInfo(currentLoggedUser!);
      getUserFromFirestore(currentLoggedUser!.id!);
      notifyListeners();
      AppRouter.navigateAndReplaceScreen(UserProfile());
      AppRouter.showCustomDialog('user image info has been successfully updated');
    }
  }

  updateUserInfo() async {
    AppRouter.showLoaderDialog();
    currentLoggedUser!.userName = profileUserNameController.text;
    currentLoggedUser!.userPhone = profilePhoneController.text;
    currentLoggedUser!.userAddress = profileUserAddressController.text;
    await FirestoreHelper.firestoreHelper.updateUserInfo(currentLoggedUser!);
    getUserFromFirestore(currentLoggedUser!.id!);
    AppRouter.navigateAndReplaceScreen(UserProfile());
    AppRouter.showCustomDialog('user info has been successfully updated');
  }

  List<Category>? allCategories;

  getAllCategories() async {
    allCategories = await FirestoreHelper.firestoreHelper.getAllCategories();
    notifyListeners();
  }

  List<Product>? allProducts;

  getAllCategoryProducts(String catId) async {
    allProducts =
        await FirestoreHelper.firestoreHelper.getAllCategoryProducts(catId);
    notifyListeners();
  }


  // ----------------------

  List<Product>? allWishList;
  addToWishList(Product product) async {

    String? id = await FirestoreHelper.firestoreHelper.addProductToWishlist(product , currentLoggedUser!.id! );

    AppRouter.hideLoadingDialog();
    if (id != null) {
      product.id = id;
      allWishList?.add(product);
      notifyListeners();
      AppRouter.showCustomDialog('product added to your wish list successfully');
      log('product added to your wish list successfully');
    } else {
      AppRouter.showCustomDialog('some error occured while adding product to your wish list');
      log('some error occured while adding product to your wish list');
    }
  }

  getAllUserWishlist() async {
    allWishList =
    await FirestoreHelper.firestoreHelper.getAllUserWishlist(currentLoggedUser!.id! );

    notifyListeners();
    return allWishList;
  }

  removeProductFromWishlist(Product product) async {
    bool deleteSuccess =
    await FirestoreHelper.firestoreHelper.removeWishlistProduct(product , currentLoggedUser!.id!);
    if (deleteSuccess) {
      allWishList!.remove(product);
      notifyListeners();
      log('product removed from your wish list successfully');
    } else {
      log('some error occured while removing product to your wish list');
    }
  }
}
