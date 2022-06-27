import 'package:flutter/material.dart';
import 'package:global_market/constants.dart';
import 'package:global_market/models/product.dart';
import 'package:global_market/provider/cardItem.dart';
import 'package:global_market/screens/home1.dart';
import 'package:global_market/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'cartScreen.dart';

class ProductInfo extends StatefulWidget {
  static String id = 'ProductInfo';
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar:AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(LocaleKeys.Product_info.tr(),style: TextStyle(color: Colors.black),),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.id);
              }),
        ],
      ),
      body: Stack(
        children: <Widget>[
          //imageIfo
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,0,300),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage(product.pImg),
              ),
            ),
          ),
          // الوسط
          Positioned(
            bottom: 0,
            child: Column(
              children: <Widget>[
                //الوسط
                Opacity(
                  opacity: .5,
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .3,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      // تفاصيل المنتج الاسم والسعر ومعلومات
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //Name
                          Text(
                            product.pName,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          //description
                          Text(
                            product.pDescription,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          //price
                          Text(
                            product.pPrice + '\$',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          // عداد الكمية
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // زر زيادة عداد الكمية
                              ClipOval(
                                child: Material(
                                  color: kMainColor,
                                  child: GestureDetector(
                                    onTap: add,
                                    child: SizedBox(
                                      child: Icon(Icons.add),
                                      height: 28,
                                      width: 28,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                _quantity.toString(),
                                style: TextStyle(
                                  fontSize: 40,
                                  //fontWeight: FontWeight.w700,
                                ),
                              ),
                              // زر تنقيص العداد
                              ClipOval(
                                child: Material(
                                  color: kMainColor,
                                  child: GestureDetector(
                                    onTap: subtract,
                                    child: SizedBox(
                                      child: Icon(Icons.remove),
                                      height: 28,
                                      width: 28,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // الزر الاسفل
                Padding(
                  padding: const EdgeInsets.only(bottom:0),
                  child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .08,
                    child: Builder(
                      builder: (context) => RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                        ),
                        color: Home1.changColor(),
                        onPressed: () {
                          addToCart(context, product);
                        },
                        child: Text(LocaleKeys.add_to_cart.tr(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        print(_quantity);
      });
    }
  }
  add() {
    setState(() {
      _quantity++;
      print(_quantity);
    });
  }

  void addToCart(context, product) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    bool exist = false;
    var productsInCart = cartItem.products;
    for (var productInCart in productsInCart) {
      if (productInCart.pName == product.pName) {
        exist = true;
      }
    }
    if (exist) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(LocaleKeys.Add_To_Cart_Previously.tr()),
        ),
      );
      return;
    } else {
      if (_quantity != 0) {
        product.pQuantity = _quantity;
        cartItem.addProduct(product);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(LocaleKeys.Add_To_Cart_Is_Done.tr()),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('يجب عليك تحديد الكمية المطلوبة'),
          ),
        );
      }
    }
    //}
  }

}
