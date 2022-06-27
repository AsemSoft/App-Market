import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:global_market/constants.dart';
import 'package:global_market/provider/adminMode.dart';
import 'package:global_market/provider/cardItem.dart';
import 'package:global_market/provider/modelHud.dart';
import 'package:global_market/screens/admin/addCategory.dart';
import 'package:global_market/screens/admin/addProduct.dart';
import 'package:global_market/screens/admin/addProduct_screen.dart';
import 'package:global_market/screens/admin/editCategory.dart';
import 'package:global_market/screens/admin/editProduct.dart';
import 'package:global_market/screens/admin/manageCategory.dart';
import 'package:global_market/screens/admin/manageProduct.dart';
import 'package:global_market/screens/admin/orderDetails.dart';
import 'package:global_market/screens/admin/ordersScreen.dart';
import 'package:global_market/screens/home1.dart';
import 'package:global_market/screens/admin/addBrand.dart';
import 'package:global_market/screens/login_screen.dart';
import 'package:global_market/screens/myAccount.dart';
import 'package:global_market/screens/signup_screen.dart';
import 'package:global_market/screens/admin/adminHome.dart';
import 'package:global_market/screens/users/allCategory.dart';
import 'package:global_market/screens/users/allPages.dart';
import 'package:global_market/screens/users/cartScreen.dart';
import 'package:global_market/screens/users/homepage.dart';
import 'package:global_market/screens/users/productInfo.dart';
import 'package:global_market/translations/codegen_loader.g.dart';
import 'package:global_market/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:global_market/screens/about.dart';
void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  // SharedPreferences.getInstance();
  runApp(
      EasyLocalization(
        path: 'assets/translations',
        supportedLocales: [
          Locale('en'),
          Locale('ar'),
        ],
        fallbackLocale:Locale('en') ,
        assetLoader: CodegenLoader(),
        child: MyApp(),
      ),

      );
}

class MyApp extends StatefulWidget {
  static ThemeMode tm=ThemeMode.light;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isUserLoggedIn =false;
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context,snapshot){
        if(!snapshot.hasData){

          return MaterialApp(
            home: Scaffold(
              body:Center(child: Text(LocaleKeys.Loading.tr()),),
            )
          );
        }
        else{
          // isUserLoggedIn=snapshot.data.getBool(kKeepLoggedIn)??false;
          return MultiProvider(
            providers:
            [
               ChangeNotifierProvider<ModalHud>(create: (context)=>ModalHud(),),
              ChangeNotifierProvider<CartItem>(create: (context)=>CartItem(),),
               ChangeNotifierProvider<AdminMode>(create: (context)=>AdminMode(),)
            ],
            child: MaterialApp(

              themeMode:MyApp.tm,
              theme: ThemeData(primaryColor: Colors.redAccent,canvasColor:kColor,iconTheme:IconThemeData(color: Colors.black),
            ),
              darkTheme: ThemeData(primaryColor: Colors.blueGrey,canvasColor: Colors.grey,iconTheme:IconThemeData(color: Colors.black)),
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              initialRoute:HomePage.id,
               //isUserLoggedIn ? HomePage.id : LoginScreen.id,
              routes: {
                LoginScreen.id : (context) => LoginScreen(),
                SignupScreen.id : (context) =>SignupScreen(),
                HomePage.id : (context) =>HomePage(),
                AdminHome.id : (context) =>AdminHome(),
                AddProduct.id : (context) =>AddProduct(),
                ManageProduct.id:(context) =>ManageProduct(),
                EditProduct.id: (context) =>EditProduct(),
                ProductInfo.id: (context) =>ProductInfo(),
                CartScreen.id : (context) => CartScreen(),
                OrderScreen.id : (context) => OrderScreen(),
                OrderDetails.id :(context) => OrderDetails(),
                Home1.id :(context) => Home1(),
                MyAccount.id:(context) =>MyAccount(),
                AddCategory.id:(context)=>AddCategory(),
                AddBrand.id:(context)=>AddBrand(),
                AddProduct1.id:(context)=>AddProduct1(),
                ManageCategory.id:(context)=>ManageCategory(),
                EditCategory.id:(context)=>EditCategory(),
                AllPages.id:(context)=>AllPages(),
                AllCategories.id:(context)=>AllCategories(),
                About.id:(context)=>About(),

              },

            ),
          );

        }
      },


    );
  }

}


