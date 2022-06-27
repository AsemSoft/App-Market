import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_market/constants.dart';
import 'package:global_market/main.dart';
import 'package:global_market/models/product.dart';
import 'package:global_market/screens/admin/editProduct.dart';
import 'package:global_market/services/store.dart';
import 'package:global_market/translations/locale_keys.g.dart';
import 'package:global_market/widgets/customMenu.dart';
import 'package:easy_localization/easy_localization.dart';
class ManageProduct extends StatefulWidget {
  static String id = 'ManageProduct ';
  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  // int _tabBarIndex = 0;
  List<Product> products;
  Store _store = Store();

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      // الوسط والشريك السفلي
      DefaultTabController(
          length: 4,
          child: Scaffold(
            //الشريط العلوي

            appBar: AppBar(
              centerTitle: true,
              title: Text(LocaleKeys.Manage_products.tr(),style: TextStyle(color: Colors.black),),
              iconTheme: IconThemeData(color: Colors.black),
              elevation: 0,

            ),
            // الشريط الوسط
            body:StreamBuilder<QuerySnapshot>(
          stream: _store.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // List <FileImage> fileImage=[];
            List<Product> _products = [];
            for (var doc in snapshot.data.docs) {
              var data = doc;
              _products.add(Product(
                  pId: doc.id,
                  pName: data[kProductName],
                  pPrice: data[kProductPrice],
                  pDescription: data[kProductDescription],
                  pImg: data[kProductImg],
                  pCategory: data[kProductCategory],
                  brand: data[kPBrand]
              ));

              //fileImage.add(FileImageProduct(pImg:data[kProductImgg]));

            }
            // allProducts = [..._products];
            // _products = getProductByBrand(pCategory, allProducts);
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.8),
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
                  onTapUp: (details) {
                    double dx = details.globalPosition.dx;
                    double dy = details.globalPosition.dy;
                    double dx2 = MediaQuery.of(context).size.width - dx;
                    double dy2 = MediaQuery.of(context).size.width - dy;
                    showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                        items: [
                          MyPopupMenuItem(
                            onClick: () {
                              Navigator.pushNamed(context, EditProduct.id, arguments: _products[index]);
                              print('Clicked');
                            },
                            child: Text(LocaleKeys.Edit.tr()),
                          ),
                          MyPopupMenuItem(
                            onClick: () async{
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
                                        _store.deleteProduct(_products[index].pId);
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
                                      Icon(Icons.warning),
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
                            child: Text(LocaleKeys.Delete.tr()),
                          ),
                        ]);
                  },
                  child: Stack(children: <Widget>[
                    Positioned.fill(
                      child:Image(
                        fit: BoxFit.fill,
                        image: AssetImage(_products[index].pImg),)
                      // ):Image.network("${_products[index].pImg}"),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Opacity(
                        opacity: 0.6,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(_products[index].pName,
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('\$ ${_products[index].pPrice}')
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
              itemCount: _products.length,
            );
          } else {
            return Center(child: Text(LocaleKeys.Loading.tr()));
          }
        })

            // الشريط السفلي
          )
      ),



    ]);

  }


}
