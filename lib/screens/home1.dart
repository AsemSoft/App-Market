import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:global_market/constants.dart';
import 'package:global_market/main.dart';
import 'package:global_market/models/product.dart';
import 'package:global_market/screens/login_screen.dart';
import 'package:global_market/screens/myAccount.dart';
import 'package:global_market/screens/signup_screen.dart';
import 'package:global_market/screens/users/allCategory.dart';
import 'package:global_market/screens/users/allPages.dart';
import 'package:global_market/screens/users/cartScreen.dart';
import 'package:global_market/services/store.dart';
import 'package:global_market/translations/locale_keys.g.dart';
import 'package:global_market/widgets/imageCarosel.dart';
import 'package:global_market/widgets/widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:easy_localization/easy_localization.dart';
final databaseReference = FirebaseFirestore.instance;
class Home1 extends StatefulWidget {
  static String id = 'Home1';
  static changMode() {
    if (MyApp.tm == ThemeMode.light) {
      MyApp.tm = ThemeMode.dark;
    } else {
      MyApp.tm = ThemeMode.light;
    }
  }
  static Color changColor() {
    return MyApp.tm == ThemeMode.light ? Colors.redAccent: Colors.blueGrey;
  }
  static String userName='';
  static String email='';
  static String userPhone='';
  static String userImg='';
  static bool isLoggedIn=false;

