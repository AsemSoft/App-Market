import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:global_market/constants.dart';
import 'package:global_market/main.dart';
import 'package:global_market/models/product.dart';
import 'package:global_market/screens/about.dart';
import 'package:global_market/screens/home1.dart';
import 'package:global_market/screens/login_screen.dart';
import 'package:global_market/screens/myAccount.dart';
import 'package:global_market/screens/signup_screen.dart';
import 'package:global_market/screens/users/allCategory.dart';
import 'package:global_market/screens/users/allPages.dart';
import 'package:global_market/screens/users/cartScreen.dart';
import 'package:global_market/screens/users/productInfo.dart';
import 'package:global_market/services/store.dart';
import 'package:global_market/translations/locale_keys.g.dart';
import 'package:global_market/widgets/imageCarosel.dart';
import 'package:easy_localization/easy_localization.dart';

final databaseReference = FirebaseFirestore.instance;

class HomePage extends StatefulWidget {
  static String id = 'HomePage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//   File _image;
  bool english = false;
  // final picker = ImagePicker();
  Store _store = Store();
  // Future getImage(ImageSource src) async {
  //   final pickedFile = await picker.pickImage(source: src);
  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No Image');
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // Users users =ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: false,
        title: Text(
          LocaleKeys.title.tr(),
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
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
                }
                else {
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
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName:Home1.userName==''?Text(LocaleKeys.Visitor.tr()):Text(Home1.userName),
              accountEmail: Text(Home1.email),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  child:Home1.userImg==''? Icon(
                    Icons.person,
                    color: Colors.white,
                  ):Image.asset(Home1.userImg),
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
                Navigator.pushNamed(context, HomePage.id);
              },
            ),
            Home1.userName==''?ExpansionTile(
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
            ) :Container(
              height: 0,
            ),
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
                Navigator.pushNamed(context, About.id);
              },
            ),
            Home1.userName!=''? ListTile(
              leading: Icon(Icons.logout, color: Colors.black),
              title: Text(LocaleKeys.Logout.tr(),
                  style: TextStyle(
                    color: Colors.black,
                  )),
              onTap: () {
                Navigator.pop(context);
                Home1.isLoggedIn=false;
                Home1.email='';
                Home1.userName='';
                Home1.userPhone='';
                Home1.userImg='';
                Navigator.pushNamed(context, HomePage.id);


              },
            ):Container(height: 0,),
          ],
        ),
      ),
      //drawerScrimColor: Colors.pinkAccent.withOpacity(0.3),
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> _products = [];
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
                print(_products[i].brand);
                print(_products[i].pCategory);
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
                ListView(
                  children: [
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
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
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
                                AllPages.selectedCategory ='Computers';
                                AllPages.brandName = ['Toshiba','Acer','Dell','HP'];
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
                                AllPages.brandName = ['Redmi','Samsung','LT','Huawei'];
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
                                AllPages.brandName =['Sonic','Casio','Redmi','Samsung'];
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
                                AllPages.brandName = ['LT','Remax','Redmi','Samsung'];
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
                        ),
                      ),
                    ]),
                    Container(
                      height: 10,
                      color: Colors.white,
                    ),
                    // صورة

                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 420),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 0.8),
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context,ProductInfo.id,arguments:_products[index]);
                        },
                        child: Stack(children: <Widget>[
                          Positioned.fill(
                            child: Image(
                              fit: BoxFit.fill,
                              image: AssetImage(_products[index].pImg),
                            ),
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(_products[index].pName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
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
                  ),
                ),
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
                                  Navigator.pushNamed(context, HomePage.id);
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
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, LoginScreen.id);
                                      }),
                                  IconButton(
                                      icon: Icon(Icons.shopping_cart,
                                          color: Colors.black),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, CartScreen.id);
                                      }),
                                  Container(
                                    width:
                                    MediaQuery.of(context).size.width * .20,
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.category, color: Colors.black),
                                      onPressed: () {
                                        Navigator.pushNamed(context, AllCategories.id);
                                      }),
                                  IconButton(
                                      icon: Icon(Icons.info, color: Colors.black),
                                      onPressed: () {
                                        Navigator.pushNamed(context, About.id);
                                      }),
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
              return Center(child: Text(LocaleKeys.Loading.tr()));
            }
          }),
    );
  }

  // Future uploadFile() async {
  //   if (_image == null) return;
  //   final fileName = basename(_image.path);
  //   final destination = 'files/$fileName';
  //   FirebaseApi.uploadFile(destination, _image);
  // }
}

