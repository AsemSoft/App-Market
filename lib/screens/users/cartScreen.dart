import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_market/constants.dart';
import 'package:global_market/functions.dart';
import 'package:global_market/main.dart';
import 'package:global_market/models/product.dart';
import 'package:global_market/provider/cardItem.dart';
import 'package:global_market/screens/home1.dart';
import 'package:global_market/screens/login_screen.dart';
import 'package:global_market/screens/signup_screen.dart';
import 'package:global_market/screens/users/homepage.dart';
import 'package:global_market/screens/users/productInfo.dart';
import 'package:global_market/services/store.dart';
import 'package:global_market/translations/locale_keys.g.dart';
import 'package:global_market/widgets/customMenu.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class CartScreen extends StatefulWidget {
  static String id = 'CartScreen';
  static bool emptyCart;

  @override
  _CartScreenState createState() => _CartScreenState();
}



class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItem>(context).products;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // الشريط العلوي
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),

        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.home, ),
              onPressed: () {
                Navigator.pushNamed(context, HomePage.id);
              }),
        ],
        elevation: 0,
        centerTitle: true,
        //backgroundColor: Colors.blueAccent,
        title: Text(LocaleKeys.cart.tr(),
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ),
      // الوسط
      body: Column(
        children: [
          // الوسط
          LayoutBuilder(
            builder: (context, constrains) {
              if (products.isNotEmpty) {
                return Container(
                  height: screenHeight -
                      (screenHeight * .08) -
                      appBarHeight -
                      statusBarHeight,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: GestureDetector(
                          onTapUp: (details) {
                            showCustomMenu(details, context, products[index]);
                          },
                          child: Container(
                            height: screenHeight * .15,
                            child: Row(children: <Widget>[
                              CircleAvatar(
                                radius: screenHeight * .15 / 2,
                                backgroundImage:
                                    AssetImage(products[index].pImg),
                                backgroundColor: Colors.black26,
                              ),
                              Expanded(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              products[index].pName,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 10),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Text(
                                                products[index].pPrice + '\$',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(products[index].pQuantity.toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    ]),
                              ),
                            ]),
                            color: Colors.white,

                            //Text(products[index].pName),
                            //Text(products[index].pQuantity.toString()),
                          ),
                        ),
                      );
                    },
                    itemCount: products.length,
                  ),
                );
              } else {
                return Container(
                  height: screenHeight -
                      (screenHeight * .08) -
                      appBarHeight -
                      statusBarHeight,
                  child: Center(
                    child: Text(LocaleKeys.Cart_empty.tr()),
                  ),
                );
              }
            },
          ),
          // زر الطلب
          Builder(
            builder: (context) => ButtonTheme(
              minWidth: screenWidth,
              height: screenHeight * .08,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )),
              child: MaterialButton(
                onPressed: () {
                  if (products.isEmpty == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(LocaleKeys.Cart_empty.tr())));
                  } else {
                    if (Home1.isLoggedIn == true) {
                      showCustomDialog(products, context);
                    } else {
                      showWarningForm(context);
                    }
                  }
                },
                child: Text(LocaleKeys.Buy_now.tr(),
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                color: Home1.changColor(),
              ),
            ),
          )
        ],
      ),
    );
  }

  void showCustomMenu(details, context, product) async {
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
              Navigator.pop(context);
              Provider.of<CartItem>(context, listen: false).deleteProductInCart(product);
              Navigator.pushNamed(context, ProductInfo.id, arguments: product);
            },
            child: Text(LocaleKeys.Edit.tr()),
          ),
          MyPopupMenuItem(
            onClick: () {},
            child: Divider(
              color: Colors.black,
            ),
          ),
          MyPopupMenuItem(
            onClick: () {
              Navigator.pop(context);
              Provider.of<CartItem>(context, listen: false).deleteProductInCart(product);
              //Navigator.pushNamed(context, CartScreen.id,arguments: product);
            },
            child: Text(LocaleKeys.Delete.tr()),
          ),
        ]);
  }
  void showCustomDialog(List<Product> products, context) async {
    var price = getTotalPrice(products);
    String address='';
    AlertDialog alertDialog = AlertDialog(
      actions: <Widget>[
        MaterialButton(
          color: MyApp.tm==ThemeMode.light?kColor:Colors.grey,
          onPressed: () {
            if (address=='') {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(LocaleKeys.Field_is_empty.tr())));
            }
            else{
              try {
                Store _store = Store();
                _store.storeOrder({
                  kUsersName: Home1.userName,
                  kEmail: Home1.email,
                  kPhone: Home1.userPhone,
                  kAddress: address,
                  kDate: DateTime.now().toString(),
                  kTotalPrice: price,
                }, products);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(LocaleKeys.Request_is_done.tr())));
                Navigator.pop(context);
              } catch (ex) {
                print(ex.message);
              }
            }
          },
          child: Text(LocaleKeys.Buy_now.tr()),
        )
      ],
      content: Container(
        height: 200,
        child: Column(
          children: [
            // Text(Home1.userName),
            Text(LocaleKeys.Total_price.tr() + ' =\$ $price'),
            TextField(
              onChanged: (value) {
                address = value;
              },
              decoration: InputDecoration(hintText: LocaleKeys.Location.tr()),
            ),
          ],
        ),
      ),
      title:  Row(
        children: [
          Text(LocaleKeys.Request_Now.tr()),
          SizedBox(width: 20),
          Icon(Icons.warning,color: MyApp.tm==ThemeMode.light?kColor:Colors.grey,),
        ],

      ),
    );
    await showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }
  void showWarningForm(context) async {
    Container alertDialog = Container(
      child: AlertDialog(
        actions: <Widget>[
          MaterialButton(
            color: MyApp.tm==ThemeMode.light?kColor:Colors.grey,
            onPressed: ()
            {
              Navigator.pop(context);
              Navigator.pushNamed(context, LoginScreen.id);
            },

            child: Text(
              LocaleKeys.login.tr(),
            ),
          ),
          MaterialButton(
            color: MyApp.tm==ThemeMode.light?kColor:Colors.grey,
            onPressed: ()
            {
              Navigator.pop(context);
              Navigator.pushNamed(context,SignupScreen.id);
            },

            child: Text(
                LocaleKeys.signup.tr(),
            ),
          ),
        ],
        content: Container(
          height: 40,
          child: Text(
            LocaleKeys.You_Have_To_Login.tr(),
            style: TextStyle(color: Colors.black87, fontSize: 16),
          ),
        ),
        title: Row(
          children: [
            Text(LocaleKeys.Warning_Login.tr()),
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
  }
  // void getLoginForm(List<Product> products, context) async {
  //   var email;
  //   var pass;
  //   Container alertDialog = Container(
  //     child: AlertDialog(
  //       actions: <Widget>[
  //         ElevatedButton(
  //           onPressed: () async {
  //             final modalHud = Provider.of<ModalHud>(context, listen: false);
  //             modalHud.changeisLoading(true);
  //             if (_globalKey.currentState.validate()) {
  //               _globalKey.currentState.save();
  //               {
  //                 try {
  //                   await _auth.signin(email, pass);
  //                   Home1.isLoggedIn = true;
  //                   for(var email in LoginScreen.user){
  //                   if(LoginScreen.email==email.email){
  //                     Home1.email=email.email;
  //                     Home1.userName=email.name;
  //                     Home1.userPhone=email.userPhone;
  //                     Home1.userImg=email.pic;
  //                   }}
  //                   Navigator.pop(context);
  //                   showCustomDialog(products, context);
  //                 } catch (e) {
  //                   modalHud.changeisLoading(false);
  //                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //                     content: Text(e.message),
  //                   ));
  //                 }
  //               }
  //             }
  //             modalHud.changeisLoading(false);
  //           },
  //           child: Text(
  //             LocaleKeys.login.tr(),
  //           ),
  //         )
  //       ],
  //       content: Container(
  //         height: 180,
  //         child: Column(
  //           children: <Widget>[
  //             TextField(
  //               onChanged: (value) {
  //                 email = value;
  //               },
  //               decoration:
  //                   InputDecoration(hintText: LocaleKeys.enter_your_email.tr()),
  //             ),
  //             TextField(
  //               onChanged: (value) {
  //                 pass = value;
  //               },
  //               decoration: InputDecoration(
  //                   hintText: LocaleKeys.enter_your_password.tr()),
  //             ),
  //             SizedBox(
  //               height: 10,
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: <Widget>[
  //                 Text(
  //                   LocaleKeys.Do_not_have_account.tr(),
  //                   style: TextStyle(color: Colors.black87, fontSize: 16),
  //                 ),
  //                 //end text don't have
  //                 // start label signup
  //                 GestureDetector(
  //                   onTap: () {
  //                     Navigator.pop(context);
  //                     logUpForm(products, context);
  //                   },
  //                   //start text don't have
  //                   child: Text(
  //                     ' ' + LocaleKeys.signup.tr(),
  //                     style: TextStyle(color: Colors.black, fontSize: 16),
  //                   ),
  //                 ),
  //                 //end label signup
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //       title: Text(LocaleKeys.Login_form.tr()),
  //     ),
  //   );
  //   await showDialog(
  //       context: context,
  //       builder: (context) {
  //         return alertDialog;
  //       });
  // }
  //
  // void logUpForm(List<Product> products, context) async {
  //   var _userName, _password, _email, phone;
  //   Container alertDialog = Container(
  //       child: AlertDialog(
  //     actions: <Widget>[
  //       ElevatedButton(
  //         onPressed: () async {
  //           Store _store = Store();
  //           final modalHud = Provider.of<ModalHud>(context, listen: false);
  //           modalHud.changeisLoading(true);
  //           if (_globalKey.currentState.validate()) {
  //             _globalKey.currentState.save();
  //             try {
  //               await _store.addUser(Users(
  //                 name: _userName,
  //                 pass: _password,
  //                 email: _email,
  //                 userType: phone,
  //               ));
  //               final authResult = await _auth.signup(_email, _password);
  //               modalHud.changeisLoading(false);
  //               print(authResult);
  //               Navigator.pop(context);
  //               getLoginForm(products, context);
  //             } catch (ex) {
  //               ScaffoldMessenger.of(context)
  //                   .showSnackBar(SnackBar(content: Text(ex)));
  //               print(ex.message);
  //             }
  //           }
  //           modalHud.changeisLoading(false);
  //         },
  //         child: Text(LocaleKeys.signup.tr()),
  //       )
  //     ],
  //     content: Container(
  //       height: 250,
  //       child: Column(
  //         children: <Widget>[
  //           TextField(
  //             onChanged: (value) {
  //               _email = value;
  //             },
  //             decoration:
  //                 InputDecoration(hintText: LocaleKeys.enter_your_email.tr()),
  //           ),
  //           TextField(
  //             onChanged: (value) {
  //               _password = value;
  //             },
  //             decoration: InputDecoration(
  //                 hintText: LocaleKeys.enter_your_password.tr()),
  //           ),
  //           TextField(
  //             onChanged: (value) {
  //               _userName = value;
  //             },
  //             decoration:
  //                 InputDecoration(hintText: LocaleKeys.enter_your_name.tr()),
  //           ),
  //           TextField(
  //             onChanged: (value) {
  //               phone = value;
  //             },
  //             decoration:
  //                 InputDecoration(hintText: LocaleKeys.Enter_phone_number.tr()),
  //             keyboardType: TextInputType.phone,
  //           ),
  //           SizedBox(
  //             height: 10,
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               Text(
  //                 LocaleKeys.Do_you_account.tr(),
  //                 style: TextStyle(color: Colors.black87, fontSize: 16),
  //               ),
  //               //end text don't have
  //               // start label signup
  //               GestureDetector(
  //                 onTap: () {
  //                   Navigator.pop(context);
  //                   getLoginForm(products, context);
  //                 },
  //                 //start text don't have
  //                 child: Text(
  //                   ' ' + LocaleKeys.login.tr(),
  //                   style: TextStyle(color: Colors.black, fontSize: 16),
  //                 ),
  //               ),
  //               //end label signup
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //     title: Text(LocaleKeys.Registration.tr()),
  //   ));
  //   await showDialog(
  //       context: context,
  //       builder: (context) {
  //         return alertDialog;
  //       });
  // }

  getTotalPrice(List<Product> products) {
    var price = 0;
    for (var product in products) {
      price += product.pQuantity * int.parse(product.pPrice);
    }
    return price;
  }
}
