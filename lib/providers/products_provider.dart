import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ft_e_buy/Models/product.dart';

import '../helpers/firestore_helper.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Product? product ;

  // getProductFromFirestore(String prodId) async {
  //   product = await FirestoreHelper.firestoreHelper.getCategoryProducts(prodId);
  //   product!.id = prodId;
  //   notifyListeners();
  // }




}
