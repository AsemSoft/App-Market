import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_market/constants.dart';
import 'package:global_market/models/category.dart';
import 'package:global_market/models/product.dart';
import 'package:global_market/screens/admin/editCategory.dart';
import 'package:global_market/services/store.dart';
import 'package:global_market/translations/locale_keys.g.dart';
import 'package:global_market/widgets/customMenu.dart';
import 'package:easy_localization/easy_localization.dart';

class ManageCategory extends StatefulWidget {
  static String id = 'ManageCategory ';
  @override
  _ManageCategoryState createState() => _ManageCategoryState();
}

class _ManageCategoryState extends State<ManageCategory> {
  List<Product> products;
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Category'),
        centerTitle: true,

      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<CategoryModel> _category= [];
              for (var doc in snapshot.data.docs) {
                var data = doc;
                _category.add(CategoryModel(
                  cateName: data[kCateName],
                  cateImg: data[kCateImg],
                  cateId: data.id
                ));
              }
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
                                Navigator.pushNamed(context, EditCategory.id, arguments: _category[index]);
                                print('Clicked');
                              },
                              child: Text('Edit'),
                            ),
                            MyPopupMenuItem(
                              onClick: () {
                                _store.deleteCategory(_category[index].cateId);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم الحذف')));
                                Navigator.pop(context);
                                print('Deleted');
                              },
                              child: Text('Delete'),
                            ),
                          ]);
                    },
                    child: Stack(children: <Widget>[
                      Positioned.fill(
                        child:_category[index].cateImg==null? Image(
                          fit: BoxFit.fill,
                          image: AssetImage(_category[index].cateImg),
                        ):Image.network("${_category[index].cateImg}"),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: 0.8,
                          child: Container(
                            width: MediaQuery.of(context).size.width*.5,
                            height: 60,
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(_category[index].cateName,
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
                itemCount: _category.length,
              );
            } else {
              return Center(child: Text(LocaleKeys.Location.tr()));
            }
          }),
    );

  }

}
