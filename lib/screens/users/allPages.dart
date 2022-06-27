import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:global_market/constants.dart';
import 'package:global_market/models/product.dart';
import 'package:global_market/screens/users/cartScreen.dart';
import 'package:global_market/widgets/productView.dart';

class AllPages extends StatefulWidget {
  static String id = 'AllPages';
  static String titleName="";
  static List brandName=[];
  static String selectedCategory='';

  @override
  _AllPagesState createState() => _AllPagesState();
}
class _AllPagesState extends State<AllPages> {

  int _tabBarIndex = 0;
  List<Product> products=[];

  @override
  Widget build(BuildContext context) {
    var titleName=AllPages.titleName;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            centerTitle: true,
            title: Text(titleName, style: TextStyle(color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold),),
            actions: <Widget>[
              // new IconButton(icon: Icon(Icons.search, color: Colors.white,
              // ),
              //     onPressed: () {}),
              new IconButton(
                  icon: Icon(
                    Icons.shopping_cart,

                  ),
                  onPressed: () {
                    Navigator.pushNamed(context,CartScreen.id);
                  }),
            ],
            bottom: TabBar(
              indicatorColor: kMainColor,
              onTap: (value)
              {
                setState(() {
                  _tabBarIndex = value;
                });
              },
              tabs: <Widget>[
                Text(
                  AllPages.brandName[0],
                  style: TextStyle(
                    color: _tabBarIndex == 0 ? Colors.black : kUnActiveColor,
                    fontSize: _tabBarIndex == 0 ? 13 : null,
                  ),
                ),
                Text(
                  AllPages.brandName[1],
                  style: TextStyle(
                      color:
                      _tabBarIndex == 1 ? Colors.black : kUnActiveColor,
                      fontSize: _tabBarIndex == 1 ? 16 : null),
                ),
                Text(
                  AllPages.brandName[2],
                  style: TextStyle(
                      color:
                      _tabBarIndex == 2 ? Colors.black : kUnActiveColor,
                      fontSize: _tabBarIndex == 2 ? 16 : null),
                ),
                Text(
                  AllPages.brandName[3],
                  style: TextStyle(
                      color:
                      _tabBarIndex == 3 ? Colors.black : kUnActiveColor,
                      fontSize: _tabBarIndex == 3 ? 16 : null),
                ),
              ],
            ),
          ),
            body: TabBarView(
              children: <Widget>[
                productView(AllPages.brandName[0], products),
                productView(AllPages.brandName[1], products),
                productView(AllPages.brandName[2], products),
                productView(AllPages.brandName[3], products),
              ],
            ),
        ),
    );
  }
}



