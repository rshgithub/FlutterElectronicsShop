import 'dart:ffi';

class Product {

  String? id , prodName , imgPath , prodDesc , prodCatId;
  double? prodPrice , prodDiscountPrice ;

  Product({this.id,this.prodName, this.imgPath, this.prodDesc, this.prodPrice, this.prodDiscountPrice , this.prodCatId});

  toMap() {
    return {"prodName": prodName, "imgPath": imgPath, "prodDesc": prodDesc, "prodPrice": prodPrice, "prodDiscountPrice": prodDiscountPrice, "prodCatId": prodCatId};
  }

  Product.fromMap(Map<String, dynamic> map) {
    id = map['id']?? ' ';
    prodName = map['prodName']?? ' ';
    imgPath = map['imgPath']?? ' ';
    prodDesc = map['prodDesc']?? ' ';
    prodPrice = map['prodPrice']?? ' ';
    prodDiscountPrice = map['prodDiscountPrice']?? ' ';
    prodCatId = map['prodCatId']?? ' ';
  }

}