import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_market/screens/admin/addProduct.dart';
import 'package:global_market/translations/locale_keys.g.dart';
import 'manageProduct.dart';
import 'ordersScreen.dart';
import 'package:easy_localization/easy_localization.dart';
class AdminHome extends StatelessWidget
{
  static String id='AdminHome';
  @override
  Widget build(BuildContext context){
    return  Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Admin_page.tr(),style: TextStyle(color: Colors.black),),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:<Widget> [
          SizedBox(
            width: double.infinity,
          ),
          // Cat
          // ExpansionTile(
          //   collapsedBackgroundColor:Colors.white ,
          //   leading: Icon(Icons.category_rounded,color: Colors.black,),
          //   trailing:Icon(Icons.keyboard_arrow_down,color: Colors.black,) ,
          //   title: Text("Manage Categories",style: TextStyle(fontWeight:FontWeight.bold,fontSize:18,color: Colors.black),textAlign: TextAlign.center,),
          //   children: [
          //     ElevatedButton(
          //       style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
          //       onPressed:(){Navigator.pushNamed(context,AddCategory.id);},
          //       child: Container(
          //           alignment: Alignment.center,
          //           height: 60,
          //           width: MediaQuery.of(context).size.width*.9,
          //           child: Text('Add Category',style: TextStyle(color: Colors.black),)),
          //     ),
          //     SizedBox(height: 10,),
          //     ElevatedButton(
          //       style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
          //       onPressed:() {Navigator.pushNamed(context,ManageCategory.id);},
          //       child: Container(
          //           alignment: Alignment.center,
          //           height: 60,
          //           width: MediaQuery.of(context).size.width*.9,
          //           child: Text('Edit Categories',style: TextStyle(color: Colors.black),)),
          //     ),
          //     SizedBox(height: 10,),
          //   ],
          // ),
          // SizedBox(height: 10,),
          // // Brand
          // ExpansionTile(
          //   collapsedBackgroundColor:Colors.white ,
          //   leading: Icon(Icons.branding_watermark,color: Colors.black,),
          //   trailing:Icon(Icons.keyboard_arrow_down,color: Colors.black,) ,
          //   title: Text("Manage Brands",style: TextStyle(fontWeight:FontWeight.bold,fontSize:18,color: Colors.black),textAlign: TextAlign.center,),
          //   children: [
          //     ElevatedButton(
          //       style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
          //       onPressed:() {Navigator.pushNamed(context,AddBrand.id);},
          //       child: Container(
          //           alignment: Alignment.center,
          //           height: 60,
          //           width: MediaQuery.of(context).size.width*.9,
          //           child: Text('Add Brand',style: TextStyle(color: Colors.black),)),
          //     ),
          //     SizedBox(height: 10,),
          //     ElevatedButton(
          //       style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
          //       onPressed:() {Navigator.pushNamed(context,AddBrand.id);},
          //       child: Container(
          //           alignment: Alignment.center,
          //           height: 60,
          //           width: MediaQuery.of(context).size.width*.9,
          //           child: Text('Edit Brands',style: TextStyle(color: Colors.black),)),
          //     ),
          //     SizedBox(height: 10,),
          //   ],
          // ),
          // SizedBox(height: 10,),
          //Products
          // ExpansionTile(
          //   collapsedBackgroundColor:Colors.white ,
          //   leading: Icon(Icons.work_outline_outlined,color: Colors.black,),
          //   title: Text(LocaleKeys.Manage_products.tr(),style: TextStyle(fontWeight:FontWeight.bold,fontSize:18,color: Colors.black),textAlign: TextAlign.center,),
          //   trailing:Icon(Icons.keyboard_arrow_down,color: Colors.black,) ,
          //   children: [
          //     ElevatedButton(
          //       style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
          //       onPressed:()
          //       { Navigator.pushNamed(context, AddProduct1.id,);},
          //       child: Container(
          //           alignment: Alignment.center,
          //           height: 60,
          //           width: MediaQuery.of(context).size.width*.9,
          //           child: Text(LocaleKeys.Adding_is_done.tr(),style: TextStyle(color: Colors.black))),
          //     ),
          //     SizedBox(height: 10,),
          //     ElevatedButton(
          //       style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
          //       onPressed:()
          //       {Navigator.pushNamed(context,ManageProduct.id); },
          //       child: Container(
          //           alignment: Alignment.center,
          //           height: 60,
          //           width: MediaQuery.of(context).size.width*.9,
          //
          //           child: Text(LocaleKeys.Edit.tr(),style: TextStyle(color: Colors.black))),
          //     ),
          //     SizedBox(height: 10,),
          //
          //   ],
          // ),
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
            onPressed:()
            { Navigator.pushNamed(context, AddProduct1.id,);},
            child: Container(
                alignment: Alignment.center,
                height: 60,
                width: MediaQuery.of(context).size.width*.9,
                child: Text(LocaleKeys.Add_Product.tr(),style: TextStyle(fontWeight:FontWeight.bold,fontSize:18,color: Colors.black))),
          ),
          SizedBox(height: 10,),
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
            onPressed:()
            {Navigator.pushNamed(context,ManageProduct.id); },
            child: Container(
                alignment: Alignment.center,
                height: 60,
                width: MediaQuery.of(context).size.width*.9,

                child: Text(LocaleKeys.Manage_products.tr(),style: TextStyle(fontWeight:FontWeight.bold,fontSize:18,color: Colors.black))),
          ),
          SizedBox(height: 10,),

          //Orders
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
            onPressed:() {Navigator.pushNamed(context,OrderScreen.id);},
            child: Container(
                alignment: Alignment.center,
                height: 60,
                width: MediaQuery.of(context).size.width*.9,
                child: Text(LocaleKeys.Manage_orders.tr(),style: TextStyle(fontWeight:FontWeight.bold,fontSize:18,color: Colors.black),)),
          ),
        ],

      ),
    );
    }

}