  @override
  _Home1State createState() => _Home1State();
}
class _Home1State extends State<Home1> {
  File _image;
  bool english = false;
  final picker = ImagePicker();
  Store _store = Store();
  Future getImage(ImageSource src) async {
    final pickedFile = await picker.pickImage(source: src);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No Image');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // List<Product> products = Provider.of<CartItem>(context).products;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: false,
        title: Text(
          LocaleKeys.title.tr(),
          style: TextStyle(color: Colors.black,
              fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
              ),
              onPressed: () {}
              ),
          new IconButton(
              icon: MyApp.tm == ThemeMode.light
                  ? Icon(
                      Icons.nightlight_round,

                    )
                  : Icon(
                      Icons.wb_sunny_rounded,

                    ),
              onPressed: () async {
                setState(() {
                  Home1.changMode();
                });
                if (english == false) {
                  await context.setLocale(Locale('en'));
                  await context.setLocale(Locale('ar'));
                } else {
                  await context.setLocale(Locale('ar'));
                  await context.setLocale(Locale('en'));
                }
              }),
          new IconButton(
              icon: Icon(
                Icons.shopping_cart,

              ),
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.id);
              }),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [kMainColor1, kMainColor2],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              )),
        ),

      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text("Visitor"),
              accountEmail: Text(''),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  child:Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            //home
            ListTile(
              leading: Icon(Icons.home, color: Colors.black),
              title: Text(LocaleKeys.home.tr(),
                  style: TextStyle(
                    color: Colors.black,
                  )),
              onTap: () {
                Navigator.pushNamed(context, Home1.id);
              },
            ),
            //account
            ExpansionTile(
              leading: Icon(Icons.person, color: Colors.black),
              trailing: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black,
              ),
              title: Text(
                LocaleKeys.myAccount.tr(),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              children: [
                ListTile(
                  leading: Icon(Icons.login, color: Colors.black),
                  title: Text(LocaleKeys.login.tr(),
                      style: TextStyle(
                        color: Colors.black,
                      )),
                  onTap: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person_add_alt, color: Colors.black),
                  title: Text(LocaleKeys.signup.tr(),
                      style: TextStyle(
                        color: Colors.black,
                      )),
                  onTap: () {
                    Navigator.pushNamed(context, SignupScreen.id);
                  },
                ),
              ],
            ),
            //all category
            ListTile(
              leading: Icon(Icons.category, color: Colors.black),
              title: Text(LocaleKeys.All_Category.tr(),
                  style: TextStyle(
                    color: Colors.black,
                  )),
              onTap: () {
                Navigator.pushNamed(context, AllCategories.id);
              },
            ),
            ExpansionTile(
              leading: Icon(Icons.language, color: Colors.black),
              trailing: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black,
              ),
              title: Text(
                LocaleKeys.language.tr(),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              children: [
                ListTile(
                    title: Text(LocaleKeys.arabic.tr()),
                    onTap: () async {
                      english = false;
                      await context.setLocale(Locale('ar'));
                    }),
                ListTile(
                    title: Text(LocaleKeys.english.tr()),
                    onTap: () async {
                      english = true;
                      await context.setLocale(Locale('en'));
                    }),
              ],
            ),
            ListTile(
              leading: Icon(Icons.info_outline, color: Colors.black),
              title: Text(LocaleKeys.About_us.tr(),
                  style: TextStyle(
                    color: Colors.black,
                  )),
              onTap: () {
                Navigator.pushNamed(context, AllCategories.id);
              },
            ),
          ],
        ),
      ),
      //drawerScrimColor: Colors.pinkAccent.withOpacity(0.3),
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> _products = [];
              List<String> productsCategories = [];
               // List<String> productCom = [];
               // List<String> productPhone = [];
               // List<String> productWatch = [];
               // List<String> productA = [];
              int i = 0;
              for (var doc in snapshot.data.docs) {
                _products.add(Product(
                    pId: doc.id,
                    pName: doc[kProductName],
                    pPrice: doc[kProductPrice],
                    pDescription: doc[kProductDescription],
                    pImg: doc[kProductImg],
                    pCategory: doc[kProductCategory],
                    brand: doc[kPBrand]));
                productsCategories.add(_products[i].pCategory);
                // if (_products[i].pCategory == 'Computers') {
                //   productCom.add(_products[i].brand);
                //   print(_products[i].brand);
                // }
                // else if (_products[i].pCategory == 'Phones') {
                //   productPhone.add(_products[i].brand);
                // }
                // else if (_products[i].pCategory == 'Watches') {
                //   productWatch.add(_products[i].brand);
                // }
                // else if (_products[i].pCategory == 'Accessories') {
                //   productA.add(_products[i].brand);
                // }
                // else{
                //   print('no');
                // }
                // print(_products[i].brand);
                i++;
              }
              print('i$i');
              return Stack(children: [
                  ListView(children: [
                    imageCarousel,
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 10,
                      color: Colors.white,
                    ),
                    // HorizontalList(),
                    SizedBox(
                      height: 10,
                    ),
                    // الشريط الافقي
                    Stack(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child:Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  AllPages.titleName = LocaleKeys.All_Category.tr();
                                  Navigator.pushNamed(context, AllCategories.id);
                                },
                                child: Column(
                                  children: [
                                    ClipOval(
                                        child: Container(
                                            height: 70,
                                            width: 70,
                                            color: Colors.white70,
                                            child: Icon(
                                              Icons.category,
                                              size: 60,
                                            ))),
                                    Text(LocaleKeys.All_Category.tr())
                                  ],
                                ),
                              ),
                              SizedBox(width: 15),
                              GestureDetector(
                                onTap: () {
                                  AllPages.selectedCategory = 'Computers';
                                  AllPages.brandName = ['Toshiba', 'Acer', 'Dell', 'HP'];
                                  AllPages.titleName = LocaleKeys.Computers.tr();
                                  Navigator.pushNamed(context, AllPages.id);
                                },
                                child: Column(
                                  children: [
                                    ClipOval(
                                        child: Container(
                                            height: 70,
                                            width: 70,
                                            color: Colors.white70,
                                            child: Icon(
                                              Icons.computer,
                                              size: 60,
                                            ))),
                                    Text(LocaleKeys.Computers.tr())
                                  ],
                                ),
                              ),
                              SizedBox(width: 15),
                              GestureDetector(
                                onTap: () {
                                  AllPages.selectedCategory = 'Phones';
                                  AllPages.brandName = ['Redmi', 'Samsung', 'LT', 'Huawei'];
                                  AllPages.titleName = LocaleKeys.phones.tr();
                                  Navigator.pushNamed(context, AllPages.id);
                                },
                                child: Column(
                                  children: [
                                    ClipOval(
                                        child: Container(
                                            height: 70,
                                            width: 70,
                                            color: Colors.white70,
                                            child: Icon(
                                              Icons.phone_android,
                                              size: 60,
                                            ))),
                                    Text(LocaleKeys.phones.tr()),
                                  ],
                                ),
                              ),
                              SizedBox(width: 15),
                              GestureDetector(
                                onTap: () {
                                  AllPages.selectedCategory = 'Watches';
                                  AllPages.brandName = ['Sonic', 'Casio', 'Redmi', 'Samsung'];
                                  AllPages.titleName = LocaleKeys.Watches.tr();
                                  Navigator.pushNamed(context, AllPages.id);
                                },
                                child: Column(
                                  children: [
                                    ClipOval(
                                        child: Container(
                                            height: 70,
                                            width: 70,
                                            color: Colors.white70,
                                            child: Icon(
                                              Icons.watch,
                                              size: 60,
                                            ))),
                                    Text(LocaleKeys.Watches.tr())
                                  ],
                                ),
                              ),
                              SizedBox(width: 15),
                              GestureDetector(
                                onTap: () {
                                  AllPages.selectedCategory = 'Accessories';
                                  AllPages.brandName = ['LT', 'Remax', 'Redmi', 'Samsung'];
                                  AllPages.titleName = LocaleKeys.accessories.tr();
                                  Navigator.pushNamed(context, AllPages.id);
                                },
                                child: Column(
                                  children: [
                                    ClipOval(
                                        child: Container(
                                            height: 70,
                                            width: 70,
                                            color: Colors.white70,
                                            child: Icon(
                                              Icons
                                                  .local_convenience_store_rounded,
                                              size: 60,
                                            ))),
                                    Text(LocaleKeys.accessories.tr())
                                  ],
                                ),
                              ),
                              SizedBox(width: 15),
//Row(children:<Widget>[]),
                            ],
                          )
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: 8,
                    ),
                    // صورة
                    Container(
                      height: 10,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              LocaleKeys.view_all.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              LocaleKeys.Best_brand.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .38,
                          child: Column(
                            children: <Widget>[
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      color: Colors.white,
                                      width: 123.5,
                                      height: 90,
                                      //MediaQuery.of(context).size.height * .15,
                                      child: Image.asset(
                                        'images/icons/LT.jpeg',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white,
                                      width: 123.5,
                                      height: 90,
                                      //MediaQuery.of(context).size.height * .15,
                                      child: Image.asset(
                                        'images/icons/h.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white,
                                      width: 123.5,
                                      height: 90,
                                      //MediaQuery.of(context).size.height * .15,
                                      child: Image.asset(
                                        'images/icons/am.jpeg',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ]),
                              SizedBox(height: 1),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      color: Colors.white,
                                      width: 123.5,
                                      height: 90,
                                      //MediaQuery.of(context).size.height * .15,
                                      child: Image.asset(
                                        'images/icons/mi.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white,
                                      width: 123.5,
                                      height: 90,
                                      //MediaQuery.of(context).size.height * .15,
                                      child: Image.asset(
                                        'images/icons/son.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white,
                                      width: 123.5,
                                      height: 90,
                                      //MediaQuery.of(context).size.height * .15,
                                      child: Image.asset(
                                        'images/icons/sam.jpeg',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ]),
                              SizedBox(height: 1),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      color: Colors.white,
                                      width: 123.5,
                                      height: 90,
                                      //MediaQuery.of(context).size.height * .15,
                                      child: Image.asset(
                                        'images/icons/red.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white,
                                      width: 123.5,
                                      height: 90,
                                      //MediaQuery.of(context).size.height * .15,
                                      child: Image.asset(
                                        'images/icons/mot1.jpeg',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white,
                                      width: 123.5,
                                      height: 90,
                                      //MediaQuery.of(context).size.height * .15,
                                      child: Image.asset(
                                        'images/icons/Appel.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ]),
                            ],
                          )),
                    ),
                    Container(
                      height: 100,
                      color: Colors.white,
                    ),
                  ]),
                  Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 80,
                          child: Stack(
                            children: [
                              CustomPaint(
                                size: Size(MediaQuery.of(context).size.width, 80),
                                painter: BNBCustomPainter(),
                              ),
                              Center(
                                heightFactor: 0.6,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, Home1.id);
                                  },
                                  backgroundColor: Home1.changColor(),
                                  child: Icon(
                                    Icons.home,
                                    color: Colors.black,
                                  ),
                                  elevation: 0.1,
                                ),
                              ),
                              Container(
                                height: 80,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        icon: Icon(
                                          Icons.person,

                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, MyAccount.id);
                                        }),
                                    IconButton(
                                        icon: Icon(Icons.shopping_cart,
                                            ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, CartScreen.id);
                                        }),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width * .20,
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.category,),
                                        onPressed: () {
                                          Navigator.pushNamed(context, AllCategories.id);
                                        }),
                                    IconButton(
                                        icon: Icon(Icons.info),
                                        onPressed: () {}),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ]);
            } else {
              return Center(child: Text('Loading...'));
            }
          }),
    );
  }

  Future uploadFile() async {
    if (_image == null) return;
    final fileName = basename(_image.path);
    final destination = 'files/$fileName';
    FirebaseApi.uploadFile(destination, _image);
  }
}

class FirebaseApi {
  static UploadTask uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref().child(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Home1.changColor()
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width * .20, 0, size.width * .35, 0);
    path.quadraticBezierTo(size.width * .40, 0, size.width * .40, 20);
    path.arcToPoint(Offset(size.width * .6, 20),
        radius: Radius.circular(10.0), clockwise: false);
    path.quadraticBezierTo(size.width * .6, 0, size.width * .65, 0);
    path.quadraticBezierTo(size.width * .80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, Colors.white, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