// class FirebaseApi {
//   static UploadTask uploadFile(String destination, File file) {
//     try {
//       final ref = FirebaseStorage.instance.ref().child(destination);
//       return ref.putFile(file);
//     } on FirebaseException catch (e) {
//       print(e);
//     }
//   }
// }

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

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:global_market/constants.dart';
// import 'package:global_market/models/product.dart';
// import 'package:global_market/screens/home1.dart';
// import 'package:global_market/services/auth.dart';
// import 'package:global_market/services/store.dart';
// import 'package:global_market/widgets/productView.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../login_screen.dart';
// import 'cartScreen.dart';
// class HomePage extends StatefulWidget
// {
//   static String id = 'HomePage';
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final _auth = Auth();
//   int _tabBarIndex = 0;
//   int _bottomBarIndex = 0;
//   final _store = Store();
//   List<Product> products;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//         children: <Widget>[
//       // الوسط والشريك السفلي
//       DefaultTabController(
//           length: 4,
//           child: Scaffold(
//             //الشريط العلوي
//               appBar: AppBar(
//                 title: Text('Phone Part',style: TextStyle(color: Colors.black),),
//                 iconTheme: IconThemeData(color: Colors.black),
//               centerTitle: true,
//               elevation: 0,
//               bottom: TabBar(
//                 indicatorColor: kMainColor,
//                 onTap: (value) {
//                   setState(() {
//                     _tabBarIndex = value;
//                   });
//                 },
//                 tabs: <Widget>[
//                   Text(
//                     'Samsung',
//                     style: TextStyle(
//                       color: _tabBarIndex == 0 ? Colors.black : kUnActiveColor,
//                       fontSize: _tabBarIndex == 0 ? 13 : null,
//                     ),
//                   ),
//                   Text(
//                     'Redmi',
//                     style: TextStyle(
//                         color:
//                             _tabBarIndex == 1 ? Colors.black : kUnActiveColor,
//                         fontSize: _tabBarIndex == 1 ? 16 : null),
//                   ),
//                   Text(
//                     'Huawei',
//                     style: TextStyle(
//                         color:
//                             _tabBarIndex == 2 ? Colors.black : kUnActiveColor,
//                         fontSize: _tabBarIndex == 2 ? 16 : null),
//                   ),
//                   Text(
//                     'LT',
//                     style: TextStyle(
//                         color:
//                             _tabBarIndex == 3 ? Colors.black : kUnActiveColor,
//                         fontSize: _tabBarIndex == 3 ? 16 : null),
//                   ),
//                 ],
//               ),
//             ),
//             // الشريط الوسط
//             body: TabBarView(
//               children: <Widget>[
//                 productView(kSamsung, products),
//                 productView(kRedmi, products),
//                 productView(kHuawei, products),
//                 productView(kLT, products),
//               ],
//             ),
//             // الشريط السفلي
//             bottomNavigationBar: BottomNavigationBar(
//               backgroundColor:Home1.changColor(),
//               type: BottomNavigationBarType.fixed,
//               //unselectedItemColor: kUnActiveColor,
//
//               fixedColor:  Colors.white,
//               onTap: (value)async{
//                 if(value==2){
//                   SharedPreferences prof= await SharedPreferences.getInstance();
//                   prof.clear();
//                   await _auth.signOut();
//                   Navigator.pop(context);
//                   Navigator.pushNamed(context, LoginScreen.id);
//                 }
//                 setState(() {
//                   _bottomBarIndex = value;
//                 });
//               },
//               items: [
//                 BottomNavigationBarItem(
//                     title: Text('حول التطبيق'), icon: Icon(Icons.help)),
//                 BottomNavigationBarItem(
//                     title: Text('معلومات'), icon: Icon(Icons.info)),
//                 BottomNavigationBarItem(
//                     title: Text('تسجيل الخروج'), icon: Icon(Icons.login_outlined)),
//               ],
//             ),
//           )
//       ),
//
//     ]);
//   }
//   // Widget samsungView() {
//   //   return StreamBuilder<QuerySnapshot>(
//   //       stream: _store.loadProducts(),
//   //       builder: (context, snapshot) {
//   //         if (snapshot.hasData) {
//   //           List<Product> _products = [];
//   //           for (var doc in snapshot.data.docs) {
//   //             var data = doc;
//   //             _products.add(Product(
//   //               pId: doc.id,
//   //               pName: data[kProductName],
//   //               pPrice: data[kProductPrice],
//   //               pDescription: data[kProductDescription],
//   //               pImg: data[kProductImg],
//   //               pCategory: data[kProductCategory],
//   //             ));
//   //           }
//   //           products = [..._products];
//   //           _products.clear();
//   //           _products = getProductByCategory(kSamsung, products);
//   //           return GridView.builder(
//   //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//   //                 crossAxisCount: 2, childAspectRatio: 0.8),
//   //             itemBuilder: (context, index) => Padding(
//   //               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//   //               child: GestureDetector(
//   //                 onTap: () {
//   //                   Navigator.pushNamed(context, ProductInfo.id, arguments: _products[index]);
//   //                 },
//   //                 child: Stack(children: <Widget>[
//   //                   Positioned.fill(
//   //                     child: Image(
//   //                       fit: BoxFit.fill,
//   //                       image: AssetImage(_products[index].pImg),
//   //                     ),
//   //                   ),
//   //                   Positioned(
//   //                     bottom: 0,
//   //                     child: Opacity(
//   //                       opacity: 0.6,
//   //                       child: Container(
//   //                         width: MediaQuery.of(context).size.width,
//   //                         height: 60,
//   //                         color: Colors.white70,
//   //                         child: Padding(
//   //                           padding: EdgeInsets.symmetric(
//   //                               horizontal: 10, vertical: 5),
//   //                           child: Column(
//   //                             crossAxisAlignment: CrossAxisAlignment.start,
//   //                             children: <Widget>[
//   //                               Text(_products[index].pName,
//   //                                   style: TextStyle(
//   //                                       color: Colors.black,
//   //                                       fontWeight: FontWeight.bold)),
//   //                               Text('\$ ${_products[index].pPrice}')
//   //                             ],
//   //                           ),
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   )
//   //                 ]),
//   //               ),
//   //             ),
//   //             itemCount: _products.length,
//   //           );
//   //         } else {
//   //           return Center(child: Text('Loading...'));
//   //         }
//   //       });
//   // }
// }

