import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:global_market/constants.dart';
import 'package:global_market/models/product.dart';

class ProductService {

  final databaseReference = FirebaseFirestore.
  instance.collection(kProductsCollection);


  // Future<void> addProductToFireStore(Product product) async {
  //   return await databaseReference.doc(product.pId).
  //   set(product.toJson());
  // }
  // // void uploadProduct(Map<String, dynamic> data) {
  // //   var id = Uuid();
  // //   String productId = id.v1();
  // //   data["id"] = productId;
  // //   databaseReference.collection(kProductsCollection)
  // //       .doc(productId).set(data);
  // // }
  //
  // Future<List<Product>> getProducts()async {
  //   databaseReference.get().then((result) {
  //     List<Product> products = [];
  //     for (DocumentSnapshot product in result.docs)
  //     {
  //       products.add(Product.fromJson(product[result]));
  //     }
  //     return products;
  //   });
  // }

  //
  // Future<List<Product>> searchProducts({String productName}) {
  //   // code to convert the first character to uppercase
  //   String searchKey = productName[0].toUpperCase() + productName.substring(1);
  //   return databaseReference
  //       .orderBy("name").startAt([searchKey])
  //       .endAt([searchKey + '\uf8ff']).get().then((result) {
  //     List<Product> products = [];
  //     for (DocumentSnapshot product in result.docs) {
  //       products.add(Product.fromJson(product[result]));
  //     }
  //     return products;
  //   });
  // }


}