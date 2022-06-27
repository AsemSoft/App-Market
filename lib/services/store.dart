import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:global_market/constants.dart';
import 'package:global_market/models/brand.dart';
import 'package:global_market/models/category.dart';
import 'package:global_market/models/product.dart';
import 'package:global_market/models/users.dart';

class Store {
  final databaseReference = FirebaseFirestore.instance;
  addUser(Users users) async {
    await databaseReference.collection(kUsers).add({
      kUsersName: users.name,
      kPass: users.pass,
      kEmail: users.email,
      kUserImg: users.pic,
      kPhone:users.userPhone
    });
  }
  addCategory(CategoryModel category)async{
    await databaseReference.collection(kCategoryCollection).doc(category.cateName).set({
      kCateName: category.cateName,
      kCateImg:category.cateImg

    });

  }
  addBrand(docId,Brand brand)async{
      await databaseReference.collection(kCategoryCollection).doc(docId).collection(kBrandCollection).doc(brand.brandName).set({
        kBrandName: brand.brandName,
        kBrandImg:brand.brandImg,
        kCategoryId:brand.categoryId
        ,
      });

  }
  addPoduct(Product product) async {
    await databaseReference.collection(kProductsCollection).add({
      kProductName: product.pName,
      kProductPrice: product.pPrice,
      kProductDescription: product.pDescription,
      kProductImg: product.pImg,
      kProductCategory: product.pCategory,
      kPBrand:product.brand
    });
  }
  addPoduct2(categoryModel,brand,Product product) async {
    await databaseReference.collection(kCategoryCollection).doc(categoryModel).collection(kBrandCollection).doc(brand).collection(kProductsCollection).add({
      kProductName: product.pName,
      kProductPrice: product.pPrice,
      kProductDescription: product.pDescription,
      kProductImg: product.pImg,
      kProductCategory: categoryModel,
      kPBrand:brand,
    });
  }
  Stream<QuerySnapshot> loadProducts() {
    return databaseReference.collection(kProductsCollection).snapshots();
  }
  Stream<QuerySnapshot> loadOrders() {
    return databaseReference.collection(kOrders).snapshots();
  }
  Stream<QuerySnapshot> loadCategories() {
    return  databaseReference.collection(kCategoryCollection).snapshots();
  }
  Stream<QuerySnapshot> loadBrand() {
    return  databaseReference.collection(kBrandCollection).snapshots();
  }
  Stream<QuerySnapshot> loadBrandCategories(docId) {
    return  databaseReference.collection(kCategoryCollection).doc(docId).collection(kBrandCollection).snapshots();
  }
  Stream<QuerySnapshot> loadOrderDetails(docId) {
    return databaseReference.collection(kOrders).doc(docId).collection(kOrderDetails).snapshots();
  }
  Stream<QuerySnapshot> loadUsers() {
    return databaseReference.collection(kUsers).snapshots();
  }
  checkUser(userId){
    databaseReference.collection(kUsers).doc(userId).get();

}
  deleteProduct(docId) {
    databaseReference.collection(kProductsCollection).doc(docId).delete();
  }
  deleteCategory(docId) {
    databaseReference.collection(kCategoryCollection).doc(docId).delete();
  }
  deleteBrand(docId) {
    databaseReference.collection(kBrandCollection).doc(docId).delete();
  }
  deleteOrder(docId) {
    databaseReference.collection(kOrders).doc(docId).delete();
  }
  editProduct(data, docId) {
    databaseReference.collection(kProductsCollection).doc(docId).update(data);
  }
  editCategory(data, docId) {
    databaseReference.collection(kCategoryCollection).doc(docId).update(data);
  }

  editBrand(data, docId) {
    databaseReference.collection(kBrandCollection).doc(docId).update(data);
  }
  // دالة لاضافة الطلب في قاعدة البيانات
  storeOrder(data, List<Product> products) {
    var docRef = databaseReference.collection(kOrders).doc();
    docRef.set(data);
    for (var product in products) {
      docRef.collection(kOrderDetails).doc().set({
        kProductName: product.pName,
        kProductPrice: product.pPrice,
        kProductQuantity: product.pQuantity,
        kProductImg: product.pImg,
        kProductCategory: product.pCategory,
        kPBrand:product.brand
      });
    }
  }
  storeProduct(data, List<Product> products) {
    var docRef = databaseReference.collection(kOrders).doc();
    docRef.set(data);
    for (var product in products) {
      docRef.collection(kOrderDetails).doc().set({
        kProductName: product.pName,
        kProductPrice: product.pPrice,
        kProductQuantity: product.pQuantity,
        kProductImg: product.pImg,
        kProductCategory: product.pCategory
      });
    }
  }
}
