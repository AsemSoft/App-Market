import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_market/main.dart';
import 'package:global_market/models/product.dart';
import 'package:global_market/screens/home1.dart';
import 'package:global_market/services/store.dart';
import 'package:global_market/translations/locale_keys.g.dart';
import '../../constants.dart';
import 'package:easy_localization/easy_localization.dart';
class OrderDetails extends StatelessWidget {
  static String id = 'OrderDetails';
  Store store = Store();
  @override
  Widget build(BuildContext context) {
    String documentId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(

        title:Text(LocaleKeys.Manage_orders.tr()),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: store.loadOrderDetails(documentId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> products = [];
              for (var doc in snapshot.data.docs) {
                products.add(Product(
                  pName: doc[kProductName],
                  pQuantity: doc[kProductQuantity],
                  pCategory: doc[kProductCategory],
                  pPrice: doc[kProductPrice],
                  brand: doc[kPBrand]
                ));
              }
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height * .3,
                          //color: kSecondaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(LocaleKeys.Product_name.tr()+': ${products[index].pName}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                SizedBox(height: 10,),
                                Text(LocaleKeys.Quantity.tr()+': ${products[index].pQuantity}', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                                SizedBox(height: 10,),
                                Text(LocaleKeys.Product_category.tr()+': ${products[index].pCategory}', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                                SizedBox(height: 10,),
                                Text(LocaleKeys.Product_brand.tr()+': ${products[index].brand}', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                                SizedBox(height: 10,),
                                Text(LocaleKeys.Product_price.tr()+': \$${products[index].pPrice}', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      itemCount: products.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: ButtonTheme(
                            child: MaterialButton(
                              color: Home1.changColor(),
                              onPressed: () {},
                              child: Text(LocaleKeys.Confirm_Order.tr()),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ButtonTheme(
                            child: MaterialButton(
                              color: Home1.changColor(),
                              onPressed: ()async {
                                Container alertDialog = Container(
                                  child: AlertDialog(
                                    actions: <Widget>[
                                      MaterialButton(
                                        color: MyApp.tm==ThemeMode.light?kColor:Colors.grey,
                                        onPressed: ()
                                        {

                                          SnackBar(
                                            content: Text(LocaleKeys.Delete_done.tr()),
                                          );
                                          store.deleteOrder(documentId);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          print('Deleted');

                                        },
                                        child: Text(LocaleKeys.Yes.tr(),
                                        ),
                                      ),
                                      MaterialButton(
                                        color: MyApp.tm==ThemeMode.light?kColor:Colors.grey,
                                        onPressed: ()
                                        {
                                          Navigator.pop(context);
                                        },

                                        child: Text(
                                          LocaleKeys.No.tr(),
                                        ),
                                      ),
                                    ],
                                    content: Container(
                                      height: 60,
                                      child: Text(
                                        LocaleKeys.Do_you_want_to_delete.tr(),
                                        style: TextStyle(color: Colors.black87, fontSize: 16),
                                      ),
                                    ),
                                    title:  Row(
                                      children: [
                                        Text(LocaleKeys.Warning_Delete.tr()),
                                        SizedBox(width: 20),
                                        Icon(Icons.warning,color: MyApp.tm==ThemeMode.light?kColor:Colors.grey,),
                                      ],

                                    ),
                                  ),
                                );
                                await showDialog(
                                    context: context,
                                    builder: (context) {
                                  return alertDialog;
                                });

                              },
                              child: Text(LocaleKeys.Delete_Order.tr()),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text(LocaleKeys.Loading.tr()),
              );
            }
          }),
    );
  }
}

